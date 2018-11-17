! Copyright 2017- LabTerra 

!     This program is free software: you can redistribute it and/or modify
!     it under the terms of the GNU General Public License as published by
!     the Free Software Foundation, either version 3 of the License, or
!     (at your option) any later version.

!     This program is distributed in the hope that it will be useful,
!     but WITHOUT ANY WARRANTY; without even the implied warranty of
!     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
!     GNU General Public License for more details.

!     You should have received a copy of the GNU General Public License
!     along with this program.  If not, see <http://www.gnu.org/licenses/>.

! contacts :: David Montenegro Lapola <lapoladm ( at ) gmail.com> 
!             João Paulo Darela Filho <darelafilho ( at ) gmail.com>


module productivity
  implicit none
  private

  public :: prod


contains
  

  subroutine prod(dt,light_limit,temp,ts,p0,w,&
       ipar,rh,emax,cl1,ca1,cf1,beta_leaf,beta_awood,&
       beta_froot,ph,ar,nppa,laia,f5,f1,vpd,&
       rm,rg,rc,wue) ! outputs
    
    use types
    use global_pars
    use photo
    use water
    
    implicit none  
    !=Variables/Parameters
    !=====================
    !Input
    !-----     
    

    real(kind=r_4),dimension(ntraits),intent(in) :: dt

    real(kind=r_4), intent(in) :: temp,ts              !Mean monthly temperature (oC)
    real(kind=r_4), intent(in) :: p0                   !Mean surface pressure (hPa)
    real(kind=r_4), intent(in) :: w                    !Soil moisture (dimensionless)
    real(kind=r_4), intent(in) :: ipar                 !Incident photosynthetic active radiation (einstein m-2 s-1)'
    real(kind=r_4), intent(in) :: rh,emax              !Relative humidity/MAXIMUM EVAPOTRANSPIRATION
    real(kind=r_4), intent(in) :: cl1, cf1, ca1        !Carbon in plant tissues (kg/m2)
    real(kind=r_4), intent(in) :: beta_leaf            !npp allocation to carbon pools (kg/m2/day)
    real(kind=r_4), intent(in) :: beta_awood
    real(kind=r_4), intent(in) :: beta_froot
    !real(kind=r_4), intent(in) :: ocprod
    logical(kind=l_1), intent(in) :: light_limit                !True for no ligth limitation

    !     Output
    !     ------
    real(kind=r_4), intent(out) :: ph                   !Canopy gross photosynthesis (kgC/m2/yr)
    real(kind=r_4), intent(out) :: rc                   !Stomatal resistence (not scaled to canopy!) (s/m)
    real(kind=r_4), intent(out) :: laia                 !Autotrophic respiration (kgC/m2/yr)
    real(kind=r_4), intent(out) :: ar                   !Leaf area index (m2 leaf/m2 area)
    real(kind=r_4), intent(out) :: nppa                 !Net primary productivity (kgC/m2/yr) 
    real(kind=r_4), intent(out) :: vpd            
    real(kind=r_4), intent(out) :: f5                   !Water stress response modifier (unitless) 
    real(kind=r_4), intent(out) :: rm                   !autothrophic respiration (kgC/m2/day)
    real(kind=r_4), intent(out) :: rg 
    real(kind=r_4), intent(out) :: wue
    !     Internal
    !     --------
    
    real(kind=r_4) :: f1       !Leaf level gross photosynthesis (molCO2/m2/s)
    real(kind=r_4) :: f1a      !auxiliar_f1
    
    real(kind=r_4) :: tleaf             !leaf turnover time (yr)
    real(kind=r_4) :: p21               !Maximum carboxilation rate (micromolC m-2 d-1)
    real(kind=r_4) :: g1
    
    real(kind=r_4) :: sla          !specific leaf area (m2/kg)
    logical(l_1) :: no_cell = .false.
    
    !getting pls parameters

    if(((cl1 .lt. cmin) .and. (cf1 .lt. cmin))) then !  
      ! Then PLS 'Die'
      no_cell = .true.
      goto 999
    endif
        
    !getting pft parameters
    g1  = dt(1)
    p21 = dt(2)
    tleaf = dt(3)
    !call pft_par(2, p21)
    !call pft_par(3, tleaf)
    !call pft_par(1, g1)
    
    !     ==============
    !     Photosynthesis 
    !     ==============
    
    !Rubisco maximum carboxylaton rate (molCO2/m2/s)
    !-----------------------------------------------
    
    f1a = photosynthesis_rate(p21, temp, p0, ipar, light_limit)
     !ipar * 0.5 for considering just the photossintetically active radiation    
    ! VPD
    !========
    vpd = vapor_p_defcit(temp,rh)
    
    !Stomatal resistence
    !===================
    rc = canopy_resistence(vpd, f1a, g1)

    ! Novo calculo da WUE

    wue = water_ue(f1a, rc, p0, vpd)
    
    !     Water stress response modifier (dimensionless)
   !  !     ----------------------------------------------
   !  print *, 'w', w
   !  print *, 'f1a', f1a
   !  print *, 'cf1',cf1
   !  print *, 'rc',rc
   !  print *, 'emax', emax
   !  print *, ' '
   !  print *, ' -------------------- -   -  -  -'
    f5 =  water_stress_modifier(w, cf1, rc, emax)
    
    !     Photosysthesis minimum and maximum temperature
    !     ----------------------------------------------
    
    if ((temp.ge.-10.0).and.(temp.le.50.0)) then
       f1 = f1a * f5 ! :water stress factoF
    else
       f1 = 0.0               !Temperature above/below photosynthesis windown
    endif
    
    
    !     Leaf area index (m2/m2)
    !laia = leaf_area_index(cl1,spec_leaf_area(tleaf(pft)))
     sla = spec_leaf_area(tleaf)
    !  laia = leaf_area_index(cl1*ocprod,sla)
     laia = f_four(90, cl1, sla) + f_four(20, cl1, sla)
 
    !     Canopy gross photosynthesis (kgC/m2/yr)
    !     =======================================x
    ph = gross_ph(f1,cl1,sla)       ! kg m-2 year-1 - gpp

    
    !     Autothrophic respiration
    !     ========================
    !     Maintenance respiration (kgC/m2/yr) (based in Ryan 1991)
    rm = m_resp(temp,ts,cl1,cf1,ca1)
  
    ! c     Growth respiration (KgC/m2/yr)(based in Ryan 1991; Sitch et al.
    ! c     2003; Levis et al. 2004)         
    rg = g_resp(beta_leaf,beta_awood, beta_froot) 
    
    if (rg.lt.0) then
       rg = 0.0
    endif
    
    !     c Autotrophic (plant) respiration -ar- (kgC/m2/yr)
    !     Respiration minimum and maximum temperature
    !     -------------------------------------------     
    if ((temp.ge.-10.0).and.(temp.le.50.0)) then
       ar = rm + rg
    else
       ar = 0.0               !Temperature above/below respiration windown
    endif
    
    !c     -----------------------------------------------------------------
    !     NPP
    !     ============
    !     Productivity
    !     ============
    !     Net primary productivity(kgC/m2/yr)
    !     ====================================
    nppa = ph - ar
  

    if(nppa .lt. 0.0) nppa = 0.0

    no_cell = .false.
   
   999 continue
    if(no_cell) then
      ph = 0.0                   
      rc = 0.0                   
      laia = 0.0                 
      ar = 0.0                   
      nppa = 0.0                  
      vpd = 0.0            
      f5 = 0.0                   
      rm = 0.0             
      rg = 0.0
      wue = 0.0
   endif

  end subroutine prod
  
end module productivity

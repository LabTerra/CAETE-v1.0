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


module budget_caete
  implicit none
  private
  
  public :: budget
  
contains
  
  subroutine budget (dt, month, w1, g1, s1, ts, temp, prec, p0, ipar, rh&
       & ,cl1_pft, ca1_pft, cf1_pft, w2, g2, s2, smavg, ruavg, evavg, epavg&
       & ,phavg, aravg, nppavg, laiavg, clavg, csavg, hravg, rcavg, rmavg, rgavg&
       & ,cleafavg_pft, cawoodavg_pft, cfrootavg_pft, ocpavg, wueavg, cueavg)
    
    use types
    use global_pars
    use photo
    use water
    use productivity
    
    implicit none
    integer(kind=i_4),parameter :: npft = npls
    
    !     ----------------------------INPUTS------------------------------
    ! STATE VARIABLES
    integer(kind=i_4),intent(in) :: month             !Actual month (1-12)
    real(kind=r_4),dimension(ntraits,npft),intent(in) :: dt
    real(kind=r_4),dimension(npft),intent(in) :: w1 !Initial (previous month last day) soil moisture storage (mm)
    real(kind=r_4),dimension(npft),intent(in) :: g1 !Initial soil ice storage (mm)
    real(kind=r_4),dimension(npft),intent(in) :: s1 !Initial overland snow storage (mm)
    real(kind=r_4),dimension(npft),intent(inout) :: cl1_pft  ! initial BIOMASS cleaf compartment
    real(kind=r_4),dimension(npft),intent(inout) :: cf1_pft  !                 froot
    real(kind=r_4),dimension(npft),intent(inout) :: ca1_pft  !                 cawood

    ! INPUT
    real(kind=r_4),intent(in) :: ts                   !Soil temperature (oC)
    real(kind=r_4),intent(in) :: temp                 !Surface air temperature (oC)
    real(kind=r_4),intent(in) :: prec                 !Precipitation (mm/day)
    real(kind=r_4),intent(in) :: p0                   !Surface pressure (mb)
    real(kind=r_4),intent(in) :: ipar                 !Incident photosynthetic active radiation Einsten m-2 s-1 
    real(kind=r_4),intent(in) :: rh                   !Relative humidity
    
    !     ----------------------------OUTPUTS------------------------------
    real(kind=r_4),intent(out) :: epavg                          !Maximum evapotranspiration monthly average (mm/day)
    real(kind=r_4),intent(out),dimension(npft) :: w2             !Final (last day) soil moisture storage (mm)
    real(kind=r_4),intent(out),dimension(npft) :: g2             !Final soil ice storage (mm)
    real(kind=r_4),intent(out),dimension(npft) :: s2             !Final overland snow storage (mm)
    real(kind=r_4),intent(out),dimension(npft) :: smavg          !Snowmelt monthly average (mm/day)
    real(kind=r_4),intent(out),dimension(npft) :: ruavg          !Runoff monthly average (mm/day)
    real(kind=r_4),intent(out),dimension(npft) :: evavg          !Actual evapotranspiration monthly average (mm/day)
    real(kind=r_4),intent(out),dimension(npft) :: phavg          !Monthly photosynthesis
    real(kind=r_4),intent(out),dimension(npft) :: aravg          !Monthly autotrophic respiration
    real(kind=r_4),intent(out),dimension(npft) :: nppavg         !Monthly NPP (average between PFTs)
    real(kind=r_4),intent(out),dimension(npft) :: laiavg         !Monthly leaf area Index
    real(kind=r_4),intent(out),dimension(npft) :: clavg          !Monthly carbon litter
    real(kind=r_4),intent(out),dimension(npft) :: csavg          !Monthly carbon soil
    real(kind=r_4),intent(out),dimension(npft) :: hravg          !Monthly heterotrophic respiration
    real(kind=r_4),intent(out),dimension(npft) :: rcavg          !Monthly canopy resistence
    real(kind=r_4),intent(out),dimension(npft) :: rmavg,rgavg    !maintenance/growth respiration
    real(kind=r_4),intent(out),dimension(npft) :: cleafavg_pft   !Carbon in plant tissues
    real(kind=r_4),intent(out),dimension(npft) :: cawoodavg_pft 
    real(kind=r_4),intent(out),dimension(npft) :: cfrootavg_pft
    real(kind=r_4),intent(out),dimension(npft) :: ocpavg
    real(kind=r_4),intent(out),dimension(npft) :: wueavg,cueavg
    !     -----------------------Internal Variables------------------------
    integer(kind=i_4) :: p ,i
    
    real(kind=r_4),dimension(npft) :: alfa_leaf, alfa_awood, alfa_froot
    real(kind=r_4),dimension(npft) :: beta_leaf, beta_awood, beta_froot

    real(kind=r_4),dimension(ntraits) :: dt1
    
    !     RELATED WITH GRIDCELL OCUPATION
    real(kind=r_4),dimension(npft) :: ocp_coeffs,ocp_mm
    logical(kind=l_1),dimension(npft) :: ocp_wood

    !     WBM COMMUNICATION (water balance)
    real(kind=r_4) :: tsnow                !Temperature threshold for snowfall (oC)
    real(kind=r_4) :: tice                 !Temperature threshold for soil freezing (oC)
    real(kind=r_4) :: psnow                !Snowfall (mm/day)
    real(kind=r_4) :: prain                !Rainfall (mm/day)
    real(kind=r_4) :: emax, vapo
    
    real(kind=r_4),dimension(npft) :: rimelt               !Runoff due to soil ice melting
    real(kind=r_4),dimension(npft) :: smelt                !Snowmelt (mm/day)
    real(kind=r_4),dimension(npft) :: w                    !Daily soil moisture storage (mm)
    real(kind=r_4),dimension(npft) :: g                    !Daily soil ice storage (mm)
    real(kind=r_4),dimension(npft) :: s                    !Daily overland snow storage (mm)
    real(kind=r_4),dimension(npft) :: ds  
    real(kind=r_4),dimension(npft) :: dw  
    real(kind=r_4),dimension(npft) :: roff                 !Total runoff
    real(kind=r_4),dimension(npft) :: evap                !Actual evapotranspiration (mm/day)

        
    !c     Carbon Cycle
    real(kind=r_4),dimension(npft) ::  ph             !Canopy gross photosynthesis (kgC/m2/yr)
    real(kind=r_4),dimension(npft) ::  ar             !Autotrophic respiration (kgC/m2/yr)
    real(kind=r_4),dimension(npft) ::  nppa           !Net primary productivity / auxiliar
    real(kind=r_4),dimension(npft) ::  laia           !Leaf area index (m2 leaf/m2 area)
    real(kind=r_4),dimension(npft) ::  cl             !Litter carbon (kgC/m2)
    real(kind=r_4),dimension(npft) ::  cs             !Soil carbon (kgC/m2) 
    real(kind=r_4),dimension(npft) ::  hr             !Heterotrophic (microbial) respiration (kgC/m2/yr)
    real(kind=r_4),dimension(npft) ::  rc2            !Canopy resistence (s/m)
    real(kind=r_4),dimension(npft) ::  f1             !
    real(kind=r_4),dimension(npft) ::  f5             !Photosynthesis (mol/m2/s)
    real(kind=r_4),dimension(npft) ::  vpd            !Vapor Pressure deficit
    real(kind=r_4),dimension(npft) ::  rm             ! maintenance & growth a.resp
    real(kind=r_4),dimension(npft) ::  rg
    real(kind=r_4),dimension(npft) ::  wue, cue
    real(kind=r_4),dimension(npft) ::  cl1,cf1,ca1 ! carbon pre-allocation 
    real(kind=r_4),dimension(npft) ::  cl2,cf2,ca2 ! carbon pos-allocation
    logical(kind=l_1) :: end_pls = .false., no_cell = .false.
    !real(kind=r_4) :: ocp = 0
    real(kind=r_4) :: ae
    real(kind=r_4) :: water1
    real(kind=r_4) :: ice1
    real(kind=r_4) :: snow1

    do p = 1,npft
       rc2(p) = 0.0
       f1(p)  = 0.0
       f5(p) = 0.0
    enddo

    tsnow = -1.0
    tice  = -2.5
    
    !     Precipitation
    !     =============     
    psnow = 0.0
    prain = 0.0
    if (temp .lt. tsnow) then
       psnow = prec/real(ndmonth(month))
    else
       prain = prec/real(ndmonth(month))
    endif

   !print *, "prain", prain
    
    !     Initialization
    !     --------------
    epavg = 0.0
    do p = 1,npft
      ! print *, 'w1', w1(p), 'p', p
      ! print *, 'g1', g1(p), 'p', p
      ! print *, 's1', s1(p), 'p', p

       w(p)       = w1(p)     ! hidrological pools state vars  
       g(p)       = g1(p)
       s(p)       = s1(p)
       smavg(p)   = 0.0       ! accumulators for i days of month m for pft p
       ruavg(p)   = 0.0
       evavg(p)   = 0.0
       rcavg(p)   = 0.0
       laiavg(p)  = 0.0
       phavg(p)   = 0.0
       aravg(p)   = 0.0
       nppavg(p)  = 0.0
       clavg(p)   = 0.0
       csavg(p)   = 0.0
       hravg(p)   = 0.0
       rmavg(p)   = 0.0
       rgavg(p)   = 0.0
       ocpavg(p)  = 0.0
       wueavg(p)  = 0.0
       cueavg(p)  = 0.0 
       ocp_mm(p)  = 0.0
       
       alfa_leaf(p) = 1e-3
       alfa_awood(p) = 1e-3
       alfa_froot(p) = 1e-3
    enddo
    


    !     Numerical integration
    !     ---------------------
    do i=1,ndmonth(month)
       emax  = 0.0
       
       !cl1 = cl1_pft
       !ca1 = ca1_pft
       !cf1 = cf1_pft
       
       beta_leaf = alfa_leaf
       beta_awood = alfa_awood
       beta_froot = alfa_froot
       
       nppa  = 0.0
       ph    = 0.0
       ar    = 0.0
       laia  = 0.0
       f5    = 0.0
       f1    = 0.0
       vpd   = 0.0
       rc2   = 0.0
       rm    = 0.0
       rg    = 0.0 
       wue   = 0.0
       cue   = 0.0
       
       !     Grid cell area fraction (%) ocp_coeffs(pft(1), pft(2), ...,pft(p))
       !     =================================================================     
       call pft_area_frac(cl1_pft, cf1_pft, ca1_pft, ocp_coeffs, ocp_wood) ! def in funcs.f90
       
       !     Maximum evapotranspiration   (emax)
       !     =================================
       ae = 2.895 * temp + 52.326 !from NCEP-NCAR Reanalysis data
       emax = evpot2(p0, temp, rh, ae)
       !print *, 'emax', emax
       
       !     Productivity (ph, aresp, vpd, rc2 & etc.) for each PFT
       !     =================================
       do p = 1,npft
          end_pls = .false.
          dt1 = dt(:,p)
          !ocp = ocp_coeffs(p)

          call prod(dt1,OCP_WOOD(P),temp,ts,p0,w(p)&
               &,ipar,rh,emax,cl1_pft(p),ca1_pft(p),cf1_pft(p),beta_leaf(p)&
               &,beta_awood(p),beta_froot(p),ph(p),ar(p),nppa(p)&
               &,laia(p),f5(p),f1(p),vpd(p),rm(p),rg(p),rc2(p),wue(p))
          
          
          !c     Carbon allocation (carbon content on each compartment)
          !     =====================================================
          call allocation (dt1, nppa(p), cl1_pft(p), ca1_pft(p),cf1_pft(p),cl2(p),&
               & ca2(p), cf2(p), end_pls)!, dl(p)) 
          
          if(end_pls) then
             no_cell = .true.
             alfa_leaf(p) = 0.0
             alfa_awood(p) = 0.0
             alfa_froot(p) = 0.0
             goto 666 ! gt hell
          endif 

          if(ph(p) .gt. 0.0) then
             cue(p) = nppa(p)/ph(p)
          else
             cue(p) = 0.0
          endif

          alfa_leaf(p)  = cl2(p) - cl1_pft(p) ! kg m-2
          alfa_awood(p) = ca2(p) - ca1_pft(p)
          alfa_froot(p) = cf2(p) - cf1_pft(p)
          
          !     Snow budget
          !     ===========     
          smelt(p) = 2.63 + 2.55* temp + 0.0912 * temp * prain !Snowmelt (mm/day)
          smelt(p) = amax1(smelt(p),0.)
          smelt(p) = amin1(smelt(p), s(p) + psnow)
          ds(p) = psnow - smelt(p)
          s(p) = s(p) + ds(p)
          
          !     Water budget
          !     ============
          if (ts.le.tice) then !Frozen soil
             g(p) = g(p) + w(p) !Soil moisture freezes
             w(p) = 0.0
             roff(p) = smelt(p) + prain !mm/day
             evap(p) = 0.0
             ph(p) = 0.0
             ar(p) = 0.0
             nppa(p) = 0.0
             laia(p) = 0.0
             cl(p) = 0.0
             cs(p) = 0.0
             hr(p) = 0.0
             rc2(p) = rcmin
             rm(p) = 0.0
             rg(p) = 0.0
             ! colocar as outras vars da prod aqui??
             
          else                !Non-frozen soil
             w(p) = w(p) + g(p)
             g(p) = 0.0
             rimelt(p) = 0.0
             if (w(p).gt.wmax) then
                rimelt(p) = w(p) - wmax !Runoff due to soil ice melting
                w(p) = wmax
             endif
             
             roff(p) = runoff(w(p)/wmax)       !Soil moisture runoff (roff, mm/day)
             
             evap(p) = penman(p0, temp, rh, ae, rc2(p)) !Actual evapotranspiration (evap, mm/day)
             vapo = amin1(emax,evap(p))
             !evap(p) = vapo
             dw(p) = prain + smelt(p) - evap(p) - roff(p)
             w(p) = w(p) + dw(p)
             if (w(p).gt.wmax) then
                roff(p) = roff(p) + (w(p) - wmax)
                w(p) = wmax
             endif
             if (w(p).lt.0.) w(p) = 0.
             roff(p) = roff(p) + rimelt(p) !Total runoff
          endif

             !     Carbon cycle (Microbial respiration, litter and soil carbon)
             !     ============================================================     
          call carbon2 (ts,f5(p),evap(p),laia(p),cl(p),cs(p),hr(p))   
          
          !     Accumulate daily budgets weighted by occupation coefficients
          
          ocp_mm(p) = ocp_mm(p) + ocp_coeffs(p)
          
          ! epavg = epavg + (emax / real(npft, r_4)) !mm/day
          smavg(p) = smavg(p) + smelt(p)
          ruavg(p) = ruavg(p) + roff(p) * ocp_coeffs(p) ! mm day-1
          evavg(p) = evavg(p) + evap(p) * ocp_coeffs(p)  ! mm day-1
          rcavg(p) = rcavg(p) + rc2(p) * ocp_coeffs(p) ! s m -1
          
          phavg(p) = phavg(p) + ph(p) * ocp_coeffs(p)   !kgC/m2/day
          aravg(p) = aravg(p) + ar(p) * ocp_coeffs(p)   !kgC/m2/year
          nppavg(p) = nppavg(p) + nppa(p) * ocp_coeffs(p) !kgC/m2/day
          wueavg(p) = wueavg(p) + wue(p) * ocp_coeffs(p)
          cueavg(p) = cueavg(p) + cue(p) * ocp_coeffs(p)
          
          laiavg(p) = laiavg(p) + laia(p) * ocp_coeffs(p)
          clavg(p) = clavg(p) + cl(p) !* ocp_coeffs(p) !kgC/m2/day
          csavg(p) = csavg(p) + cs(p) !* ocp_coeffs(p) !kgC/m2/day
          hravg(p) = hravg(p) + hr(p) !* ocp_coeffs(p) !kgC/m2/day
          rmavg(p) = rmavg(p) + (rm(p) * ocp_coeffs(p))
          rgavg(p) = rgavg(p) + (rg(p) * ocp_coeffs(p))
          cleafavg_pft(p)  =  cl2(p)
          cawoodavg_pft(p) =  ca2(p)
          cfrootavg_pft(p) =  cf2(p)
          cl1_pft(p) = cl2(p)     ! Adicionado ------ para fazer transforcaoes diarias
          ca1_pft(p) = ca2(p)     ! Adicionado ------ para fazer transforcaoes diarias
          cf1_pft(p) = cf2(p)     ! Adicionado ------ para fazer transforcaoes diarias
          no_cell = .false.

666    continue
           if(no_cell) then
            ! All*** outputs are set to zero except epavg
             epavg = 0.0
             smavg(p) = 0.0
             ruavg(p) = 0.0
             evavg(p) = 0.0
             rcavg(p) = 0.0
             phavg(p) = 0.0
             aravg(p) = 0.0
             nppavg(p) = 0.0
             wueavg(p) = 0.0
             cueavg(p) = 0.0
             laiavg(p) = 0.0
             clavg(p) = 0.0
             csavg(p) = 0.0
             hravg(p) = 0.0
             rmavg(p) = 0.0
             rgavg(p) = 0.0
             ocpavg(p) = 0.0
             cleafavg_pft(p)  = 0.0
             cawoodavg_pft(p) = 0.0
             cfrootavg_pft(p) = 0.0
             cl1_pft(p) = 0.0
             ca1_pft(p) = 0.0
             cf1_pft(p) = 0.0
            !  w2(p) = 0.0
            !  g2(p) = 0.0
            !  s2(p) = 0.0
           endif
       enddo                  ! end pls loop 
       epavg = epavg + emax
    enddo                     ! end ndmonth loop
    
    !     Final calculations
    !     ------------------
    !     monthly values
    ! New Vars to store water
    water1 = sum(w * ocp_coeffs)
    ice1 = sum(g * ocp_coeffs)
    snow1 = sum(s * ocp_coeffs)

    epavg = epavg/real(ndmonth(month))

    do p=1,npft
       if (ocp_coeffs(p) .gt. 0.0) then
         w2(p) = water1
         g2(p) = ice1
         s2(p) = snow1
       else 
         w2(p) = 0.0
         g2(p) = 0.0
         s2(p) = 0.0
       endif 
       smavg(p)  = smavg(p)/real(ndmonth(month))
       ruavg(p)  = ruavg(p)/real(ndmonth(month))
       evavg(p)  = evavg(p)/real(ndmonth(month))
       rcavg(p)  = rcavg(p)/real(ndmonth(month))
       wueavg(p) = wueavg(p)/real(ndmonth(month))
       cueavg(p) = cueavg(p)/real(ndmonth(month))
       laiavg(p) = laiavg(p)/real(ndmonth(month))
       ! laiavg(p) = (laiavg(p)/365.0) * 12.0
       ! laiavg(p) = (laiavg(p)/365.0) * 12.0       
       phavg(p)  = (phavg(p)/365.0)  * 12.0 !kgC/m2/yr
       aravg(p)  = (aravg(p)/365.0)  * 12.0   !kgC/m2/yr
       nppavg(p) = (nppavg(p)/365.0) * 12.0 !kgC/m2/yr
       clavg(p)  = (clavg(p)/365.0)  * 12.0 !kgC/m2
       csavg(p)  = (csavg(p)/365.0)  * 12.0 !kgC/m2
       hravg(p)  = (hravg(p)/365.0)  * 12.0 !kgC/m2/yr
       rmavg(p)  = (rmavg(p)/365.0)  * 12.0 
       rgavg(p)  = (rgavg(p)/365.0)  * 12.0
       ocpavg(p) = ocp_coeffs(p) * 100.
    enddo
    return
  end subroutine budget
  
end module budget_caete

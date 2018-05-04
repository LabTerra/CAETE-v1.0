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

module photo
  
  ! Module defining functions related with CO2 assimilation and other processes in CAETE
  ! These functions are based in CPTEC-PVM2
  
  implicit none
  private

  ! functions defined here
  public ::                    &
       gross_ph               ,& ! gross photosynthesis (kgC m-2 y-1)
       leaf_area_index        ,& ! leaf area index(m2 m-2) 
       f_four                 ,& ! auxiliar function (calculates f4sun or f4shade or sunlai) 
       spec_leaf_area         ,& ! specific leaf area (m2 g-1)
       water_stress_modifier  ,& ! F5 - water stress modifier (dimensionless)
       photosynthesis_rate    ,& ! leaf level CO2 assimilation rate (molCO2 m-2 s-1)
       canopy_resistence      ,& ! Canopy resistence (from Medlyn et al. 2011a) (s/m) == m s-1
       vapor_p_defcit         ,& ! Vapor pressure defcit  (kPa)
       tetens                 ,& ! Maximum vapor pressure (hPa)
       m_resp                 ,& ! maintenance respiration (plants)
       g_resp                 ,& ! growth Respiration (kg m-2 yr-1)
       carbon2                ,& ! soil + litter + heterothrophic respiration
       pft_area_frac          ,& ! area fraction by biomass
       pft_par                ,& ! aux subroutine to read pls data
       pft_par2               ,&
       spinup3                 ,&
       spinup                 ,&
       ascii2bin              ,&
       ascii2bin2             ,&
       allocation             ,&
       test_dt                ,&
       water_ue               ,&
       leap       
contains

  !=================================================================
  !=================================================================

  function gross_ph(f1,cleaf,sla) result(ph)
    ! Returns gross photosynthesis rate (kgC m-2 y-1) 
    use types, only: r4
    implicit none

    real(kind=r4),intent(in) :: f1    !mol(CO2) m-2 s-1 ≃ 1 cm s-1 == 100 mm s-1    
    real(kind=r4),intent(in) :: cleaf !kgC m-2 
    real(kind=r4),intent(in) :: sla   !m2 kgC-1
    real(kind=r4) :: ph
    
    real(kind=r4) :: f4sun
    real(kind=r4) :: f4shade
    
    f4sun = f_four(1,cleaf,sla)
    f4shade = f_four(2,cleaf,sla)
    ph = 0.012*31557600.0*f1*f4sun*f4shade
    
  end function gross_ph
  
  !=================================================================
  !=================================================================
  
  function leaf_area_index(cleaf,sla) result(lai)
    ! Returns Leaf Area Index m2 m-2
    
    use types, only: r4
    implicit none
    
    real(kind=r4),intent(in) :: cleaf !kgC m-2 
    real(kind=r4),intent(in) :: sla   !m2 kgC-1
    real(kind=r4) :: lai
    
    
    lai  = (cleaf * 1e3) * sla 
   
  end function leaf_area_index
  
  !=================================================================
  !=================================================================
  
  function f_four(fs,cleaf,sla) result(lai_ss)
    use types, only: i4, r4, r8
    use photo_par, only: p26, p27
    implicit none
    
    integer(kind=i4),intent(in) :: fs !function mode 1 == f4sun; 2 == f4shade; >2 == f4
    
    real(kind=r4),intent(in) :: cleaf ! carbon in leaf (kg m-2)
    real(kind=r4),intent(in) :: sla   ! specific leaf area (m2 kgC-1)
    real(kind=r4) :: lai_ss           ! leaf area index (m2 m-2)
    
    real(kind=r4) :: lai
    real(kind=r8) :: sunlai
    real(kind=r8) :: shadelai
    
    lai = leaf_area_index(cleaf,sla)
    
    sunlai = (1.0-(exp(-p26*lai)))/p26
    lai_ss = real(sunlai,r4)
    if (fs .eq. 90) then
        return
    endif

    shadelai = lai - sunlai
    if (fs .eq. 20) then
        lai_ss = real(shadelai, kind=r4)
        return
    endif
    
    !Scaling-up to canopy level (dimensionless)
    !------------------------------------------
    lai_ss = real(sunlai,r4)  ! to be used for heterothrophic respiration
    
    if(fs .eq. 3) then 
       return
    endif
   
    !Sun/Shade approach to canopy scaling !Based in de Pury & Farquhar (1997)
    !------------------------------------------------------------------------
    if(fs .eq. 1) then
       ! f4sun
       lai_ss = real((1.0-(exp(-p26*sunlai)))/p26,r4) !sun 90 degrees
       return
    endif
    
    if(fs .eq. 2) then
       !f4shade
       lai_ss = real((1.0-(exp(-p27*shadelai)))/p27,r4) !sun ~20 degrees
       return
    endif
  end function f_four
 
  !=================================================================
  !================================================================= 
  
  function spec_leaf_area(tau_leaf) result(sla)
    ! based on JeDi DGVM 
    use types, only : r4
    implicit none
    
    real(kind=r4),intent(in) :: tau_leaf  !KgC m-2 y-1
    real(kind=r4) :: sla   !m2 kgC-1
    
    real(kind=r4) :: leaf_t_months
    real(kind=r4) :: leaf_t_coeff
    real(kind=r4) :: leaf_turnover
    
    leaf_t_months = tau_leaf*12. ! turnover time in months
    leaf_t_coeff = leaf_t_months/100. !1 - 100 months == ~ 1/12 to 8.3 years (TRY-kattge et al. 2011; Jedi-Pavlick 2012) 
!<<<<<<< HEAD
!    leaf_turnover =  (365.0/12.0) * exp(1.8*leaf_t_coeff)
!=======
!>>>>>>> 2ca26587106701e0883c85ea235c431dcb9ee97b
    leaf_turnover =  (365.0/12.0) * (10 ** (2.0*leaf_t_coeff))
    sla = (3e-2 * (365.0/leaf_turnover)**(-0.46))     
    
  end function spec_leaf_area
  
  !=================================================================
  !=================================================================
  
  function water_stress_modifier(w, cfroot, rc, ep) result(f5)
    use types, only: r4, r8
    use global_pars, only: csru, wmax, alfm, gm, rcmin
    implicit none
    
    real(kind=r4),intent(in) :: w      !soil water mm
    real(kind=r4),intent(in) :: cfroot !carbon in fine roots kg m-2
    real(kind=r4),intent(in) :: rc     !Canopy resistence 1/(micromol(CO2) m-2 s-1)
    real(kind=r4),intent(in) :: ep     !potential evapotranspiration
    real(kind=r4) :: f5
    
    
    real(kind=r8) :: pt
    real(kind=r8) :: gc
    real(kind=r8) :: wa
    real(kind=r8) :: d
    real(kind=r8) :: f5_64
    
    wa = w/wmax
    
    pt = csru*(cfroot*1000.)*wa  !(based in Pavlick et al. 2013; *1000. converts kgC/m2 to gC/m2)
    if(rc .gt. 0.0) then
       gc = (1.0/(rc * 1.15741e-08))  ! s/m
    else
       gc =  1.0/(rcmin * 1.15741e-08) ! BIANCA E HELENA - Mudei este esquema..   
    endif                     ! tentem entender o algoritmo
    
    !d =(ep * alfm) / (1. + gm/gc) !(based in Gerten et al. 2004)
    d = (ep * alfm) / (1. + (gm/gc))
    if(d .gt. 0.0) then
       f5_64 = pt/d
       f5_64 = exp(-0.06 * f5_64)
       f5_64 = 1.0 - f5_64
    else
       f5_64 = wa
    endif
   
    if(f5_64 .lt. 0.0) f5_64 = wa
    f5 = real(f5_64,4)      
  end function water_stress_modifier

  !=================================================================
  !=================================================================
    
  function canopy_resistence(vpd_in,f1_in,g1) result(rc2_in)
    ! return stomatal resistence based on Medlyn et al. 2011a
    ! Coded by Helena Alves do Prado & João Paulo Darela Filho

    use types, only: r4 ,r8
    use global_pars, only: ca


    !implicit none

    real(r4),intent(in) :: f1_in    !Photosynthesis (molCO2/m2/s)
    real(r4),intent(in) :: vpd_in   !hPa
    real(r4),intent(in) :: g1       ! model m (slope) (sqrt(kPa))
    real(r4) :: rc2_in              !Canopy resistence (sm-1)

    !     Internal
    !     --------
    real(r8) :: gs       !Canopy conductance (molCO2 m-2 s-1)
    real(r8) :: D1       !sqrt(kPA)

    ! Assertion
    if(vpd_in .le. 0.0) then
      print *, 'vpd less than zero in canopy_resistence'
      stop
    endif

    D1 = sqrt(vpd_in)
    gs = 0.001 + 1.6 * (1.0 + (g1/D1)) * ((f1_in * 1e6)/ca)
    rc2_in = real(1/(gs/41.0), r4)  ! transform µmol m-2 s-1 to s m-1 
  end function canopy_resistence
  
  !=================================================================
  !=================================================================
  
!   function canopy_resistence(vpd_in,f1_in,g1) result(rc2_in)
!     ! return stomatal resistence based on Medlyn et al. 2011a
!     use types, only: r4 ,r8
!     use global_pars, only: ca, rcmax, rcmin
    
!     implicit none
    
!     real(kind=r4),intent(in) :: f1_in    !Photosynthesis (molCO2/m2/s)
!     real(kind=r4),intent(in) :: vpd_in   !hPa
!     real(kind=r4),intent(in) :: g1      
!     real(kind=r4) :: rc2_in              !Canopy resistence (s/m)
    
!     !     Internal
!     !     --------
!     real(kind=r8) :: f1b      !Photosynthesis (µmolCO2/m2/s)
!     real(kind=r8) :: gs2      !Canopy conductance (s/m)
!     real(kind=r8) :: gs       !Canopy RESISTENCE (molCO2/m2/s)
!     real(kind=r8) :: g0       !MINIMUM stomatal conductance FITTED PARAMETER (DIMENSIONLESS)
!     real(kind=r8) :: D1       !kPA
!     real(kind=r8) :: aa
    
!     f1b = f1_in * 1e6        ! mol 2 µmol : conversion factor = 1e6
!     aa = f1b / ca              
!     g0 = 0.001           
    
!     if(f1_in .le. 0.0) then 
!        rc2_in = rcmax
!        return
!     endif
!     if(vpd_in .gt. 0.1) then
!        goto 10
!     else
!        rc2_in = rcmin
!        return
!     endif
! 10  continue
!     if (vpd_in .gt. 2.3) then
!        rc2_in = rcmax
!        return
!     else
!        D1 = sqrt(vpd_in) 
!        gs = g0 + 1.6 * (1. + (g1/D1)) * (aa) !Based on Medlyn et al. 2011
!        if(gs .le. 0.0) then
!           rc2_in = rcmax
!           return
!        endif
!     endif
!     gs2 = (gs/41.)
!     if(gs2 .le. 0.0) rc2_in = rcmax
!     if(gs2 .gt. 0.0) rc2_in = real((gs2**(-1)),4)
!     if(rc2_in .lt. rcmin) rc2_in = rcmin
!     if(rc2_in .gt. rcmax) rc2_in = rcmax
!   end function canopy_resistence
  
  !=================================================================
  !=================================================================

  function water_ue(a, g, p0, vpd) result(wue)
    use types, only: r4
    implicit none

    real(kind=r4),intent(in) :: a, g, p0, vpd
    ! a = assimilacao; g = condutancia; p0 = pressao atm; vpd = vpd
    real(kind=r4) :: wue

    real(kind=r4) :: g_in, p0_in, e_in
    
    g_in = (1./g) * 41. ! convertendo a resistencia em condutancia mol m-2 s-1
    p0_in = p0 /10. ! convertendo pressao atm (mbar/hPa) em kPa
    e_in = g_in * (vpd/p0_in) ! calculando transpiracao
    
    wue = a/e_in
 end function water_ue
    
  !=================================================================
  !=================================================================

  function vapor_p_defcit(t,rh) result(vpd_0)
    use types, only: r4
    implicit none
    
    real(kind=r4),intent(in) :: t
    real(kind=r4),intent(in) :: rh
    
    real(kind=r4) :: es
    real(kind=r4) :: vpd_ac
    real(kind=r4) :: vpd_0
    
    ! ext func
    !real(kind=r4) :: tetens
    
    es = tetens(t)  
    !VPD-REAL = Actual vapor pressure
    vpd_ac = es * rh       ! RESULT in hPa == mbar! we want kPa (DIVIDE by 10.)
    !Vapor Pressure Deficit
    vpd_0 = (es - vpd_ac) / 10.
  end function vapor_p_defcit

  !=================================================================
  !=================================================================
  
  function photosynthesis_rate(vm,temp,p0,ipar,ll) result(f1ab)
    !returns instantaneous photosynthesis rate at leaf level (molCO2/m2/s)
    use types
    use global_pars
    use photo_par
    implicit none
    
    real(kind=r4),intent(in) :: vm
    real(kind=r4),intent(in) :: temp
    real(kind=r4),intent(in) :: p0
    real(kind=r4),intent(in) :: ipar
    logical(kind=l1),intent(in) :: ll
    real(kind=r4) :: f1ab
        

    real(kind=r8) :: f2,f3            !Michaelis-Menten CO2/O2 constant (Pa)
    real(kind=r8) :: mgama,vm_in           !Photo-respiration compensation point (Pa)
    real(kind=r8) :: rmax, r
    real(kind=r8) :: ci
    real(kind=r8) :: jp1
    real(kind=r8) :: jp2
    real(kind=r8) :: jp
    real(kind=r8) :: jc
    real(kind=r8) :: jl
    real(kind=r8) :: je
    real(kind=r8) :: b,c,c2,b2,es,j1,j2
    real(kind=r8) :: delta, delta2,aux_ipar
    real(kind=r8) :: f1a
    
    !============================================================
    vm_in = (vm*2.0**(0.1*(temp-25.0)))/(1.0+exp(0.3*(temp-36.0))) 
    
    !Photo-respiration compensation point (Pa)
    mgama = p3/(p8*(p9**(p10*(temp-p11))))
    
    !Michaelis-Menten CO2 constant (Pa)     
    f2 = p12*(p13**(p10*(temp-p11)))
    
    !Michaelis-Menten O2 constant (Pa)
    f3 = p14*(p15**(p10*(temp-p11)))

    !Saturation vapour pressure (hPa)
    es = real(tetens(temp), kind=r8)
    
    !Saturated mixing ratio (kg/kg)     
    rmax = 0.622*(es/(p0-es))
    
    !Moisture deficit at leaf level (kg/kg)    
    r = -0.315*rmax
    
    !Internal leaf CO2 partial pressure (Pa)
    ci = p19* (1.-(r/p20)) * ((ca/9.901)-mgama) + mgama
    !==============================================================
    
    !Rubisco carboxilation limited photosynthesis rate (molCO2/m2/s)
    jc = vm_in*((ci-mgama)/(ci+(f2*(1.+(p3/f3)))))
    
    !Light limited photosynthesis rate (molCO2/m2/s)  
    if (ll) then
       aux_ipar= ipar * 1.0  
    else
       aux_ipar = ipar - (ipar * 0.20)
    endif
    jl = p4*(1.0-p5)*aux_ipar*((ci-mgama)/(ci+(p6*mgama)))
    
    ! Transport limited photosynthesis rate (molCO2/m2/s) (RuBP) (re)generation
    ! ---------------------------------------------------
    je = p7*vm_in
    
    !Jp (minimum between jc and jl)
    !------------------------------
    b = (-1.)*(jc+jl)
    c = jc*jl
    delta = (b**2)-4.0*a*c
    if(delta .eq. 0.0)then
       jp = (-b) / (2 * a)
    else if(delta .gt. 0.0) then
       jp1 = (-b-(sqrt(delta)))/(2.0*a)
       jp2 = (-b+(sqrt(delta)))/(2.0*a)
       jp = amin1(jp1,jp2)
    else
       jp = 0.0
    endif
    
    
    !Leaf level gross photosynthesis (minimum between jc, jl and je)
    !---------------------------------------------------------------
    b2 = (-1.)*(jp+je)
    c2 = jp*je
    delta2 = (b2**2)-4.0*a2*c2
    if(delta2 .eq. 0.0)then
       f1a = (-b2) / (2.0 * a2)
    else if(delta2 .gt. 0.0) then
       j1 = (-b2-(sqrt(delta2)))/(2.0*a2)
       j2 = (-b2+(sqrt(delta2)))/(2.0*a2)
       f1a = amin1(j1,j2)
    else
       f1a = 0.0
    endif

   f1ab = real(f1a,kind=r4)
    
  end function photosynthesis_rate

  !=================================================================
  !=================================================================
  
  function tetens(t) result(es)
    ! returns Saturation Vapor Pressure (hPa), using Buck equation
    
    ! buck equation...references:
    ! http://www.hygrometers.com/wp-content/uploads/CR-1A-users-manual-2009-12.pdf
    ! Hartmann 1994 - Global Physical Climatology p.351
    ! https://en.wikipedia.org/wiki/Arden_Buck_equation#CITEREFBuck1996
    
    use types, only: r4
    implicit none
    
    real(kind=r4),intent( in) :: t
    real(kind=r4) :: es
    
    if (t .ge. 0.) then
       es = 6.1121 * exp((18.678-(t/234.5))*(t/(257.14+t))) ! mbar == hPa
       return
    else
       es = 6.1115 * exp((23.036-(t/333.7))*(t/(279.82+t))) ! mbar == hPa
       return
    endif
    
  end function tetens


  !====================================================================
  !====================================================================

  
  function m_resp(ts,temp,cl1,cf1,ca1) result(rm)
    use types, only: r4,r8
    use global_pars, only: ncl,ncf,ncs
    implicit none

    real(kind=r4), intent(in) :: temp
    real(kind=r4), intent(in) :: ts
    real(kind=r4), intent(in) :: cl1
    real(kind=r4), intent(in) :: cf1
    real(kind=r4), intent(in) :: ca1
    real(kind=r4) :: rm
    
    real(kind=r8) :: csa, rm64, rml64, rmf64, rms64
    
    !   Autothrophic respiration
    !   ========================
    !   Maintenance respiration (kgC/m2/yr) (based in Ryan 1991)

    csa= 0.05 * (ca1)           !sapwood carbon content (kgC/m2). 5% of woody tissues (Pavlick, 2013)

!<<<<<<< HEAD
!<<<<<<< HEAD
!    rml64 = ((ncl * cl1) * 27. * exp(0.07*temp))/1e3
! 
!    rmf64 = ((ncf * cf1) * 27. * exp(0.07*temp))/1e3
!
!    rms64 = ((ncs * csa) * 27. * exp(0.07*temp))/1e3
!=======
!=======
!>>>>>>> 2ca26587106701e0883c85ea235c431dcb9ee97b

    rml64 = ((ncl * (cl1 * 1e3)) * 27. * exp(0.07*temp))
 
    rmf64 = ((ncf * (cf1 * 1e3)) * 27. * exp(0.07*ts))

    rms64 = ((ncs * (csa * 1e3)) * 27. * exp(0.07*temp))
!<<<<<<< HEAD
!>>>>>>> 2ca26587106701e0883c85ea235c431dcb9ee97b
!=======
!>>>>>>> 2ca26587106701e0883c85ea235c431dcb9ee97b

    rm64 = (rml64 + rmf64 + rms64)/1e3

    rm = real(rm64,kind=r4)

    if (rm.lt.0) then
       rm = 0.0
    endif

  end function m_resp

  !====================================================================
  !====================================================================
  
  function g_resp(beta_leaf1,beta_awood1, beta_froot1) result(rg)
    use types, only: r4,r8
    implicit none

    real(kind=r4), intent(in) :: beta_leaf1
    real(kind=r4), intent(in) :: beta_froot1
    real(kind=r4), intent(in) :: beta_awood1
    real(kind=r4) :: rg
    
    real(kind=r8) :: csai, rg64, rgl64, rgf64, rgs64
    real(kind=r4) :: beta_leaf, beta_awood, beta_froot
    
    !     Autothrophic respiration
    !     Growth respiration (KgC/m2/yr)(based in Ryan 1991; Sitch et al.
    !     2003; Levis et al. 2004)         
    if(beta_leaf1 .le. 0.0) then
       beta_leaf = 0.0
    else
       beta_leaf = beta_leaf1
    endif
   
    if(beta_froot1 .le. 0.0) then
       beta_froot = 0.0
    else
       beta_froot = beta_froot1
    endif

    if(beta_awood1 .lt. 0.0) then
       beta_awood = 0.0
    else
       beta_awood = beta_awood1
    endif

    csai =  (beta_awood * 0.05)
   
    rgl64 = 1.25 * beta_leaf  
    rgf64 =  1.25 * beta_froot 
    rgs64 =  1.25 * csai 
!=======
    
    rg64 = (rgl64 + rgf64 + rgs64)/1e3

    rg = real(rg64,kind=r4)
    
    if (rg.lt.0) then
       rg = 0.0
    endif
    
  end function g_resp
  
  !====================================================================
  !====================================================================
  
  subroutine carbon2 (tsoil,f5c,evap,laia,cl,cs,hr)
    use types
    use global_pars
    use photo_par
    implicit none
    !     Variables
    !     =========
    !     Inputs
    !     ------
    real(kind=r4),intent(in) :: tsoil                !Mean monthly soil temperature (oC)
    real(kind=r4),intent(in) :: f5c                  !Stress response to soil moisture (dimensionless)
    real(kind=r4),intent(in) :: evap                 !Actual evapotranspiration (mm/day)
    real(kind=r4),intent(in) :: laia
    !real(kind=r4),intent(in) :: d_litter
    !     Outputs 
    !     -------
    real(kind=r4),intent(out) :: cl                   !Litter carbon (kgC/m2)
    real(kind=r4),intent(out) :: cs                   !Soil carbon (kgC/m2)
    real(kind=r4),intent(out) :: hr                   !Heterotrophic (microbial) respiration (kgC/m2)
    
    !     Internal
    !     --------
    real(kind=r8) :: lf                   !Litterfall (kgC/m2)
    real(kind=r8) :: f6                   !Litter decayment function
    real(kind=r8) :: f7                   !Soil carbon storage function
    !     
    !     Initialize
    !     ----------
    !     
    lf  = 0.0
    f6  = 0.0
    f7  = 0.0
    cl  = 0.0
    cs  = 0.0
    
    !     Litter decayment function                                             !Controlled by annual evapotranspiration
    !     -------------------------
    f6 = 1.16*10.**(-1.4553+0.0014175*(evap*365.0))
    
    !     Soil carbon storage function                                          !Controlled by temperature
    !     ----------------------------    
    f7 = p32**(p10*(tsoil-p11))
    
    !     Litterfall (kgC/m2)
    !     ------------------
    lf = p33 * laia ! + d_litter)
    
    !     Litter carbon (kgC/m2)
    !     ----------------------  
    cl = real(lf/f6, kind=r4)
    
    !     Soil carbon(kgC/m2)
    !     -------------------
    cs = real(((p34*cl)/(p35*f7))*f5c, kind=r4)
    
    !     Respiration minimum and maximum temperature
    !     -------------------------------------------
    !     
    if ((tsoil.ge.-10.0).and.(tsoil.le.50.0)) then
       hr = real(p36*(cl*(f6**2)+(cs*f5c*evap*(f7**2))),kind=r4) !Litter and Soil!respectively
    else
       hr = 0.0               !Temperature above/below respiration windown
    endif
  
  end subroutine carbon2
  
  !====================================================================
  !====================================================================
  
  subroutine pft_area_frac(cleaf1, cfroot1, cawood1, ocp_coeffs, ocp_wood)
    use types, only: l1, i4, r4
    use global_pars, only: npls,cmin
    implicit none
    
    integer(kind=i4),parameter :: npft = npls ! plss futuramente serao
    
    real(kind=r4),dimension(npft),intent( in) :: cleaf1, cfroot1, cawood1
    real(kind=r4),dimension(npft),intent(out) :: ocp_coeffs
    logical(kind=l1),dimension(npft),intent(out) :: ocp_wood
    real(kind=r4),dimension(npft) :: total_biomass_pft,total_w_pft
    integer(kind=i4) :: p,i
    integer(kind=i4),dimension(1) :: max_index
    real(kind=r4) :: total_biomass, total_wood
    integer(kind=i4) :: five_percent
    real(r4),dimension(npft) :: cleaf, cawood, cfroot

    cleaf = cleaf1
    cfroot = cfroot1
    cawood = cawood1

    total_biomass = 0.0
    total_wood = 0.0

        ! check for nan in cleaf cawood cfroot
    do p = 1,npft
       if(isnan(cleaf(p))) cleaf(p) = 0.0
       if(isnan(cfroot(p))) cfroot(p) = 0.0
       if(isnan(cawood(p))) cawood(p) = 0.0

       if(cleaf(p) .eq. cleaf(p) - 1) cleaf(p) = 0.0
       if(cfroot(p) .eq. cfroot(p) - 1) cfroot(p) = 0.0
       if(cawood(p) .eq. cawood(p) - 1) cawood(p) = 0.0
    enddo

    
    do p = 1,npft
       total_w_pft(p) = 0.0
       total_biomass_pft(p) = 0.0
       ocp_coeffs(p) = 0.0
       ocp_wood(p) = .false.
    enddo
    
    do p = 1,npft
      ! check for pls availability
       if(((cleaf(p) .lt. cmin) .and. (cfroot(p) .lt. cmin))) then
          total_biomass_pft(p) = 0.0
          total_w_pft(p) = 0.0
          goto 795
       endif
       ! then calculates 
       total_biomass_pft(p) = cleaf(p) + cfroot(p) + cawood(p) 
       total_w_pft(p) = cawood(p)

795    continue
       total_biomass = total_biomass + total_biomass_pft(p)
       total_wood = total_wood + total_w_pft(p)
    enddo

    !     grid cell occupation coefficients
    if(total_biomass .gt. 0.0) then
       do p = 1,npft   
          ocp_coeffs(p) = total_biomass_pft(p) / total_biomass
          if(ocp_coeffs(p) .lt. 0.0) ocp_coeffs(p) = 0.0
       enddo
    else
       do p = 1,npft
          ocp_coeffs(p) = 0.0
       enddo
    endif
    
    !     gridcell pft ligth limitation by wood content
    five_percent = nint(real(npft) * 0.05)
    if(five_percent .eq. 0) five_percent = 1
    if(five_percent .eq. 1) then
       if(total_wood .gt. 0.0) then
          max_index = maxloc(total_w_pft)
          i = max_index(1)
          ocp_wood(i) = .true.
       endif
    else
       do p = 1,five_percent
          if(total_wood .gt. 0.0) then
             max_index = maxloc(total_w_pft)
             i = max_index(1)
             total_w_pft(i) = 0.0
             ocp_wood(i) = .true.
          endif
       enddo
    endif
    
  end subroutine pft_area_frac
  
  !====================================================================
  !====================================================================

  subroutine pft_par(dt)
    ! pft_par agora retorna um array-shape(npls,ntraits)
    use types, only: r4
    use global_pars, only: ntraits, npls
    implicit none

    
    real(kind=r4), dimension(npls,ntraits),intent(out) :: dt
    
    ! ['g1','vcmax','tleaf','twood','troot','aleaf','awood','aroot']
    !     dt1 = g1
    !     dt2 = vcmax
    !     dt3 = tleaf
    !     dt4 = twood
    !     dt5 = tfroot
    !     dt6 = aleaf
    !     dt7 = awood
    !     dt8 = aroot
    
    open(45,file='pls.bin',status='old',&
         &form='unformatted',access='direct',recl=4*npls*ntraits)
    read(45,rec=1) dt
    close(45)
    return
  end subroutine pft_par


 !====================================================================
 !====================================================================

    function pft_par2() result(dt)
    ! pft_par agora retorna um array-shape(par,npls)
    use types, only: r4
    use global_pars, only: ntraits, npls
    implicit none


    real(kind=r4), dimension(ntraits,npls) :: dt

    ! ['g1','vcmax','tleaf','twood','troot','aleaf','awood','aroot']
    !     dt1 = g1
    !     dt2 = vcmax
    !     dt3 = tleaf
    !     dt4 = twood
    !     dt5 = tfroot
    !     dt6 = aleaf
    !     dt7 = awood
    !     dt8 = aroot

    open(45,file='pls.bin',status='old',&
         &form='unformatted',access='direct',recl=4*npls*ntraits)
    read(45,rec=1) dt
    close(45)
    return
  end function pft_par2


  !====================================================================
  !====================================================================

   function test_dt(dt, i) result(dt1)
   use types, only: i4, r4
   use global_pars, only: npls, ntraits
   implicit none
   integer(kind=i4),intent(in) ::  i
   real(kind=r4),dimension(ntraits,npls),intent(in) :: dt
   real(kind=r4),dimension(npls) :: dt1

   dt1 = dt(i,:)
   
   end function test_dt

  !====================================================================
  !====================================================================
  
  subroutine spinup(nppot,dt,cleafini,cfrootini,cawoodini)
        use types
      use global_pars, only: ntraits,npls
      implicit none

      !parameters
      integer(kind=i4),parameter :: ntl=36525

      ! inputs
      integer(kind=i4) :: i6, kk, k

      real(kind=r4),intent(in) :: nppot
      real(kind=r4),dimension(ntraits, npls),intent(in) :: dt
      ! intenal
      real(kind=r4) :: sensitivity
      real(kind=r4) :: nppot2
      ! outputs
      real(kind=r4),dimension(npls),intent(out) :: cleafini
      real(kind=r4),dimension(npls),intent(out) :: cawoodini
      real(kind=r4),dimension(npls),intent(out) :: cfrootini

      ! more internal
      real(kind=r4),dimension(ntl) :: cleafi_aux
      real(kind=r4),dimension(ntl) :: cfrooti_aux
      real(kind=r4),dimension(ntl) :: cawoodi_aux

      real(kind=r4) :: aux_leaf
      real(kind=r4) :: aux_wood
      real(kind=r4) :: aux_root
      real(kind=r4) :: out_leaf
      real(kind=r4) :: out_wood
      real(kind=r4) :: out_root

      real(kind=r4),dimension(npls) :: aleaf  !npp percentage alocated to leaf compartment
      real(kind=r4),dimension(npls) :: aawood !npp percentage alocated to aboveground woody biomass compartment
      real(kind=r4),dimension(npls) :: afroot !npp percentage alocated to fine roots compartmentc 
      real(kind=r4),dimension(npls) :: tleaf  !turnover time of the leaf compartment (yr)
      real(kind=r4),dimension(npls) :: tawood !turnover time of the aboveground woody biomass compartment (yr)
      real(kind=r4),dimension(npls) :: tfroot !turnover time of the fine roots compartment
      logical(kind=l1) :: iswoody

      ! catch 'C turnover' traits
      tleaf  = dt(3,:)
      tawood = dt(4,:)
      tfroot = dt(5,:)
      aleaf  = dt(6,:)
      aawood = dt(7,:)
      afroot = dt(8,:)

      sensitivity = 1.0001
      if(nppot .le. 0.0) goto 200
      nppot2 = nppot !/real(npls,kind=r4)
      do i6=1,npls
         iswoody = ((aawood(i6) .gt. 0.0) .and. (tawood(i6) .gt. 0.0))
         do k=1,ntl
            if (k.eq.1) then
               cleafi_aux (k) =  aleaf(i6) * nppot2
               cawoodi_aux(k) = aawood(i6) * nppot2
               cfrooti_aux(k) = afroot(i6) * nppot2

            else
               aux_leaf = cleafi_aux(k-1) + (aleaf(i6) * nppot2)
               aux_wood = cawoodi_aux(k-1) + (aleaf(i6) * nppot2)
               aux_root = cfrooti_aux(k-1) + (afroot(i6) * nppot2)

               out_leaf = aux_leaf - (cleafi_aux(k-1) / tleaf(i6)) 
               out_wood = aux_wood - (cawoodi_aux(k-1) / tawood(i6))
               out_root = aux_root - (cfrooti_aux(k-1) / tfroot(i6))

               if(iswoody) then
                  cleafi_aux(k) = amax1(0.0, out_leaf)
                  cawoodi_aux(k) = amax1(0.0, out_wood)
                  cfrooti_aux(k) = amax1(0.0, out_root)
               else
                  cleafi_aux(k) = amax1(0.0, out_leaf)
                  cawoodi_aux(k) = 0.0
                  cfrooti_aux(k) = amax1(0.0, out_root)
               endif

               kk =  floor(k*0.66)
               if(iswoody) then
                  if((cfrooti_aux(k)/cfrooti_aux(kk).lt.sensitivity).and.&
                       &(cleafi_aux(k)/cleafi_aux(kk).lt.sensitivity).and.&
                       &(cawoodi_aux(k)/cawoodi_aux(kk).lt.sensitivity)) then

                     cleafini(i6) = cleafi_aux(k) ! carbon content (kg m-2)
                     cfrootini(i6) = cfrooti_aux(k)
                     cawoodini(i6) = cawoodi_aux(k)
                     exit
                  endif
               else
                  if((cfrooti_aux(k)&
                       &/cfrooti_aux(kk).lt.sensitivity).and.&
                       &(cleafi_aux(k)/cleafi_aux(kk).lt.sensitivity)) then

                     cleafini(i6) = cleafi_aux(k) ! carbon content (kg m-2)
                     cfrootini(i6) = cfrooti_aux(k)
                     cawoodini(i6) = 0.0
                     exit
                  endif
               endif
            endif
         enddo                  !nt
      enddo                     !npls
200   continue
  end subroutine spinup
  

   ! ===========================================================
   ! ===========================================================

   subroutine spinup3(nppot,dt,cleafini,cfrootini,cawoodini)
      use types
      use global_pars, only: ntraits,npls
      implicit none

      !parameters
      integer(kind=i4),parameter :: ntl=36525

      ! inputs
      integer(kind=i4) :: kk, k

      real(kind=r4),intent(in) :: nppot
      real(kind=r4),dimension(6),intent(in) :: dt
      ! intenal
      real(kind=r4) :: sensitivity
      real(kind=r4) :: nppot2
      ! outputs
      real(kind=r4),intent(out) :: cleafini
      real(kind=r4),intent(out) :: cawoodini
      real(kind=r4),intent(out) :: cfrootini

      ! more internal
      real(kind=r4),dimension(ntl) :: cleafi_aux
      real(kind=r4),dimension(ntl) :: cfrooti_aux
      real(kind=r4),dimension(ntl) :: cawoodi_aux

      real(kind=r4) :: aux_leaf
      real(kind=r4) :: aux_wood
      real(kind=r4) :: aux_root
      real(kind=r4) :: out_leaf
      real(kind=r4) :: out_wood
      real(kind=r4) :: out_root

      real(kind=r4) :: aleaf  !npp percentage alocated to leaf compartment
      real(kind=r4) :: aawood !npp percentage alocated to aboveground woody biomass compartment
      real(kind=r4) :: afroot !npp percentage alocated to fine roots compartmentc 
      real(kind=r4) :: tleaf  !turnover time of the leaf compartment (yr)
      real(kind=r4) :: tawood !turnover time of the aboveground woody biomass compartment (yr)
      real(kind=r4) :: tfroot !turnover time of the fine roots compartment
      logical(kind=l1) :: iswoody

      ! catch 'C turnover' traits
      tleaf  = dt(1)
      tawood = dt(2)
      tfroot = dt(3)
      aleaf  = dt(4)
      aawood = dt(5)
      afroot = dt(6)

      iswoody = ((aawood .gt. 0.0) .and. (tawood .gt. 0.0))

      sensitivity = 1.001
      if(nppot .le. 0.0) goto 200
      nppot2 = nppot !/real(npls,kind=r4)
      do k=1,ntl
         if (k.eq.1) then
            cleafi_aux (k) =  aleaf * nppot2
            cawoodi_aux(k) = aawood * nppot2
            cfrooti_aux(k) = afroot * nppot2
         else
            aux_leaf = cleafi_aux(k-1) + (aleaf * nppot2)
            aux_wood = cawoodi_aux(k-1) + (aleaf * nppot2)
            aux_root = cfrooti_aux(k-1) + (afroot * nppot2)

            out_leaf = aux_leaf - (cleafi_aux(k-1) / tleaf) 
            out_wood = aux_wood - (cawoodi_aux(k-1) / tawood)
            out_root = aux_root - (cfrooti_aux(k-1) / tfroot)

            if(iswoody) then
               cleafi_aux(k) = amax1(0.0, out_leaf)
               cawoodi_aux(k) = amax1(0.0, out_wood)
               cfrooti_aux(k) = amax1(0.0, out_root)
            else
               cleafi_aux(k) = amax1(0.0, out_leaf)
               cfrooti_aux(k) = amax1(0.0, out_root)
               cawoodi_aux(k) = 0.0
            endif

            kk =  floor(k*0.66)
            if(iswoody) then
               if((cfrooti_aux(k)/cfrooti_aux(kk).lt.sensitivity).and.&
                    &(cleafi_aux(k)/cleafi_aux(kk).lt.sensitivity).and.&
                    &(cawoodi_aux(k)/cawoodi_aux(kk).lt.sensitivity)) then

                  cleafini = cleafi_aux(k) ! carbon content (kg m-2)
                  cfrootini = cfrooti_aux(k)
                  cawoodini = cawoodi_aux(k)
                  !  print *, 'woody exitet in', k
                  exit
               endif
            else
               if((cfrooti_aux(k)&
                    &/cfrooti_aux(kk).lt.sensitivity).and.&
                    &(cleafi_aux(k)/cleafi_aux(kk).lt.sensitivity)) then

                  cleafini = cleafi_aux(k) ! carbon content (kg m-2)
                  cfrootini = cfrooti_aux(k)
                  cawoodini = 0.0
                  !  print *, 'grass exitet in', k
                  exit
               endif
            endif
         endif
      enddo                  !nt
200   continue
   end subroutine spinup3


 !=================================================================
 !=================================================================
 
  subroutine ascii2bin(file_in, file_out, nx1, ny1)
    use types
    implicit none
    
    character*100, intent(in) :: file_in, file_out
    integer(kind=i4),intent(in) :: nx1, ny1
    
    integer(kind=i4) :: i, j
    
    real(kind=r4),allocatable,dimension(:,:) :: arr_in
    
    allocate(arr_in(nx1,ny1))
    
    open (unit=11,file=file_in,status='old',form='formatted',access='sequential',&
         action='read')
    
    
    open (unit=21,file=file_out,status='unknown',&
         form='unformatted',access='direct',recl=nx1*ny1*r4)
    
    
    do j = 1, ny1 ! for each line do
       read(11,*) (arr_in(i,j), i=1,nx1) ! read all elements in line j (implicit looping)
       !write(*,*) arr_in(:,j) 
    end do
    
    write(21,rec=1) arr_in   
    close(11)
    close(21)
    
  end subroutine ascii2bin
  !====================================================================
  !====================================================================


   subroutine ascii2bin2(file_in, file_out, ny1, nx1)
    use types
    implicit none
    
    character*100, intent(in) :: file_in, file_out
    integer(kind=i4),intent(in) :: nx1, ny1
    
    integer(kind=i4) :: i, j
    
    real(kind=r4),allocatable,dimension(:,:) :: arr_in
    
    allocate(arr_in(ny1,nx1))
    
    open (unit=11,file=file_in,status='old',form='formatted',access='sequential',&
         action='read')
    
    
    open (unit=21,file=file_out,status='unknown',&
         form='unformatted',access='direct',recl=nx1*ny1*r4)
    
    
    do j = 1, ny1 ! for each line do
       read(11,*) (arr_in(i,j), i=1,nx1) ! read all elements in line j (implicit looping)
       !write(*,*) arr_in(:,j) 
    end do
    
    write(21,rec=1) arr_in   
    close(11)
    close(21)
    
  end subroutine ascii2bin2
  !====================================================================
  !====================================================================



   !=====================================================================
 !c     subroutine allocation calculates the daily carbon content of each
 !c     compartment
 !c     
 !c     code written by Bianca Rius & David Lapola (27.Ago.2015)
 !c     
 !c=====================================================================
      
  subroutine allocation (dt,npp,scl1,sca1,scf1,scl2,sca2,scf2,endpls)!,bio_litter)
    use types
    use global_pars, only: ntraits,npls,cmin
    implicit none
    
    integer(kind=i4),parameter :: npfts = npls
    
    !     variables
    real(kind=r4),dimension(ntraits),intent(in) :: dt
 
    real(kind=r4),intent(in) :: npp   !potential npp (KgC/m2/yr)
    real(kind=rbig) :: npp_aux        !auxiliary variable to calculate potential npp in KgC/m2/day
    real(kind=r4),intent( in) :: scl1 !previous day carbon content on leaf compartment (KgC/m2)
    real(kind=r4),intent(out) :: scl2 !final carbon content on leaf compartment (KgC/m2)
    real(kind=r4),intent( in) :: sca1 !previous day carbon content on aboveground woody biomass compartment(KgC/m2)
    real(kind=r4),intent(out) :: sca2 !final carbon content on aboveground woody biomass compartment (KgC/m2)
    real(kind=r4),intent( in) :: scf1 !previous day carbon content on fine roots compartment (KgC/m2)
    real(kind=r4),intent(out) :: scf2 !final carbon content on fine roots compartment (KgC/m2)
    logical(kind=l1),intent(out) :: endpls      
    !real(kind=r4),intent(out) :: bio_litter
    real(kind=rbig) :: scf2_128 = 0.0, sca2_128 = 0.0, scl2_128 = 0.0
    
    real(kind=r4) :: aleaf             !npp percentage allocated compartment
    real(kind=r4) :: aawood
    real(kind=r4) :: afroot
    real(kind=r4) :: tleaf             !turnover time (yr)
    real(kind=r4) :: tawood
    real(kind=r4) :: tfroot            
    
    tleaf  = dt(3)
    tawood = dt(4)
    tfroot = dt(5)
    aleaf  = dt(6)
    aawood = dt(7)
    afroot = dt(8)
    
!!$    call pft_par(6, aleaf)
!!$    call pft_par(7, aawood)
!!$    call pft_par(8, afroot)
!!$    call pft_par(3, tleaf)
!!$    call pft_par(4, tawood)
!!$    call pft_par(5, tfroot)
    
    !     Carbon content of each compartment(KgC/m2)
    !c     
    !c     
    !c     initialization
    if((scl1 .lt. cmin) .and. (scf1 .lt. cmin)) then
       !bio_litter = scl1 + scf1 + sca1
       scl2 = 0.0
       scf2 = 0.0
       sca2 = 0.0
       endpls = .true.
      goto 10
    endif
   endpls = .false.

   npp_aux = npp/365.0       !transform (KgC/m2/yr) in (KgC/m2/day)
   scl2_128 = scl1 + (aleaf * npp_aux) -(scl1 /(tleaf * 365.0))
   scf2_128 = scf1 +(afroot * npp_aux)-(scf1 /(tfroot * 365.0))
   if(aawood .gt. 0.0) then
      sca2_128 = sca1 +(aawood * npp_aux)-(sca1/(tawood * 365.0))
      sca2 = real(sca2_128,r4)
   else
      sca2 = 0.0
   endif
   
   scf2 = real(scf2_128,r4)
   scl2 = real(scl2_128,r4)
   
   
   if(scl2_128 .lt. 1e-12) scl2 = 0.0
   if(scf2_128 .lt. 1e-12) scf2 = 0.0
   if(sca2_128 .lt. 1e-12) sca2 = 0.0

   if(scl2 .le. 0.0 .and. scf2 .le. 0.0) endpls = .true.
   
10 continue
   return
   
 end subroutine allocation

 !===================================================================
 !===================================================================

 function leap(year) result(is_leap)

   use types
   implicit none
   
   integer(kind=i4),intent(in) :: year
   logical(kind=l1) :: is_leap

   logical(kind=l1) :: by4, by100, by400

   by4 = (mod(year,4) .eq. 0)
   by100 = (mod(year,100) .eq. 0)
   by400 = (mod(year,400) .eq. 0)

   is_leap = by4 .and. (by400 .or. (.not. by100))
 
 end function leap
end module photo

! =================-----------------==================----------------

module water
  
  ! this module defines functions related to surface water balance
  implicit none
  private

  ! functions defined here:
  
  public ::              &
       soil_temp        ,&
       soil_temp_sub    ,&
       penman           ,&
       evpot2           ,&
       available_energy ,&
       runoff          

  
contains
  
  !=================================================================
  !=================================================================

  subroutine soil_temp_sub(temp, tsoil)
  ! Calcula a temperatura do solo. Aqui vamos mudar no futuro!
  ! a tsoil deve ter relacao com a et realizada...
  ! a profundidade do solo (H) e o coef de difusao (DIFFU) devem ser
  ! variaveis (MAPA DE SOLO?; agua no solo?)
  use types
  use global_pars
  implicit none
  integer(kind=i4),parameter :: m = ntimes
  
  real(kind=r4),dimension(m), intent( in) :: temp ! future __ make temps an allocatable array
  real(kind=r4),dimension(m), intent(out) :: tsoil
   
  ! internal vars
  
  integer(kind=i4) :: n, k
  real(kind=r4) :: t0 = 0.0
  real(kind=r4) :: t1 = 0.0

  tsoil = -9999.0

  do n=1,1200 !run to attain equilibrium
     k = mod(n,m)
     if (k.eq.0) k = 12
     t1 = (t0*exp(-1.0/TAU) + (1.0 - exp(-1.0/TAU)))*temp(k)
     tsoil(k) = (t0 + t1)/2.0
     t0 = t1
  enddo
  end subroutine soil_temp_sub
  
  !=================================================================
  !=================================================================
  
  function soil_temp(t0,temp) result(tsoil)
    use types
    use global_pars, only: H, TAU, DIFFU
    implicit none
    
    real(kind=r4),intent( in) :: temp
    real(kind=r4),intent( in) :: t0! future __ make temps an allocatable array
    real(kind=r4) :: tsoil
 
    real(kind=r4) :: t1 = 0.0
    
    t1 = (t0*exp(-1.0/TAU) + (1.0 - exp(-1.0/TAU)))*temp
    tsoil = (t0 + t1)/2.0
  end function soil_temp

  !=================================================================
  !=================================================================
  
  function penman (spre,temp,ur,rn,rc2) result(evap)
    use types, only: r4
    use global_pars, only: rcmin, rcmax
    use photo, only: tetens
    implicit none
    
    
    real(kind=r4),intent(in) :: spre                 !Surface pressure (mbar)
    real(kind=r4),intent(in) :: temp                 !Temperature (oC)
    real(kind=r4),intent(in) :: ur                   !Relative humidity (0-1,dimensionless)
    real(kind=r4),intent(in) :: rn                   !Radiation balance (W/m2)
    real(kind=r4),intent(in) :: rc2                  !Canopy resistence (s/m)
    
    real(kind=r4) :: evap                             !Evapotranspiration (mm/day)
    !     Parameters
    !     ----------
    real(kind=r4) :: ra, h5, t1, t2, es, es1, es2, delta_e, delta
    real(kind=r4) :: gama, gama2
    
    
    ra = rcmin
    h5 = 0.0275               !mb-1
    
    !     Delta
    !     -----
    t1 = temp + 1.
    t2 = temp - 1.
    es1 = tetens(t1)       !Saturation partial pressure of water vapour at temperature T
    es2 = tetens(t2)
    
    delta = (es1-es2)/(t1-t2) !mbar/oC
    !     
    !     Delta_e
    !     -------
    es = tetens (temp)
    delta_e = es*(1. - ur)    !mbar
    
    if ((delta_e.ge.(1./h5)-0.5).or.(rc2.ge.rcmax)) evap = 0.
    if ((delta_e.lt.(1./h5)-0.5).or.(rc2.lt.rcmax)) then
       !     Gama and gama2
       !     --------------
       gama  = spre*(1004.)/(2.45e6*0.622)
       gama2 = gama*(ra + rc2)/ra
       
       !     Real evapotranspiration
       !     -----------------------     
       evap = (delta* rn + (1.20*1004./ra)*delta_e)/(delta+gama2) !W/m2
       evap = evap*(86400./2.45e6) !mm/day
       evap = amax1(evap,0.)  !Eliminates condensation
    endif
  end function penman
  
  !=================================================================
  !=================================================================

  function available_energy(temp) result(ae)
    use types, only: r4
    implicit none
    
    real(kind=r4),intent(in) :: temp
    real(kind=r4) :: ae
    
    ae = 2.895 * temp + 52.326 !from NCEP-NCAR Reanalysis data  
  end function  available_energy

  !=================================================================
  !=================================================================

  
  function runoff(wa) result(roff)
    use types, only: r4
    implicit none
    
    real(kind=r4),intent(in) :: wa
    real(kind=r4):: roff
    
    !  roff = 38.*((w/wmax)**11.) ! [Eq. 10]
    roff = 11.5*((wa)**6.6) !from NCEP-NCAR Reanalysis data  
  end function  runoff
  
  !=================================================================
  !=================================================================
  
  function evpot2 (spre,temp,ur,rn) result(evap) 
    use types, only: r4
    use global_pars, only: rcmin, rcmax
    use photo, only: tetens
    implicit none
    
    !     Inputs
    
    real(kind=r4),intent(in) :: spre                 !Surface pressure (mb)
    real(kind=r4),intent(in) :: temp                 !Temperature (oC)
    real(kind=r4),intent(in) :: ur                   !Relative humidity (0-1,dimensionless)
    real(kind=r4),intent(in) :: rn                   !Radiation balance (W/m2)
    !     Output
    !     ------
    !     
    real(kind=r4) :: evap                 !Evapotranspiration (mm/day)
    !     Parameters
    !     ----------
    real(kind=r4) :: ra, t1, t2, es, es1, es2, delta_e, delta
    real(kind=r4) :: gama, gama2, rc
    
    ra = rcmin            !s/m
    
    !     Delta
    !     -----     
    t1 = temp + 1.
    t2 = temp - 1.
    es1 = tetens(t1)
    es2 = tetens(t2)
    delta = (es1-es2)/(t1-t2) !mb/oC
    !     
    !     Delta_e
    !     -------
    !     
    es = tetens (temp)
    delta_e = es*(1. - ur)    !mb
    !     
    !     Stomatal Conductance
    !     --------------------
    !     
    rc = rcmin
    !     
    !     Gama and gama2
  !     --------------
    !     
    gama  = spre*(1004.)/(2.45e6*0.622)
    gama2 = gama*(ra + rc)/ra
    !     
    !     Potencial evapotranspiration (without stress)
    !     ---------------------------------------------
    !     
    evap =(delta*rn + (1.20*1004./ra)*delta_e)/(delta+gama2) !W/m2
    evap = evap*(86400./2.45e6) !mm/day
    evap = amax1(evap,0.)     !Eliminates condensation
  end function evpot2
  
  !=================================================================
  !=================================================================
  
end module water

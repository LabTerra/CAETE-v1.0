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
!             Bianca Fazio Rius <biancafaziorius (at) gmail.com>

module water_balance
  implicit none
  private
  
  public :: wbm
  
  
contains
  subroutine wbm (dt, prec, temp, p0, par, rhs, cleaf_ini, cawood_ini&
       &, cfroot_ini, emaxm, tsoil, photo_pft, aresp_pft, npp_pft, lai_pft&
       &, clit_pft, csoil_pft, hresp_pft, rcm_pft, runom_pft, evapm_pft&
       &, wsoil_pft, rm_pft,rg_pft, cleaf_pft, cawood_pft, cfroot_pft&
       &, grid_area, grid_area0, wue, cue)
    
    use types
    use global_pars
    use budget_caete
    use water, only:soil_temp_sub
    use photo, only:pft_area_frac
    
    implicit none
    
    integer(kind=i_4),parameter :: q = npls 
    integer(kind=i_4),parameter :: nt = ntimes
  
    !     --------------------------I N P U T S----------------------------
    real(kind=r_4),dimension(ntraits, q),intent(in) :: dt
    real(kind=r_4),dimension(nt),intent(in) :: p0         !in Pa ->>>> transf Atmospheric pressure (mb)
    real(kind=r_4),dimension(nt),intent(in) :: prec       !in kg m-2 s-1  ---> transform Precipitation (mm/month)
    real(kind=r_4),dimension(nt),intent(in) :: temp       !Temperature (oC)
    real(kind=r_4),dimension(nt),intent(in) :: par        !IPAR in W m-2 ->>> transform(Ein/m2/s)
    real(kind=r_4),dimension(nt),intent(in) :: rhs        !Relative humidity
    
    real(kind=r_4),dimension(q),intent(in) ::  cleaf_ini  ! Initial carbon content in leaves (kg m-2)
    real(kind=r_4),dimension(q),intent(in) :: cawood_ini  ! Initial carbon content in aboveground wood (kg m-2)
    real(kind=r_4),dimension(q),intent(in) :: cfroot_ini  ! Initial carbon content in fineroots (kg m-2)
    !     -----------------------------E N D-------------------------------
    
    !     -------------------------O U T P U T S---------------------------  
    real(kind=r_4),dimension(nt),intent(out) :: tsoil       !soil temperature
    real(kind=r_4),dimension(nt),intent(out) :: emaxm        !Max.evapotranspiration (kg m-2 day-1)
    
    real(kind=r_4),dimension(q,nt),intent(out) :: photo_pft !Monthly photosynthesis   (kgC m-2)
    real(kind=r_4),dimension(q,nt),intent(out) :: aresp_pft !Monthly autotrophic res  (kgC m-2)
    real(kind=r_4),dimension(q,nt),intent(out) :: npp_pft   !Monthly net primary produ (kgC m-2)
    
    real(kind=r_4),dimension(q,nt),intent(out) :: lai_pft      !Monthly leaf area index
    real(kind=r_4),dimension(q,nt),intent(out) :: clit_pft     !Monthly litter carbon
    real(kind=r_4),dimension(q,nt),intent(out) :: csoil_pft    !Monthly soil carbon
    real(kind=r_4),dimension(q,nt),intent(out) :: hresp_pft    !Monthly het resp  (kgC/m2)
    real(kind=r_4),dimension(q,nt),intent(out) :: rcm_pft 
    real(kind=r_4),dimension(q,nt),intent(out) :: runom_pft  !Runoff 
    real(kind=r_4),dimension(q,nt),intent(out) :: evapm_pft  !Actual evapotranspiration        
    real(kind=r_4),dimension(q,nt),intent(out) :: wsoil_pft  !Soil moisture (mm)
    real(kind=r_4),dimension(q,nt),intent(out) :: wue,cue
    !c     NOVOS OUTPUTS DA BIANCA
    real(kind=r_4),dimension(q,nt),intent(out) :: rm_pft
    real(kind=r_4),dimension(q,nt),intent(out) :: rg_pft
    real(kind=r_4),dimension(q),intent(out) :: cleaf_pft   ! leaf biomass (KgC/m2)
    real(kind=r_4),dimension(q),intent(out) :: cawood_pft  ! aboveground wood biomass (KgC/m2)
    real(kind=r_4),dimension(q),intent(out) :: cfroot_pft  ! fine root biomass      
    real(kind=r_4),dimension(q),intent(out) :: grid_area   ! gridcell area fraction of pfts!
    real(kind=r_4),dimension(q),intent(out) :: grid_area0   ! gridcell area fraction of pfts!
    !  c     --------------------------------E N D----------------------------
    
    !  c     ------------------------- internal variables---------------------
    
    integer(kind=i_4) :: k, kk, n, mes, nerro, p
    
    real(kind=r_4),dimension(nt) :: wg0        !Previous year soil moisture
    real(kind=r_4),dimension(nt) :: wsoilt     !soil water (check wbm equilibrium)
    real(kind=r_4),dimension(nt) :: gsoilt     !soil ice   (check wbm equilibrium)
    real(kind=r_4),dimension(q,nt) :: gsoil    !Soil ice 
    real(kind=r_4),dimension(q,nt) :: ssoil    !Soil snow
    real(kind=r_4),dimension(q,nt) :: snowm    !Snowmelt
    
    real(kind=r_4),dimension(q) :: sini,sfim
    real(kind=r_4),dimension(q) :: wini,wfim
    real(kind=r_4),dimension(q) :: gini,gfim
    
    real(kind=r_4),dimension(q) :: cleaf1_pft
    real(kind=r_4),dimension(q) :: cawood1_pft
    real(kind=r_4),dimension(q) :: cfroot1_pft
    
    real(kind=r_4) :: epmes ! equal for all pfts - potential evapotranspiration(PET)(mm day-1)
    real(kind=r_4),dimension(q) :: rmes,phmes,smes,rcmes,hrmes
    real(kind=r_4),dimension(q) :: nppmes,laimes, armes,clmes,csmes
    real(kind=r_4),dimension(q) :: emes,rmmes,rgmes,cuemes
    real(kind=r_4),dimension(q) :: cleafmes,cawoodmes,cfrootmes
    real(kind=r_4),dimension(q) :: gridocpmes,sm,wuemes 
    real(kind=r_4) :: wsaux1 !auxiliar to check water equilibrium
    real(kind=r_4) :: dwww !auxiliar to check water equilibrium
    real(kind=r_4) :: pr,spre,ta,td,ipar,ru
    real(kind=r_4) :: land_c,c_change !auxiliar to check carbon equilibrium
    real(kind=r_4) :: carbon_test  !auxiliar to check carbon equilibrium
    real(kind=r_4) :: c1232 !auxiliar to check carbon equilibrium (carbon on leaf compartment)
    real(kind=r_4) :: c1234 !auxiliar to check carbon equilibrium (carbon on fine roots compartment)
    real(kind=r_4) :: c1342 !auxiliar to check carbon equilibrium (carbon on abovebround wood compartment)
    ! initial_area
    real(kind=r_4),dimension(q) :: ocp_coeffs_ini
    logical(kind=l_1), dimension(q) :: lt
    
    
    !     ================      
    !     Soil temperature
    !     ================
    call soil_temp_sub(temp,tsoil)


    !     ============
    !     Water budget
    !     ============    
    cleaf1_pft =  cleaf_ini
    cawood1_pft = cawood_ini
    cfroot1_pft = cfroot_ini
    

    call pft_area_frac(cleaf_ini, cfroot_ini, cawood_ini, ocp_coeffs_ini, lt)  
    grid_area0 = ocp_coeffs_ini * 100.0
    
    cleaf_pft  = 0.0 ! leaf biomass (KgC/m2)
    cawood_pft = 0.0 ! aboveground wood biomass (KgC/m2)
    cfroot_pft = 0.0 ! fine root biomass (KgC/m2) ! grid_area0  = 0.0 ! gridcell (spinup) area fraction of pfts(%)
    grid_area  = 0.0 ! gridcell area fraction of pfts(%)
    
    wg0 = 0.0 !Soil water content in first integration
    emaxm =  0.0 !Maximum evapotranspiration
    photo_pft = 0.0 !Monthly photosynthesis (kgC/m2/y)
    aresp_pft = 0.0 !Monthly autotrophic respiration (kgC/m2/y)
    npp_pft   = 0.0 !Monthly net primary productivity (sum of PLSs) (kgC/m2/y)
    lai_pft   = 0.0 !Monthly leaf area index m2 m-2
    clit_pft  = 0.0 !Monthly litter carbon kg m-2
    csoil_pft = 0.0 !Monthly soil carbon kg m-2
    hresp_pft = 0.0 !Monthly heterotrophic respiration (kgC/m2/y)
    rcm_pft   = 0.0 !molH2O m-2 s-1
    gsoil     = 0.0 !Soil ice mm
    ssoil     = 0.0 !Soil snow mm
    runom_pft = 0.0 !Runoff mm
    evapm_pft = 0.0 !Actual evapotranspiration mm/day
    wsoil_pft = 0.0 !Soil moisture (mm)
    rm_pft    = 0.0
    rg_pft    = 0.0
    wue       = 0.0
    cue       = 0.0
    wini  = 0.1  !Soil moisture_initial condition (mm)
    gini  = 0.0   !Soil ice_initial condition (mm)
    sini  = 0.0   !Overland snow_initial condition (mm)
    
    !     =================
    !     START INTEGRATION
    !     =================    
    n = 0
    c1232 = sum((cleaf_ini * ocp_coeffs_ini))
    c1234 = sum((cfroot_ini * ocp_coeffs_ini))
    c1342 = sum((cawood_ini * ocp_coeffs_ini))
    carbon_test =  c1232 + c1234 + c1342

10  continue
    n = n + 1
    k = mod(n,12)
    if (k.eq.0) k = 12
    mes = k
    spre = p0(k) * 0.01 ! transforamando de Pascal pra mbar (hPa)
    td = tsoil(k)
    ta = temp(k)
    pr = prec(k)
    ipar = par(k) / 2.18e5 !it converts from w/m2 to Ein/m2/s
    ru = rhs(k) / 100.

    !     Monthly water budget
    !     ====================
    epmes = 0.0  
    wfim = 0.0
    gfim = 0.0
    sfim = 0.0
    smes = 0.0
    rmes = 0.0
    emes = 0.0
    phmes = 0.0
    armes = 0.0
    nppmes = 0.0
    laimes = 0.0
    clmes = 0.0
    csmes = 0.0
    hrmes = 0.0
    rcmes = 0.0
    rmmes = 0.0
    rgmes = 0.0
    cleafmes = 0.0
    cawoodmes = 0.0
    cfrootmes = 0.0
    gridocpmes = 0.0
    wuemes = 0.0
    wuemes = 0.0

   !  print *, 'n', n
   !  print *, 'k', k
    call budget (dt,mes,wini,gini,sini,td,ta,pr,spre,ipar,ru&
         &,cleaf1_pft,cawood1_pft,cfroot1_pft ,wfim,gfim,sfim,smes&
         &,rmes,emes,epmes,phmes,armes,nppmes,laimes,clmes,csmes,hrmes&
         &,rcmes,rmmes,rgmes,cleafmes,cawoodmes,cfrootmes, gridocpmes&
         &,wuemes,cuemes) ! inserir novo output (pls sobreviventes )
    
    emaxm(k) = epmes
    
    do p=1,q
      !  print *, 'p', p
      !  print *, 'wfim', wfim(p)
       gsoil    (p,k) = gfim(p) !* (gridocpmes(p) / 100.)
       ssoil    (p,k) = sfim(p) !* (gridocpmes(p) / 100.)
       wsoil_pft(p,k) = wfim(p) !* (gridocpmes(p) / 100.)
       snowm    (p,k) = smes(p) !* (gridocpmes(p) / 100.)
       runom_pft(p,k) = rmes(p)
       evapm_pft(p,k) = emes(p)
       rcm_pft  (p,k) = rcmes(p)
       lai_pft  (p,k) = laimes(p)
       photo_pft(p,k) = phmes(p)
       aresp_pft(p,k) = armes(p)
       npp_pft  (p,k) = nppmes(p)
       clit_pft (p,k) = clmes(p)
       csoil_pft(p,k) = csmes(p)
       hresp_pft(p,k) = hrmes(p)
       rm_pft   (p,k) = rmmes(p)
       rg_pft   (p,k) = rgmes(p)
       wue      (p,k) = wuemes(p)
       cue      (p,k) = cuemes(p)
    enddo

    do p=1,q
      wini(p) = wfim(p)
      gini(p) = gfim(p)
      sini(p) = sfim(p)
    end do

    cleaf1_pft  = cleafmes 
    cawood1_pft = cawoodmes
    cfroot1_pft = cfrootmes
    
    if(k .eq. 12) then
       cleaf_pft  = cleafmes
       cawood_pft = cawoodmes
       cfroot_pft = cfrootmes
       grid_area  = gridocpmes
    endif 
    
    !     Check if equilibrium is attained
    !     --------------------------------
    if (k.eq.12) then
       ! open (unit=1234,file='exec_log.txt',status='unknown',&
          ! &form='formatted',position='append', action='write')
       land_c = 0.0
       wsoilt(k) = 0.0
       gsoilt(k) = 0.0
       sm = gridocpmes / 100.0
       
       land_c=sum((cleafmes*sm))+sum((cfrootmes*sm))+sum((cawoodmes*sm))
       
       do p = 1,q
          wsoilt(k) = wsoilt(k) + wsoil_pft(p,k)
          gsoilt(k) = gsoilt(k) + gsoil(p,k)
       enddo
       
       nerro = 0
       
       do kk=1,nt
          wsaux1 = wsoilt(kk) + gsoilt(kk)   
          dwww = (wsaux1 - wg0(kk)) / wmax
          if (abs(dwww) .gt. 1e-3) nerro = nerro + 1
       enddo
       c_change = abs(abs(land_c) - abs(carbon_test)) ! Kg/m2
       if(c_change .gt. 1e-2) then
          nerro = 1
          carbon_test = land_c
       endif
!       if (n .ge. 1350) then
!         nerro = 0
!       endif
       ! write(1234,1972) n,land_c
       ! close(1234)
       if (nerro.ne.0) then          
          do kk=1,12
             wg0(kk) = wsoilt(kk) + gsoilt(kk)
          enddo
       else
!          print *, n, 'exiting'
          goto 100
       endif
    endif
  goto 10
  
  100 continue

! 1972 format (i12,f20.4)
end subroutine wbm

end module water_balance

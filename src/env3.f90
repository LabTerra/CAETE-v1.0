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


program env
  
  use global_pars
    use photo, only: spinup, pft_par2
  use water_balance
  
  implicit none
  !     
  !     =======================================================================
  !     CPTEC-PVM2
  !     Adapted from env4.f.
  !     Code written by David Lapola and Helena Alves do Prado e Bianca Rius & jpdarela
  !     Last update: jan/2017
  !     Compile with: gfortran commom.f90 env3.f90 prod3.f90 
  !     Execute with ./a.exe
  !     =======================================================================
  
  !     Parameters and variables
  !     ------------------------     
  integer(kind=i4) :: i,j,k,p
  integer(kind=i4),parameter :: q = npls
  integer(kind=i4),parameter :: nt = ntimes
  integer(kind=i4),parameter :: ntr = ntraits
  real(kind=r4),parameter :: no_data = -9999.0
  !     
  !   Model  Inputs
  !   -------------  
  real(kind=r4) :: lsmk(nx,ny)          !Land=1/Ocean=0
  real(kind=r4) :: p0(nt)         !Atmospheric pressure (mb)
  real(kind=r4) :: ps(nx,ny,nt)         ! auxiliar to read atm pressure information
  real(kind=r4) :: prec(nt)       !Precipitation (mm/month)
  real(kind=r4) :: pr(nx,ny,nt)         !Auxiliar_precipitation (mm/month)
  real(kind=r4) :: temp(nt)       !Temperature (oC)
  real(kind=r4) :: t(nx,ny,nt)          !Auxiliar_temperature (oC)
  real(kind=r4) :: par(nt)        !Incident photosynthetic active radiation (Ein/m2/s)
  real(kind=r4) :: ipar(nx,ny,nt)       !Auxiliar_incident photosynthetic active radiation (w/m2)
  real(kind=r4) :: rhs(nt)        !Relative humidity
  real(kind=r4) :: rhaux(nx,ny,nt)      !RHS auxiliar
  
  real(kind=r4),dimension(q,ntr) :: dt = 0
  real(kind=r4),dimension(q) :: cleafin = 0.0
  real(kind=r4),dimension(q) :: cawoodin = 0.0
  real(kind=r4),dimension(q) :: cfrootin = 0.0
  
  !    Model Outputs
  !    -------------
  real(kind=r4),dimension(nt) :: emaxm = 0.0
  real(kind=r4),dimension(nt) :: tsoil = 0.0
  
  real(kind=r4),dimension(nt,q) :: photo_pft = 0.0 !Monthly photosynthesis   (kgC/m2)
  real(kind=r4),dimension(nt,q) :: aresp_pft = 0.0 !Monthly autotrophic res  (kgC/m2)
  real(kind=r4),dimension(nt,q) :: rm_pft    = 0.0
  real(kind=r4),dimension(nt,q) :: rg_pft    = 0.0
  real(kind=r4),dimension(nt,q) :: npp_pft   = 0.0  !Monthly net primary produ (kgC/m2)
      
  real(kind=r4),dimension(nt,q) :: lai_pft = 0.0  !Monthly leaf area index
  real(kind=r4),dimension(nt,q) :: clit_pft = 0.0 !Monthly litter carbon
  real(kind=r4),dimension(nt,q) :: csoil_pft = 0.0 !Monthly soil carbon
  real(kind=r4),dimension(nt,q) :: hresp_pft = 0.0 !Monthly het resp          (kgC/m2)
  real(kind=r4),dimension(nt,q) :: rcm_pft = 0.0 
  
  real(kind=r4),dimension(nt,q) :: runom_pft = 0.0 !Runoff
  real(kind=r4),dimension(nt,q) :: evapm_pft = 0.0 !Actual evapotranspiration        
  real(kind=r4),dimension(nt,q) :: wsoil_pft = 0.0 !Soil moisture (mm)
  
  real(kind=r4),dimension(q) :: cleaf_pft = 0.0
  real(kind=r4),dimension(q) :: cawood_pft = 0.0
  real(kind=r4),dimension(q) :: cfroot_pft = 0.0
  real(kind=r4),dimension(q) :: gridcell_ocp = 0.0 !  final grid cell occupation for each pft (percentage of area)

  real(kind=r4),dimension(nx,ny,q) :: grd_ocp = 0.0
  real(kind=r4),dimension(nx,ny,q) :: clini = 0.0
  real(kind=r4),dimension(nx,ny,q) :: cfini = 0.0
  real(kind=r4),dimension(nx,ny,q) :: cwini = 0.0
  real(kind=r4),dimension(nx,ny,q) :: clfim = 0.0
  real(kind=r4),dimension(nx,ny,q) :: cffim = 0.0
  real(kind=r4),dimension(nx,ny,q) :: cwfim = 0.0


  !     variaveis do spinup
  real(kind=r4) npp_sca 
  real(kind=r4),dimension(nx,ny,nt) :: npp_pot
  real(kind=r4),dimension(q) :: aux1, aux2, aux3
  real(kind=r4),dimension(nx,ny) :: aux_npp 

  
  real(kind=r4),dimension(nx,ny) :: ave_ph = 0.0
  real(kind=r4),dimension(nx,ny) :: ave_ar = 0.0
  real(kind=r4),dimension(nx,ny) :: ave_npp = 0.0
  real(kind=r4),dimension(nx,ny) :: ave_lai = 0.0
  real(kind=r4),dimension(nx,ny) :: ave_clit = 0.0
  real(kind=r4),dimension(nx,ny) :: ave_cs = 0.0
  real(kind=r4),dimension(nx,ny) :: ave_hr = 0.0
  real(kind=r4),dimension(nx,ny) :: ave_rc = 0.0
  real(kind=r4),dimension(nx,ny) :: ave_runom = 0.0
  real(kind=r4),dimension(nx,ny) :: ave_evap = 0.0
  real(kind=r4),dimension(nx,ny) :: ave_wsoil = 0.0    

      
  real(kind=r4), dimension(nx,ny,nt) :: ph = 0.0
  real(kind=r4), dimension(nx,ny,nt) :: ar = 0.0
  real(kind=r4), dimension(nx,ny,nt) :: npp = 0.0
  real(kind=r4), dimension(nx,ny,nt) :: lai = 0.0
  real(kind=r4), dimension(nx,ny,nt) :: clit = 0.0
  real(kind=r4), dimension(nx,ny,nt) :: csoil = 0.0
  real(kind=r4), dimension(nx,ny,nt) :: hr = 0.0
  real(kind=r4), dimension(nx,ny,nt) :: rcm = 0.0
  real(kind=r4), dimension(nx,ny,nt) :: evaptr = 0.0
  real(kind=r4), dimension(nx,ny,nt) :: wsoil = 0.0
  real(kind=r4), dimension(nx,ny,nt) :: runom = 0.0
  
  real(kind=r4), dimension(nx,ny,nt) :: rm = 0.0
  real(kind=r4), dimension(nx,ny,nt) :: rg = 0.0


  integer(kind=i1), dimension(nx,ny,nt) :: lsmk12
  integer(kind=i1), dimension(nx,ny,q)  :: lsmk_npft
  integer(kind=i1), dimension(nx,ny)  :: lsmk1


  !     Open INPUT files
  !     ==========
  open( 9,file='./inputs/lsmk.bin',status='old',form='unformatted'&
       &,access='direct',recl=4*nx*ny)

  open(10,file='./inputs/ps.bin',status='old',form='unformatted'&
       &,access='direct',recl=4*nx*ny)

  open(11,file='./inputs/pr.bin',status='old',form='unformatted'&
       &,access='direct',recl=4*nx*ny)
      
  open(12,file='./inputs/tas.bin',status='old',form='unformatted'&
       &,access='direct',recl=4*nx*ny)
      
  open(13,file='./inputs/rsds.bin',status='old',form='unformatted'&
       &,access='direct',recl=4*nx*ny)

  open(14,file='./inputs/hurs.bin',status='old',form='unformatted'&
       &,access='direct',recl=4*nx*ny)

  open(26,file='./inputs/npp.bin',status='old',form='unformatted'&
       &,access='direct',recl=4*nx*ny)

  !     Read data
  !     =========
  read (9,rec=1) lsmk
  !c     read (26,rec=1) aux_npp       
  call readx(10,ps,12)
  call readx(11,pr,12)
  call readx(12,t,12)
  call readx(13,ipar,12)
  call readx(14,rhaux,12)
  call readx(26,npp_pot,12)
      
  !     Close files
  !     ===========
  close( 9)
  close(10)
  close(11)
  close(12)
  close(13)
  close(14)
  close(26)


  !make integer masks
  do i=1,nx
    do j=1,ny
          lsmk1(i,j) = nint(lsmk(i,j), kind=i1)
    enddo
  enddo

  !make lsmk12
  do i=1,nx
    do j=1,ny
       do k=1,nt
          lsmk12(i,j,k) = nint(lsmk(i,j), kind=i1)
       enddo
    enddo
  enddo
  !make lsmk_npft
  do i=1,nx
    do j=1,ny
       do k=1,q
          lsmk_npft(i,j,k) = nint(lsmk(i,j), kind=i1)
       enddo
    enddo
  enddo



  where (lsmk12 .eq. 0)
     ph     = no_data
     ar     = no_data
     npp    = no_data
     lai    = no_data
     clit   = no_data
     csoil  = no_data
     hr     = no_data
     rcm    = no_data
     runom  = no_data
     evaptr = no_data
     wsoil  = no_data
     rm     = no_data
     rg     = no_data
  elsewhere
     ph     = 0.0
     ar     = 0.0
     npp    = 0.0
     lai    = 0.0
     clit   = 0.0
     csoil  = 0.0
     hr     = 0.0
     rcm    = 0.0
     runom  = 0.0
     evaptr = 0.0
     wsoil  = 0.0
     rm     = 0.0
     rg     = 0.0
  end where

  where (lsmk_npft .eq. 0)
     clfim   = no_data
     cffim   = no_data
     cwfim   = no_data
     grd_ocp = no_data
     clini   = no_data
     cfini   = no_data
     cwini   = no_data
  elsewhere
     clfim   = 0.0
     cffim   = 0.0
     cwfim   = 0.0
     grd_ocp = 0.0
     clini   = 0.0
     cfini   = 0.0
     cwini   = 0.0
  end where

  !c     Calculating annual npp
  do i =1,nx
     do j=1,ny
        if(nint(lsmk(i,j)) .eq. 1) then 
           aux_npp(i,j) = 0.0
           do k = 1,nt
              aux_npp(i,j) = aux_npp(i,j) + (npp_pot(i,j,k)/real(nt)) 
           enddo
        else
           aux_npp(i,j) = no_data
        endif
     enddo
  enddo

  call pft_par2(dt)
 
!$OMP PARALLEL DO 
  do i=1,nx
     print*, 'running column', i
     do j=1,ny
        if (nint(lsmk(i,j)) .eq. 1) then
           ! run spinup
           npp_sca = aux_npp(i,j)
           aux1 = 0.0
           aux2 = 0.0
           aux3 = 0.0   
           
           call spinup(npp_sca,dt, aux1, aux2, aux3)  
           
           cleafin  = aux1
           cfrootin = aux2
           cawoodin = aux3
           !     ----end spinup
           
           
           rhs  = rhaux (i,j,1:nt) 
           par  = ipar  (i,j,1:nt)
           temp = t     (i,j,1:nt) 
           p0   = ps    (i,j,1:nt) 
           prec = pr    (i,j,1:nt)

           
           
           call wbm (dt,prec,temp,p0,par,rhs,cleafin,cawoodin,cfrootin,&
                &    emaxm, tsoil, photo_pft,aresp_pft,npp_pft,lai_pft,&
                &    clit_pft,csoil_pft, hresp_pft,rcm_pft,runom_pft,&
                &    evapm_pft,wsoil_pft,rm_pft,rg_pft,cleaf_pft,cawood_pft,&
                &    cfroot_pft,gridcell_ocp)
           
           
           clfim(i,j,1:p) = cleaf_pft
           cffim(i,j,1:p) = cfroot_pft
           cwfim(i,j,1:p) = cawood_pft
           grd_ocp(i,j,1:p) = gridcell_ocp
           clini(i,j,1:p) = cleafin
           cfini(i,j,1:p) = cfrootin
           cwini(i,j,1:p) = cawoodin
           
           do p = 1,q
              do k = 1,nt
                 ph(i,j,k) = ph(i,j,k) + photo_pft(k,p)
                 ar(i,j,k) = ar(i,j,k) + aresp_pft(k,p)
                 npp(i,j,k) = npp(i,j,k) + npp_pft(k,p)
                 lai(i,j,k) = lai(i,j,k) + lai_pft(k,p)
                 clit(i,j,k) = clit(i,j,k) + clit_pft(k,p)
                 csoil(i,j,k) = csoil(i,j,k) + csoil_pft(k,p)
                 hr(i,j,k) = hr(i,j,k) + hresp_pft(k,p)
                 rcm(i,j,k) = rcm(i,j,k) + rcm_pft(k,p)
                 runom(i,j,k) = runom(i,j,k) + runom_pft(k,p)
                 evaptr(i,j,k) = evaptr(i,j,k) + evapm_pft(k,p)
                 wsoil(i,j,k) = wsoil(i,j,k) + wsoil_pft(k,p)
                 rm(i,j,k)  = rm(i,j,k) + rm_pft(k,p)
                 rg(i,j,k)  = rg(i,j,k) + rg_pft(k,p)
              enddo
           enddo
        endif
     enddo
  enddo
!$OMP END PARALLEL DO

  open(10,file='./spinup/gridcell_ocp.bin',&
       &    status='unknown',form='unformatted',&
       &    access='direct',recl=4*nx*ny)
  call savex(10, grd_ocp, q)
  
  open(10,file='./spinup/cleaf.bin',&
       &    status='unknown',form='unformatted',&
       &    access='direct',recl=4*nx*ny)
  call savex(10, clfim, q)
  
  open(10,file='./spinup/cawood.bin',&
       &    status='unknown',form='unformatted',&
       &    access='direct',recl=4*nx*ny)
  call savex(10,cwfim,q)
  
  open(10,file='./spinup/cfroot.bin',&
       &    status='unknown',form='unformatted',&
       &    access='direct',recl=4*nx*ny)
  call savex(10, cffim,q)
  
  open(10,file='./spinup/clini.bin',&
       &    status='unknown',form='unformatted',&
       &    access='direct',recl=4*nx*ny)
  call savex(10, clini, q)
  
  open(10,file='./spinup/cwini.bin',&
       &    status='unknown',form='unformatted',&
       &    access='direct',recl=4*nx*ny)
  call savex(10,cwini,q)
  
  open(10,file='./spinup/cfini.bin',&
       &    status='unknown',form='unformatted',&
       &    access='direct',recl=4*nx*ny)
  call savex(10, cfini,q)
  
  
  do i = 1,nx
     do j = 1,ny
        if(nint(lsmk(i,j)) .ne. 0) then
           do k = 1,12
              ave_ph(i,j) = ave_ph(i,j) + ph(i,j,k)/12.
              ave_ar(i,j) = ave_ar(i,j) + ar(i,j,k)/12.
              ave_npp(i,j) = ave_npp(i,j) + npp(i,j,k)/12.
              ave_lai(i,j) = ave_lai(i,j) + lai(i,j,k)/12.
              ave_clit(i,j) = ave_clit(i,j) + clit(i,j,k)/12.
              ave_cs(i,j) = ave_cs(i,j) + csoil(i,j,k)/12.
              ave_hr(i,j) = ave_hr(i,j) + hr(i,j,k)/12.
              ave_rc(i,j) = ave_rc(i,j) + rcm(i,j,k)/12.
              ave_runom(i,j) = ave_runom(i,j) + runom(i,j,k)/12.
              ave_evap(i,j) = ave_evap(i,j) + evaptr(i,j,k)/12.
              ave_wsoil(i,j) = ave_wsoil(i,j) + wsoil(i,j,k)/12.
           enddo
        else
           ave_ph(i,j) = no_data
           ave_ar(i,j) = no_data
           ave_npp(i,j) = no_data
           ave_lai(i,j) = no_data
           ave_clit(i,j) = no_data
           ave_cs(i,j) = no_data
           ave_hr(i,j) = no_data
           ave_rc(i,j) = no_data
           ave_runom(i,j) = no_data
           ave_evap(i,j) = no_data
           ave_wsoil(i,j) = no_data
        endif
     enddo
  enddo
  
  open(50,file='./outputs/ambientais.bin',&
       &        status='unknown',form='unformatted',&
       &        access='direct',recl=4*nx*ny)
  write(50,rec=1) ave_npp
  write(50,rec=2) ave_rc
  write(50,rec=3) ave_ar
  write(50,rec=4) ave_lai
  write(50,rec=5) ave_clit
  write(50,rec=6) ave_cs
  write(50,rec=7) ave_hr
  write(50,rec=8) ave_runom
  write(50,rec=9) ave_evap
  write(50,rec=10) ave_wsoil
  write(50,rec=11) ave_ph
  close(50)
  
  
!!$  open(10,file='../outputs/ph.bin',&
!!$       &     status='unknown',form='unformatted',&
!!$       &     access='direct',recl=4*nx*ny)
!!$  call save_file12(10, ph)
!!$  
!!$  open(10,file='../outputs/ar.bin',&
!!$       &     status='unknown',form='unformatted',&
!!$       &     access='direct',recl=4*nx*ny)
!!$  call save_file12(10, ar)
!!$  
!!$  open(10,file='../outputs/npp.bin',&
!!$       &     status='unknown',form='unformatted',&
!!$       &     access='direct',recl=4*nx*ny)
!!$  call save_file12(10, npp)
!!$  
!!$  open(10,file='../outputs/clit.bin',&
!!$       &     status='unknown',form='unformatted',&
!!$       &     access='direct',recl=4*nx*ny)
!!$  call save_file12(10, clit)
!!$  
!!$  open(10,file='../outputs/csoil.bin',&
!!$       &     status='unknown',form='unformatted',&
!!$       &     access='direct',recl=4*nx*ny)
!!$  call save_file12(10, csoil)
!!$  
!!$  open(10,file='../outputs/hr.bin',&
!!$       &     status='unknown',form='unformatted',&
!!$       &     access='direct',recl=4*nx*ny)
!!$  call save_file12(10, hr)
!!$  
!!$  open(10,file='../outputs/rcm.bin',&
!!$       &     status='unknown',form='unformatted',&
!!$       &     access='direct',recl=4*nx*ny)
!!$  call save_file12(10, rcm)
!!$  
!!$  open(10,file='../outputs/runom.bin',&
!!$       &     status='unknown',form='unformatted',&
!!$       &     access='direct',recl=4*nx*ny)
!!$  call save_file12(10, runom)
!!$  
!!$  open(10,file='../outputs/evaptr.bin',&
!!$       &     status='unknown',form='unformatted',&
!!$       &     access='direct',recl=4*nx*ny)
!!$  call save_file12(10, evaptr)
!!$  
!!$  open(10,file='../outputs/wsoil.bin',&
!!$       &     status='unknown',form='unformatted',&
!!$       &     access='direct',recl=4*nx*ny)
!!$  call save_file12(10, wsoil)
!!$  
!!$  open(10,file='../outputs/rm.bin',&
!!$       &     status='unknown',form='unformatted',&
!!$       &     access='direct',recl=4*nx*ny)
!!$  call save_file12(10, rm)
!!$  
!!$  open(10,file='../outputs/rg.bin',&
!!$       &     status='unknown',form='unformatted',&
!!$       &     access='direct',recl=4*nx*ny)
!!$  call save_file12(10, rg)

  stop

contains
  
  subroutine readx(nunit,var,x)
    use global_pars
    implicit none
    integer(kind=i4), intent(in) ::  nunit,x
    real(kind=r4),intent(inout) :: var(nx,ny,x)
    real(kind=r4) :: aux(nx,ny)
    integer(kind=i4) :: i,j,k
    do k=1,x
       read(nunit,rec=k) aux
       do i=1,nx
          do j=1,ny
             var(i,j,k) = aux(i,j)
          enddo
       enddo
    enddo
    return
  end subroutine readx
  !     ================================
  
  subroutine save_file12(nunit, var)
    use global_pars
    implicit none

    integer(kind=i4), intent(in) ::  nunit
    real(kind=r4),intent(in) :: var(nx,ny,ntimes)
    real(kind=r4) :: waux(nx,ny)
    integer(kind=i4) :: i,j,k
    do k=1,ntimes
       do i=1,nx
          do j=1,ny
             waux(i,j) = var(i,j,k)
          enddo
       enddo
       write(nunit,rec=k) waux
    enddo
    close(nunit)
    return
  end subroutine save_file12
  
  subroutine savex(nunit, var, x)
    use global_pars
    implicit none

    integer(kind=i4), intent(in) ::  nunit,x
    real(kind=r4),intent(in) :: var(nx,ny,x)
    real(kind=r4) :: waux(nx,ny)
    integer(kind=i4) :: i,j,k
    do k=1,x
       do i=1,nx
          do j=1,ny
             waux(i,j) = var(i,j,k)
          enddo
       enddo
       write(nunit,rec=k) waux
    enddo
    close(nunit)
    return
  end subroutine savex
  
end program env
    

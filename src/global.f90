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

module types
  
  implicit none

  integer,parameter :: l1 = 4
  integer,parameter :: i1 = 2
  integer,parameter :: i4 = 4
  integer,parameter :: r4 = kind(0.0)
  integer,parameter :: r8 = kind(0.0D0)
  integer,parameter :: rbig = selected_real_kind(26,302)

end module types



module global_pars
  use types
  implicit none

  real(kind=r4),parameter :: H = 1.0                         ! soil layer thickness (meters)
  real(kind=r4),parameter :: DIFFU = 1.036800e14 ! soil thermal diffusivity (m2/mes)
  real(kind=r4),parameter :: TAU = (H**2)/(2.0*diffu)  ! e-folding times (months) 
  real(kind=r4),parameter :: rcmax = 450.0
  real(kind=r4),parameter :: rcmin = 100.0
  real(kind=r4),parameter :: ca = 350.0 ! ppmv - atm[CO2]
  real(kind=r4),parameter :: wmax = 500.0
  real(kind=r4),parameter :: cmin = 5e-3
  
  real(kind=r8),parameter :: csru = 0.5
  real(kind=r8),parameter :: alfm = 1.391
  real(kind=r8),parameter :: gm = 3.26 * 86400  !(*86400 transform s/mm to dia/mm)

  real(kind=r8),parameter :: ncl = (1.0/29.0)          !(gN/gC) from lpj3 
  real(kind=r8),parameter :: ncf = (1.0/29.0)          !(gN/gC)
  real(kind=r8),parameter :: ncs = (1.0/330.0)         !(gN/gC)

!  integer(kind=i4) :: ndmonth(12)       !Number of months
!  data ndmonth /31,28,31,30,31,30,31,31,30,31,30,31/ !Number of days for each month

  integer(kind=i4),parameter :: npls = 500
  integer(kind=i4),parameter :: ntimes = 12
  integer(kind=i4),parameter :: ntraits = 8

  integer(kind=i4),parameter :: nx = 720, ny = 360
  
end module global_pars

module photo_par
  use types, only : r8
  implicit none
  ! setting some parameter values
  real(kind=r8), parameter ::       &
       a   = 0.8300       ,&          !Photosynthesis co-limitation coefficient
       a2  = 0.930        ,&          !Photosynthesis co-limitation coefficient
       p3  = 21200.0      ,&          !Atmospheric oxygen concentration (Pa)
       p4  = 0.080        ,&          !Quantum efficiency (mol electrons/Ein)
       p5  = 0.150        ,&          !Light scattering rate
       p6  = 2.0          ,&          !Parameter for jl
       p7  = 0.50         ,&          !Ratio of light limited photosynthesis to Rubisco carboxylation
       p8  = 5200.0       ,&          !Photo-respiration compensation point
       p9  = 0.570        ,&          !Photosynthesis co-limitation coefficient
       p10 = 0.100        ,&          !Q10 function
       p11 = 25.0         ,&          !Q10 function reference temperature (oC)
       p12 = 30.0         ,&          !Michaelis-Menten constant for CO2 (Pa)
       p13 = 2.100        ,&          !Michaelis-Menten constant for CO2
       p14 = 30000.0      ,&          !Michaelis-Menten constant for O2 (Pa)
       p15 = 1.20         ,&          !Michaelis-Menten constant for O2
       p19 = 0.90         ,&          !Maximum ratio of internal to external CO2
       p20 = 0.10         ,&          !Critical humidity deficit (kg/kg)
       p22 = 2.0          ,&          !Rubisco carboxylation rate
       p23 = 0.30         ,&          !Rubisco carboxylation rate
       p24 = 36.0         ,&          !Rubisco carboxylation rate (oC)
       p25 = 0.000008     ,&          !Maximum gross photosynthesis rate (molCO2/m2/s)
       p26 = 0.50         ,&          !light extinction coefficient for IPAR/sun (0.5/sen90)
       p27 = 1.50         ,&          !light extinction coefficient for IPAR/shade (0.5/sen20)
       p28 = 0.500        ,&          !Soil moisture at field capacity
       p29 = 0.205        ,&          !Soil moisture at wilting point
       p30 = 0.015        ,&          !Ratio of respiration to Rubisco carboxylation rates
       p31 = 3.850        ,&            !Whole plant to leaf respiration ratio
       p32 = 2.00         ,&
       p33 = 0.10         ,&
       p34 = 0.30         ,&
       p35 = 0.05         ,&
       p36 = 0.25
    
end module photo_par

# CAETE-v1.0

Repo for code development-AmazonFACE/CAETE_Project

_More recent version:_ **/CAETE-v1.0**

**_Important files:_**

## Model (Fortran90)
These files are adapted from CPTEC-PVM2. There are several changes 
implemented by the LabTerra team. Important files here are:

	    global_pars.f90
	    funcs.f90
	    productivity.f90
	    budget.f90
	    water_balance.f90

In the /src/ folder execute ./build.sh to compile the shared object containing the model code.
This will create a file named caete_module.cpython-35m-x86_64-linux-gnu.so or similar on the /src/ directory

## Model driver (Python 3)
Files related to model execution: caete.py implements the type 
gridcell, which is the basic building block. The model is applied
on instances of it (in parallel execution[multiprocess]). caete_pfts.py is a version of caete.py prepared for runs 
in PFTs mode. caete_driver.py implements a cycle of executions 
in PLSs and in PFTs mode.

      	    caete_driver.py
      	    caete_pfts.py
      	    caete.py

## Running the model

In the /src/ execute:
        python3 caete_driver.py
or
        ipython3 caete_driver.py

and follow the instructions. Don't execute the model in PFT mode.

**Software dependencies:**

	   python-3.5.x + numpy-1.11.x (**f2py3-2**) + netCDF4-1.2.6 
	   gfortran-5.x or gfortran-6.x


## Compiling The Model

# These instructions only for development
**1-_Shared object_**

Use f2py to compile fortran code:

    $ f2py3 -c global.f90 funcs.f90 productivity.f90 budget.f90 waterbalance.f90 -m caete_module

_Hint:_ Be shure that f2py you're using is linked with python3.5 libraries


[f2py user guide](https://docs.scipy.org/doc/numpy-1.11.0/f2py/index.html)
[~~Using f2py~~](http://websrv.cs.umt.edu/isis/index.php/F2py_example)

contact :: darelafilho [at] gmail.com
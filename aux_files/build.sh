#!/bin/bash

# Clean the room
./clean_dir.sh

## Maybe you need to change the python executable  accortding your system
python -m numpy.f2py -h caete_module.pyf global.f90 funcs.f90 productivity.f90 budget.f90 water_balance.f90 -m caete_module --overwrite-signature
python -m numpy.f2py caete_module.pyf -c global.f90 funcs.f90 productivity.f90 budget.f90 water_balance.f90





#!/bin/bash

./clean_dir.sh
f2py3.5 -h caete_module.pyf global.f90 funcs.f90 productivity.f90 budget.f90 water_balance.f90 -m caete_module --overwrite-signature
f2py3.5 caete_module.pyf -c global.f90 funcs.f90 productivity.f90 budget.f90 water_balance.f90


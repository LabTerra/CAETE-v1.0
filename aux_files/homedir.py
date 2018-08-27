"""MODULE - helper with filepaths
   """

import os

py_executable = 'ipython3'

HOMEDIR = os.sep.join(['', 'home', 'amazonfaceme','jpdarela'])
RESULTS_DIR = os.sep.join([HOMEDIR, 'results_nCO2'])
TMP_DIR = os.sep.join([HOMEDIR, 'tmp'])
OUTPUT_NC_DIR = os.sep.join([TMP_DIR, 'outputs'])

# Path to save all pls_attrs.csv renamed with run information
SAVE_CSV_FILES = os.sep.join([HOMEDIR, 'csv_outputs'])
# Path to save the final files for each set of runs
SAVE_CSV_FINAL = os.sep.join([HOMEDIR, 'csv_final'])


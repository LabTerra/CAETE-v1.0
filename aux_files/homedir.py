"""MODULE - helper with filepaths
   """

import os
# CHANGE HOMEDIR to make tests in forks
# for example: to run in sombrero make HOMEDIR = os.sep.join(['','home','amazonfaceme','your username'])


py_executable = 'ipython3'
HOMEDIR = os.sep.join(['', 'home', 'jpdarela', 'Desktop'])
RESULTS_DIR = os.sep.join([HOMEDIR, 'results'])
TMP_DIR = os.sep.join([HOMEDIR, 'tmp'])
OUTPUT_NC_DIR = os.sep.join([TMP_DIR, 'outputs_nc'])

# EDIT AND SAVE IN your /src folder (in your fork)
# py_executable = 'python'
# HOMEDIR = os.sep.join(['C:', 'Users', 'jpdarela', 'Desktop'])

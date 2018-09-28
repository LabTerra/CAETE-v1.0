import os
import sys

from glob import glob1


# Import filepaths from homedir
sys.path.insert(0, '../src/')
import homedir

# This variable must store the correct path to the results folder
data_dir = homedir.RESULTS_DIR


root_dir = os.getcwd()
os.chdir(data_dir)

out_dir = os.getcwd()

for f in os.listdir(os.getcwd()):
    # print(f)
    if os.path.isdir(f):
        os.chdir(f)
        f_cont = glob1(os.getcwd(), '*.tar.gz')
        if len(f_cont) > 0:
            for i in f_cont:
                os.system('tar -xvzf %s' %i)
                os.system('rm -rf %s' %i)
        else:
            pass
        os.chdir(out_dir)
os.chdir(root_dir)


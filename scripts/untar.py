import os
import sys
from glob import glob1
import concurrent.futures as conc


sys.path.insert(0, '../src/')
import homedir

# path to the results folder
data_dir = homedir.RESULTS_DIR
root_dir = os.getcwd()

# Goto outputs base directory 
os.chdir(data_dir)

def untar_file(filename):
    os.system('tar -xvzf %s' %filename)
    os.system('rm -rf %s' %filename)

def process_folder(f):
    
    out_dir = os.getcwd()
    
    #if os.path.isdir(f):
    os.chdir(f)
    f_cont = glob1(os.getcwd(),"*.tar.gz")
    n_files = len(f_cont)
    #print(f_cont)
    #print(n_files)
    if n_files > 0:
        with conc.ThreadPoolExecutor(max_workers=n_files) as executor:
            for fl in f_cont:
                f2 = executor.submit(untar_file, fl)
    os.chdir(out_dir)


folders_to_process = os.listdir(os.getcwd())

print(folders_to_process)

for directory in folders_to_process:
    process_folder(directory)

os.chdir(root_dir)

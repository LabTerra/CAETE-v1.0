import os
from glob import glob1

root_dir = os.getcwd()
os.chdir("/home/amazonfaceme/jpdarela/results_2018_nCO2")

out_dir = os.getcwd()

for f in os.listdir(os.getcwd()):
    # print(f)
    if os.path.isdir(f):
        os.chdir(f)
        f_cont = glob1(os.getcwd(), '*.tar.gz')
        if len(f_cont) > 0:
            for i in f_cont:
                #out_name = i.split('.')[0] + .nc
                # print(i)
                os.system('tar -xvzf %s' %i)
                #os.system('rm -rf %s' %i)
        else:
            pass
        os.chdir(out_dir)
os.chdir(root_dir)


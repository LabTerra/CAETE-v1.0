from os import system
from glob import glob1

od = "./outputs_nc"
files = sorted(glob1("./outputs_nc", '*.tar.gz'))
#names = [f.split('.')[0] for f in files]
files = [od + '/' + f for f in files]
#out  = [od + '/'+ n + '.tar.gz' for n in names]


for ft in files:
    #print ft
    system('tar -xvzf %s' %ft)

system('rm -rf ./outputs_nc/*.tar.gz')


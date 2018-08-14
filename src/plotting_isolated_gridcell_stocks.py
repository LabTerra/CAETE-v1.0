import caete as ct 
import pandas as pd
import csv

grd1 = ct.gridcell(239,183)
ct.init_caete(grd1)
ct.run_model(grd1)

npls= input('quantos pls?')
npls = int(npls)

cleaf = grd1.cleaf.sum(axis=0)
cawood = grd1.cawood.sum(axis=0)
cfroot = grd1.cfroot.sum(axis=0)

cleaf = cleaf/(npls)
cawood = cawood/(npls)
cfroot = cfroot/(npls)

cmass = cleaf+cawood+cfroot

biomass = [['cleaf','cawood','cfroot','cmass'],[cleaf,cawood,cfroot,cmass]]
my_df = pd.DataFrame(biomass)
my_df.to_csv('biomass_10-09-18.csv',index=True, header=False)
print(my_df)




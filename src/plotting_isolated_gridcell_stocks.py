import caete as ct 
import pandas as pd
import csv

grd1 = ct.gridcell(239,183)
ct.init_caete(grd1)
ct.run_model(grd1)


cleaf = grd1.cleaf*grd1.area/100
cleaf = cleaf.sum(axis=0)
cawood = grd1.cawood*grd1.area/100
cawood = cawood.sum(axis=0)
cfroot = grd1.cfroot*grd1.area/100
cfroot = cfroot.sum(axis=0)


cmass = cleaf+cawood+cfroot

biomass = [['cleaf','cawood','cfroot','cmass'],[cleaf,cawood,cfroot,cmass]]
my_df = pd.DataFrame(biomass)
my_df.to_csv('biomass_10-09-18.csv',index=True, header=False)
print(my_df)




#this program exports the fractional areas occupied by the PLS for
#calculating the functional diversity index


import caete as ct 
import pandas as pd
import csv

grd1 = ct.gridcell(239,183)
ct.init_caete(grd1)
ct.run_model(grd1)

area = grd1.area
area_table = {'area': area}
my_df = pd.DataFrame(area)
my_df.to_csv('area.csv',index=True, header='area')
print(my_df)


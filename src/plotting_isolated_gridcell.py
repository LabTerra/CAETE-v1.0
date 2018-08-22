import caete as ct 
import matplotlib.pyplot as plt 

grd1 = ct.gridcell(239,183)
ct.init_caete(grd1)
ct.run_model(grd1)

npp=grd1.npp.sum(axis=0)
photo=grd1.photo.sum(axis=0)
aresp=grd1.aresp.sum(axis=0)

plt.plot(npp, color='black', label = 'NPP')
plt.plot(photo, color='green', label = 'GPP')
plt.plot(aresp, color='red', label = 'Respiration')

plt.legend(loc='upper left')
plt.xlabel('Months')
plt.ylabel('kgCm-2yr-1')

plt.show()
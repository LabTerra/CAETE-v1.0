
from caete import *
import matplotlib.pyplot as plt

print('this is Manaus gridcell(x=239, y=183')


grd1=gridcell(239,183)
init_caete(grd1)
run_model(grd1)

#print('vocẽ esta vendo photo, aresp e npp ')
plt.plot(grd1.photo.sum(0,))
plt.plot(grd1.aresp.sum(0,))
plt.plot(grd1.npp.sum(0,))

#plt.plot(grd1.cleaf)
#plt.plot(grd1.cawood)
#plt.plot(grd1.cfroot)
plt.show()





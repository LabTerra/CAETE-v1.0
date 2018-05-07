./build.sh
from caete import *
import matplotlib.pyplot as plt

print('this is Manaus gridcell(x=239, y=183')


grd1=gridcell(239,183)
init_caete(grd1)
run_model(grd1)

input('which variable do you want to see? ')
plt.plot(grd1.photo.sum(0,))





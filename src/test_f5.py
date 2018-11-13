import caete
def f1():
    a = caete.gridcell(277,202)   #239,183 
    caete.init_caete(a)
    caete.run_model(a)


    b = caete.gridcell(239,183)   # 
    caete.init_caete(b)
    caete.run_model(b)

import caete_module as model
import numpy as np
import matplotlib.pyplot as plt

def f2():
    a = np.linspace(0,500,100)
    b = np.zeros(100,)

    for i,d in enumerate(a):
        b[i] = model.photo.water_stress_modifier(a[i], 0.1, 2000., 20.)

    plt.plot(a,b)
    plt.show()
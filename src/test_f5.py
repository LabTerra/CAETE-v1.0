
def f1():
    import caete

    a = caete.gridcell(405,227)   #south africa
    caete.init_caete(a)
    caete.run_model(a)
    return a


    # b = caete.gridcell(239,183)   # 
    # caete.init_caete(b)
    # caete.run_model(b)
    # return b

def f2():
    import caete_module as model
    import numpy as np
    import matplotlib.pyplot as plt
    
    a = np.linspace(0,500,100)
    b = np.zeros(100,)

    for i,d in enumerate(a):
        b[i] = model.photo.water_stress_modifier(a[i], 0.6, 300., 2.0)

    plt.plot(a,b)
    plt.show()

import numpy as np # Modulo (library()) para trabalhar com arrays (quase igual a fortran)
import matplotlib.pyplot as plt  # Modulo para fazer gráficos
import caete_module # nosso código de fortran compilado como um modulo de python

x = np.linspace(1,20,100) # função que cria um array x com amplitude de (20 - 1), com 100 elementos
y = np.zeros(100) # cria o array y que guardará os valores resultantes da aplicação do modelo  

for i,d in enumerate(x): 
    y[i] = caete_module.photo.canopy_resistence(0.03, 3e-6, d)
	
plt.plot(x,y)
plt.show()

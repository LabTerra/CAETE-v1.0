"""
Copyright 2017- LabTerra 

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

contacts :: David Montenegro Lapola <lapoladm ( at ) gmail.com> 
            João Paulo Darela Filho <darelafilho ( at ) gmail.com>
"""

import os
import random as rd
import math
import csv
import numpy as np

n = 10 # number of plant life strategies
    
def table_gen(N = n):    
    # Random variables (beta distribution - normalized to min-max ranges of each variable)
    g1 = np.random.uniform(1.01, 20.0, 10000)
    #vcmax = np.random.uniform(3e-5, 25e-5, 10000)
    vcmax = (np.random.beta(1.4, 6.24, 10000) * (150. - 10./1.) + 10) * 1e-6 # 10⁴ elementos
    #jmax = np.linspace(1e-4,3e-4,10) # 10 elementos
    jmax = (np.random.beta(1.4, 6.24, 10000) * (3. - 1./1.) + 1.) * 1e-4 # 10⁴ elementos
    
    tleaf = np.random.uniform(1./12., 8.3, 10000)
    #tleaf = (np.random.beta(3, 6.24,10000) * (100. - 1./1.) + 1.) / 12 # 10⁴ elementos
    twood = np.random.uniform(1., 80., 10000)
    #twood = np.random.beta(6, 6.24,10000) * (80. - 1./1.) + 1. # 10⁴ elementos
    troot = np.random.uniform(1./12, 8.3, 10000)
    #troot = (np.random.beta(3, 6.24,10000) * (100. - 1./1.) + 1.) / 12 # 10⁴ elementos
    
    # constrained distributions (must sum up to 1.) 
    aleaf = np.arange(5,91,1.25) #
    aroot = np.arange(5,91,1.25) # 13
    awood = np.arange(5,81,1.25) # 13
    colnames_a = ['aleaf','awood','aroot']
    plsa_grass = [[a/100,0.0,c/100] for a in aleaf for c in aroot if abs(a+0.0+c)==100.]
    plsa_wood = [[a/100,b/100,c/100] for a in aleaf for b in awood for c in aroot if ((a+b+c)==100.) and (b>19)]
    
    # CREATING ALLOCATION COMBINATIONS
    for i in range(len(plsa_grass)):
        x = plsa_grass.pop()
        if x in plsa_grass:
            pass
        else:
            plsa_grass.insert(0,x)
            
    for i in range(len(plsa_wood)):
        x = plsa_wood.pop()
        if x in plsa_wood:
            pass
        else:
            plsa_wood.insert(0,x)
            
    g2w_ratio = len(plsa_grass)/len(plsa_wood)



    if (len(plsa_wood) + len(plsa_grass)) < N:
        diffg = math.ceil(N * (g2w_ratio) - (len(plsa_grass)))
        diffw = N - diffg
        alloc_w = plsa_wood[:]
        alloc_g = plsa_grass[:]
        while len(alloc_w) <= diffw:
            alloc_w.append(plsa_wood[np.random.randint(0,len(plsa_wood))]) # alterar aqui as distribuições para alloc and tau
        while len(alloc_g) <= diffg:
            alloc_g.append(plsa_grass[np.random.randint(0,len(plsa_grass))])
        
        plsa_wood = alloc_w 
        plsa_grass = alloc_g
        grassN = diffg
        woodN = diffw

    
    else:
        grassN = math.ceil(N * g2w_ratio)
        woodN = N - grassN

    grassN = int(grassN)
    woodN = int(woodN)

    plsa_wood = np.array(plsa_wood,np.float32)
    plsa_grass = np.array(plsa_grass,np.float32)
    np.random.shuffle(plsa_grass)
    np.random.shuffle(plsa_wood)


    alloc_wood = plsa_wood[np.random.randint(0,woodN,woodN)][:]
    alloc_grass = plsa_grass[np.random.randint(0,grassN,grassN)][:]
    alloc = list(np.vstack((alloc_grass, alloc_wood)))
    # COMBINATIONS
    # Random samples from beta distributions (g1, tleaf ...)
    # The sampling is done via indexation of beta distributions
    # with random integers from a  discrete uniform distribution

    
    # ! ['g1','vcmax','tleaf','twood','troot','aleaf','awood','aroot']

    colnames = ['g1','vcmax','tleaf','twood','troot'] + colnames_a
    tau_leaf = list(tleaf[np.random.randint(0,9999,N)][:])
    tau_root = list(troot[np.random.randint(0,9999,N)][:])
    tau_wood = list(twood[np.random.randint(0,9999,N)][:])
    g1_pls = list(g1[np.random.randint(0,9999,N)][:])
    vcmax_pls = list(vcmax[np.random.randint(0,9999,N)][:])
    jmax_pls = list(jmax[np.random.randint(0,9999,N)][:])
    zero = np.zeros(1)
    pls_table = []
    for i in range(len(alloc)):
        if i < grassN:
            aux_arr = np.array([g1_pls[i],vcmax_pls[i],tau_leaf[i],list(zero)[0],tau_root[i]])
            pls = np.hstack((aux_arr,alloc[i]))
        else:
            aux_arr = np.array([g1_pls[i],vcmax_pls[i],tau_leaf[i],tau_wood[i],tau_root[i]])
            pls = np.hstack((aux_arr,alloc[i]))

        pls_table.append(pls)
        
    #pls_table = np.array(pls_table,np.float32)

    # ___side_effects
    with open('pls_attrs.csv', mode='w') as fh:
        writer = csv.writer(fh, delimiter=',')
        writer.writerow(colnames)
        writer.writerows(pls_table)
        
    out_arr = np.array(pls_table,np.float32)
    np.savetxt('pls.txt', out_arr, fmt='%.9f')

#    print('0','g1')  #'g1','vcmax','tleaf','twood','troot'
#    print('1','vcmax')
#    print('2','tleaf')
#    print('3','twood')
#    print('4','troot')
#    print('5','aleaf')
#    print('6','awood')
#    print('7','aroot')
    # ___end___

    
    return out_arr
    


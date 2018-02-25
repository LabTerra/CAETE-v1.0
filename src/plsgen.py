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

from math import ceil
import csv
import numpy as np
from caete_module import photo as model
from caete_module import global_pars as gp

npls = gp.npls

def vec_ranging(vec, min1, max1):
    """ range vec to min max"""

    return vec * ((max1 - min1) + min1)


def check_viability(trait_values):
    """ check the viability of allocation(a) &  residence time(ŧ) combinations"""

    rtur = np.array(model.spinup3(0.01, trait_values))
    if rtur[0] <= 0.01 or rtur[1] <= 0.01:
        return False
    return True


def assertion_data_size(dsize):
    """ Assertion of datasets sizes """

    g2w_ratio = 0.07
    diffg = ceil(dsize * g2w_ratio)
    diffw = int(dsize - diffg)
    assert diffg + diffw == dsize
    return diffg, diffw

def turnover_combinations(verbose=False):
    """CREATE the residence time and allocation combinations"""

    # constrained distributions (must sum up to 1.)
    aleafw = np.arange(15., 86.0, 0.25)
    aleafg = np.arange(15., 86.0, 0.25)
    arootw = np.arange(15., 86.0, 0.25)
    arootg = np.arange(15., 86.0, 0.25)
    awood = np.arange(15., 86.0, 0.25)

    plsa_grass = [[a / 100.0, 0.0, c / 100.0] for a in aleafg for c in arootg \
                   if (a + c) == 100.0]
    plsa_wood = [[a / 100.0, b / 100.0, c / 100.0] for a in aleafw for b in awood \
                  for c in arootw if (a + b + c) == 100.]

    if verbose:
        print('Number of combinations = %d'%(len(plsa_grass) + len(plsa_wood)))

    return np.array(plsa_wood), np.array(plsa_grass)

def table_gen(NPLS):
    """AKA main - generate a trait table for CAETÊ - save it to a .csv"""

    diffg, diffw = assertion_data_size(NPLS)
    plsa_wood, plsa_grass = turnover_combinations(True)

    # Creating Grasses and others c3 and c4
    alloc_w = []
    alloc_g = []

    index0 = 0
    while index0 < diffg:
        restime = np.zeros(shape=(3,), dtype=np.float32)
        allocatio = plsa_grass[np.random.randint(0, plsa_grass.shape[0])]
        restime[0] = vec_ranging(np.random.beta(1, 3), 1/12, 8.3)
        restime[1] = 0.0
        restime[2] = vec_ranging(np.random.beta(1, 3), 1/12, 8.3)
        data_to_test0 = np.concatenate((restime, allocatio), axis=0,)
        if check_viability(data_to_test0):
            alloc_g.append(data_to_test0)
            index0 += 1

    index1 = 0
    while index1 < diffw:
        restime = np.zeros(shape=(3,), dtype=np.float32)
        allocatio = plsa_wood[np.random.randint(0, plsa_wood.shape[0])]
        restime[0] = vec_ranging(np.random.beta(1, 3), 1/12, 8.3)
        restime[1] = vec_ranging(np.random.beta(1, 3), 1, 80.0)
        restime[2] = vec_ranging(np.random.beta(1, 3), 1/12, 8.3)
        data_to_test1 = np.concatenate((restime, allocatio), axis=0,)
        if check_viability(data_to_test1):
            alloc_w.append(data_to_test1)
            index1 += 1

    alloc_g = np.array(alloc_g)
    alloc_w = np.array(alloc_w)

    alloc = np.concatenate((alloc_g, alloc_w), axis=0,)

    # # # COMBINATIONS
    # # # Random samples from  distributions (g1, tleaf ...)
    # # # Random variables
    g1 = vec_ranging(np.random.beta(1.2, 2, NPLS), 1.0, 15.0) # dimensionles
    # # vcmax = np.random.uniform(3e-5, 100e-5,N) # molCO2 m-2 s-1
    vcmax = vec_ranging(np.random.beta(1.2, 2, NPLS), 3e-5, 150e-5)

    stack = (g1, vcmax, alloc[:, 0], alloc[:, 1], alloc[:, 2],
             alloc[:, 3], alloc[:, 4], alloc[:, 5])

    head = ['g1', 'vcmax', 'tleaf', 'twood', 'troot', 'aleaf', 'awood', 'aroot']
    # # for i,x in enumerate(head):
    # #     print(i + 1, ': ',x)

    pls_table = np.vstack(stack)
    # # pls_table_F = np.empty(shape=(15,n),order='F')
    # # pls_table_F = pls_table

    # # ___side_effects
    with open('pls_attrs.csv', mode='w') as fh:
        writer = csv.writer(fh, delimiter=',')
        writer.writerow(head)
        for x in range(pls_table.shape[1]):
            writer.writerow(list(pls_table[:, x]))
        # writer.writerows(pls_table)

    out_arr = np.asfortranarray(pls_table, dtype=np.float32)
    # np.savetxt('pls.txt', out_arr, fmt='%.12f')

    return out_arr

def pls_generator():
    print("running table gen from pls_generator")
    return table_gen(npls)
#(1)

# Global variable! --------------------------------------------
attr_table = pls_generator()
# make_dir_spe(OUTPUT_NC_DIR)

#-*-coding:utf-8-*-
# "CAETÊ"

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

__author__ = "https://github.com/jpdarela/"

import os
import glob
import time
from math import ceil
import multiprocessing as mp
import numpy as np

import homedir
import plsgen as pls
import write_output as wo
import caete_module as C
from caete_module import global_pars as gp

HOME_DIR = homedir.HOMEDIR
RESULTS_DIR = os.sep.join([HOME_DIR, 'results_pft'])

nx = gp.nx
ny = gp.ny
nz = gp .ntimes
npls = gp.npls
mask = np.load('mask.npy')
mask12 = np.load('mask12.npy')
# output variables names
varlist = wo.monthly_out + wo.npls_out


# defining functions that (1)drive model throghout the grid data & (2) save outputs

def pls_generator():
    os.system('ipython3 pfts_bin.py' )
    C.photo.ascii2bin('pft.txt', 'pls.bin', npls, gp.ntraits)

#(1)

# A global var -- nplss-table
pls_generator()
attr_table = np.asfortranarray(C.photo.pft_par().T, dtype=np.float32)

def init_caete(grd):

    grd.pr = global_pr[:, grd.y, grd.x]
    grd.ps = global_ps[:, grd.y, grd.x]
    grd.rsds = global_rsds[:, grd.y, grd.x]
    grd.tas = global_tas[:, grd.y, grd.x]
    grd.rhs = global_rhs[:, grd.y, grd.x]
    grd.npp0 = npp_init[grd.y, grd.x]
    grd.filled = True


def run_model(grd, at=attr_table):

    #print('running_model (inside)')
    if grd.filled and not grd.complete:

        cl, cf, cw = C.photo.spinup(grd.npp0, at)
        grd.clin, grd.cfin, grd.cwin = cl, cf, cw

        outputs = C.water_balance.wbm(at, grd.pr, grd.tas, grd.ps, grd.rsds,
                                      grd.rhs, grd.clin, grd.cwin, grd.cfin)

        grd.emaxm = outputs[0]
        grd.tsoil = outputs[1]
        grd.photo = outputs[2]#.T
        grd.aresp = outputs[3]#.T
        grd.npp = outputs[4]#.T
        grd.lai = outputs[5]#.T
        grd.clit = outputs[6]#.T
        grd.csoil = outputs[7]#.T
        grd.hresp = outputs[8]#.T
        grd.rcm = outputs[9]#.T
        grd.runom = outputs[10]#.T
        grd.evapm = outputs[11]#.T
        grd.wsoil = outputs[12]#.T
        grd.rm = outputs[13]#.T
        grd.rg = outputs[14]#.T
        grd.cleaf = outputs[15]
        grd.cawood = outputs[16]
        grd.cfroot = outputs[17]
        grd.area = outputs[18]
        grd.area0 = outputs[19]
        grd.wue = outputs[20]#.T
        grd.cue = outputs[21]#.T
        grd.complete = True
    else:
        print('Gridcell %s is either not filled or already completed' % grd.name)
        pass


def grd_dict(grd):

    def nan_remove(arr):
        np.place(arr, np.isnan(arr), (0.0,0.0))
        np.place(arr, np.isinf(arr), (0.0,0.0))
        return arr

    if grd.complete:
        a = nan_remove(grd.area)
        w = (nan_remove(grd.cawood)) * (a/100.)
        l = (nan_remove(grd.cleaf))  * (a/100.)
        r = (nan_remove(grd.cfroot)) * (a/100.)

        cmass = w + r + l
        #cmass = cmass.sum(axis=0,)
        grd.output_data = {'clin' : nan_remove(grd.clin),#(npls)
                           'cfin' : nan_remove(grd.cfin),
                           'cwin' : nan_remove(grd.cwin),

                           # Water balance attributes
                           'runom' : nan_remove(grd.runom).sum(axis=0,),
                           'wsoil' : nan_remove(grd.wsoil).sum(axis=0,),
                           'evapm' : nan_remove(grd.evapm).sum(axis=0,),
                           'wue'   : nan_remove(grd.wue).sum(axis=0,),
                           'cue'   : nan_remove(grd.cue).sum(axis=0,),
                           'emaxm' : grd.emaxm,
                           'tsoil' : grd.tsoil,
                           # Carbon balance attributes
                           'photo' : nan_remove(grd.photo).sum(axis=0,),
                           'aresp' : nan_remove(grd.aresp).sum(axis=0,),
                           'hresp' : nan_remove(grd.hresp).sum(axis=0,),
                           'npp'   : nan_remove(grd.npp).sum(axis=0,),
                           'rcm'   : nan_remove(grd.rcm).sum(axis=0,),
                           'lai'   : nan_remove(grd.lai).sum(axis=0,),
                           'clit'  : nan_remove(grd.clit).sum(axis=0,),
                           'csoil' : nan_remove(grd.csoil).sum(axis=0,),

                           # new outputs,
                           'rm'     : nan_remove(grd.rm).sum(axis=0,),
                           'rg'     : nan_remove(grd.rg).sum(axis=0,),
                           'cleaf'  : l,
                           'cawood' : w,
                           'cfroot' : r,
                           'area'   : a,
                           'cmass'  : cmass,
                           'area0'  : nan_remove(grd.area0)}
    else:
        grd.output_data = None

def model_flush(grd):

    grd.tas = None
    grd.rhs = None
    grd.ps = None
    grd.pr = None
    grd.rsds = None

    grd.tsoil = None
    grd.photo = None
    grd.aresp = None
    grd.npp = None
    grd.lai = None
    grd.clit = None
    grd.csoil = None
    grd.hresp = None
    grd.rcm = None
    grd.runom = None
    grd.evapm = None
    grd.wsoil = None
    grd.rm = None
    grd.rg = None
    grd.cleaf = None
    grd.cawood = None
    grd.cfroot = None
    grd.area = None
    grd.area0 = None
    grd.wue = None
    grd.cue = None

def rm_apply(gridcell_obj):
    run_model(gridcell_obj)
    grd_dict(gridcell_obj)
    model_flush(gridcell_obj)
    return gridcell_obj


def catch_nt(input_file, nx, ny, pixel_depht):

    """Get the number of layers in input_file
    input_file = flat binary (from fortran unfformated output)filename
    nx = (int) number of columns
    ny = (int) number of rows
    pixel_depth = (int) stride length in bits
    returns nt = number of layers(records) stored in input_file"""

    image_size = (nx * ny * (pixel_depht / 8)) / 1024 # in bytes
    num_lay = (os.path.getsize(input_file)) / 1024 / image_size
    return int(num_lay)


def catch_data(input_file, layers, nx, ny):

    """Loads the input_file as a np.array once you know
    the number of records in input_file
    input_file = flat binary filename (e.g. '.bin')
    nx = (int) number of columns
    ny = (int) number of rows
    layers = (int) number of layers in input_file * ease with catch_nt()
    returns np.array shape(layers,nx,ny)"""

    Bcount = nx * ny * layers
    return np.fromfile(input_file, count=Bcount,
                       dtype=np.float32).reshape((layers, ny, nx))


#(2)

def assemble(land_data_list, var, x=nx, y=ny):

#   flt_attrs = wo.flt_attrs
    if var in wo.monthly_out:
        z = nz
#       maskz = wo.mask_gen(z)
    elif var in wo.npls_out:
        z = npls
#       maskz = wo.mask_gen(z)
    else:
        print('assemble failed')
        return None

    out_arr = np.zeros(shape=(z, y, x), dtype=np.float32) - 9999.0

    for grdcell in land_data_list:
        data = grdcell.output_data[var]
        px, py = grdcell.pos
        out_arr[:, py, px] = data

    # write netcdf file
    wo.write_CAETE_output(RESULTS_DIR + os.sep + var + '.nc', out_arr, var)
    return True

# classes

class datasets:
    """ """
    def __init__(self, files_dir):

        try:
            self.files = sorted(glob.glob1(files_dir, '*.bin'))
            self.NotWork = False
        except:
            self.files = None
            self.NotWork = True
            print('O diretório indicado não possui arquivos adequados')

        self.files_dir = files_dir
        self.metadata = {}
        return None

    def get_var(self, var):


        if (type(var) == type('str')) and (self.files is not None) and (len(self.files) > 0):
            fname = [filename for filename in self.files if var == filename.split('.')[0]]
        else:
            self.NotWork = True
            return None

        try:
            fname_comp = self.files_dir + os.sep + fname[0]
        except:
            print('variável --> %s não está no diretório -->  %s' % (var, self.files_dir))
            self.NotWork = True
            return None

        try:
            t1 = (fname_comp,720,360,32)
            lr = catch_nt(*t1)
            t2 = (fname_comp,lr,720,360)
            dataset = catch_data(*t2)
        except IOError:
            print('Cannot open %s file' % var)
            self.NotWork = True
            return None
        else:
            pass

        return dataset #np.fliplr(np.array(dataset))

    def check_dataset(self):
        if self.NotWork:
            return False
        return True


class gridcell:

    def __init__(self, x, y):
        # CELL Identifiers
        self.x = x
        self.y = y
        self.pos = (self.x, self.y)
        self.output_data = None
        self.filled = False
        self.complete = False

        # Input data
        self.pr   = None
        self.ps   = None
        self.rsds = None
        self.tas  = None
        self.rhs  = None
        self.npp0 = None

        # Spinup data
        self.clin = None
        self.cfin = None
        self.cwin = None

        # Time attributes
        #self.calendar = 'noleap'
        #self.time_origin = 'days since 1850-01-01'

        # Water balance attributes
        self.runom = None
        self.wsoil = None
        self.evapm = None
        self.emaxm = None
        self.tsoil = None

        # Carbon balance attributes
        self.photo = None
        self.aresp = None
        self.hresp = None
        self.npp   = None
        self.rcm   = None
        self.lai   = None
        self.clit  = None
        self.csoil = None
        self.wue   = None
        self.cue   = None

        # new outputs
        self.rm     = None
        self.rg     = None
        self.cleaf  = None
        self.cawood = None
        self.cfroot = None
        self.area   = None
        self.area0  = None

## GLOBAL VARS

lr = catch_nt('../input/npp.bin', 720, 360, 32)
npp_init = catch_data('../input/npp.bin', lr, 720, 360)
npp_init = np.ma.masked_array(npp_init, mask12)
npp_init = npp_init.mean(axis=0,)

std_shape = (12, 360, 720)

input_data = datasets('../input')
assert input_data.check_dataset()

global_pr = input_data.get_var('pr')
assert global_pr.shape == std_shape
assert input_data.check_dataset()

global_ps = input_data.get_var('ps')
assert global_ps.shape == std_shape
assert input_data.check_dataset()

global_rsds = input_data.get_var('rsds')
assert global_rsds.shape == std_shape
assert input_data.check_dataset()

global_tas = input_data.get_var('tas')
assert global_tas.shape == std_shape
assert input_data.check_dataset()

global_rhs = input_data.get_var('hurs')
assert global_rhs.shape == std_shape
assert input_data.check_dataset()


if __name__ == "__main__":
    if os.path.exists(RESULTS_DIR):
        pass
    else:
        os.mkdir(RESULTS_DIR)

    # iniciando o modelo para todas (land) as celulas do grid
    # este bloco de código cria uma lista que contém n instâncias da
    # classe gridcell (L-288) e depois aplica o modelo a cada uma delas.
    # Preferi deixar esta classe o mais limpa possível, pois as suas instầncias são modificada em
    # paralelo e para isso precisam ser pickladas (veja o modulo pickle e também o modulo multiprocessing)
    
    # Por isso as funções que iniciam e aplicam o modelo a cada instancia de gridcell
    # não são métodos propriamente ditos e sim, funções que manipulam estas instâncias.
    disp_processors = os.cpu_count()
    land_data = []
    id_n = 0
    print('init caete --- %d = npls' % npls, end='---> ')
    print(time.ctime())
    # loop que cria as instâncias de gridcell e atribui os seus valores de input
    for Y in range(130, 250):         # <<--- mude aqui para diminuir o numero de celulas de grid
        for X in range(200, 280):     # <<--- aqui tb. Para Amazônia (ragião de Manaus) ny(140-190), nx(230, 260)
            if not mask[Y][X]:  # apenas na terra (mask is true for ocean, false for land)
                id_n += 1
                grd_cell = gridcell(X, Y)
                init_caete(grd_cell)
                land_data.append(grd_cell)

    # del input arrays
    del global_pr
    del global_ps
    del global_tas
    del global_rhs
    del global_rsds
    del npp_init
    x = dir()
    print('dir() before model run')
    print(x)

    with mp.Pool(processes=disp_processors * 2, maxtasksperchild=40) as p:
        result = p.map(rm_apply, land_data)
    
    print('\nModelo aplicado a %d localidades-- %d PLSs' % (id_n, npls), end='--->')
    print(time.ctime())

    print('\nCALCULANDO SOMAS', end='--->')
    print(time.ctime())

    print('\nSalvando resultados')

    for v in varlist:
        print(v, end='-')
        assemble(result, v)

    print('terminado', end='---: ')
    print(time.ctime())

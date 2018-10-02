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
            Bianca Fazio Rius <biancafaziorius ( at ) gmail.com> 
"""

__author__ = "https://github.com/jpdarela/"

import os
import sys
import glob
import time
from math import ceil
import multiprocessing as mp
import concurrent.futures as conc
import numpy as np

# from plsgen import ATTR_TABLE
from plsgen import table_gen
import write_output as wo
import caete_module as C
from caete_module import global_pars as gp

# You need to create a homedir file specifying some file paths and the name of you python3 executable 
import homedir
from homedir import OUTPUT_NC_DIR
from homedir import RESULTS_DIR
from homedir import TMP_DIR


#RUN IN SOMBRERO
HOME_DIR = homedir.HOMEDIR


disp_processors = os.cpu_count()
nx = gp.nx
ny = gp.ny
nz = gp.ntimes
npls = gp.npls
mask = np.load('mask.npy')
mask12 = np.load('mask12.npy')
# output variables names
varlist = wo.monthly_out + wo.npls_out

# Print iterations progress
def print_progress(iteration, total, prefix='', suffix='', decimals=1, bar_length=50):
    """FROM Stack Overflow/GIST, THANKS
    Call in a loop to create terminal progress bar

    @params:
        iteration   - Required  : current iteration (Int)
        total       - Required  : total iterations (Int)
        prefix      - Optional  : prefix string (Str)
        suffix      - Optional  : suffix string (Str)
        decimals    - Optional  : positive number of decimals in percent complete (Int)
        bar_length  - Optional  : character length of bar (Int)
    """
    bar_utf = b'\xe2\x96\x88' # bar
    str_format = "{0:." + str(decimals) + "f}"
    percents = str_format.format(100 * (iteration / float(total)))
    filled_length = int(round(bar_length * iteration / float(total)))
    bar = '█' * filled_length + '-' * (bar_length - filled_length)

    sys.stdout.write('\r%s |%s| %s%s %s' % (prefix, bar, percents, '%', suffix)),

    if iteration == total:
        sys.stdout.write('\n')
    sys.stdout.flush()

# defining functions that (1)drive model throghout the grid data & (2) save outputs
def make_dir_spe(folder_path):
    try:
        test = os.path.exists(folder_path)
    except:
        print('Error while checking %s' % folder_path)
        #return False
    if test:
        pass
    else:
        os.mkdir(folder_path)
        #return True


def chunks(lst, chunck_size):
    from random import shuffle
    shuffle(lst)
    """Yield successive n-sized chunks from lst."""
    for i in range(0, len(lst), chunck_size):
        yield lst[i:i + chunck_size]


def pls_generator():
    print("running table gen from pls_generator")
    return table_gen(npls)
#(1)


# Global variable! --------------------------------------------
ATTR_TABLE = pls_generator()
# make_dir_spe(OUTPUT_NC_DIR)


def init_caete(grd):
    grd.pr = global_pr[:, grd.y, grd.x]
    grd.ps = global_ps[:, grd.y, grd.x]
    grd.rsds = global_rsds[:, grd.y, grd.x]
    grd.tas = global_tas[:, grd.y, grd.x]
    grd.rhs = global_rhs[:, grd.y, grd.x]
    grd.npp0 = npp_init[grd.y, grd.x]
    grd.filled = True


def run_model(grd, at = ATTR_TABLE):

    #print('running_model (inside)')
    if grd.filled and not grd.complete:

        grd.clin, grd.cfin, grd.cwin = C.photo.spinup(grd.npp0, at)

        outputs = C.water_balance.wbm(at, grd.pr, grd.tas, grd.ps, grd.rsds,
                                      grd.rhs, grd.clin, grd.cwin, grd.cfin)

        grd.emaxm = outputs[0]
        grd.tsoil = outputs[1]
        grd.photo = outputs[2]
        grd.aresp = outputs[3]
        grd.npp = outputs[4]
        grd.lai = outputs[5]
        grd.clit = outputs[6]
        grd.csoil = outputs[7]
        grd.hresp  = outputs[8]
        grd.rcm = outputs[9]
        grd.runom = outputs[10]
        grd.evapm = outputs[11]
        grd.wsoil = outputs[12]
        grd.rm = outputs[13]
        grd.rg = outputs[14]
        grd.cleaf = outputs[15]
        grd.cawood = outputs[16]
        grd.cfroot = outputs[17]
        grd.area = outputs[18]
        grd.area0 = outputs[19]
        grd.wue = outputs[20]
        grd.cue = outputs[21]
        grd.complete = True
    else:
        print('Gridcell %s is either not filled or already completed' % grd.name)
        pass


def grd_dict(grd):

    def nan_remove(arr):
        np.place(arr,np.isnan(arr), (0.0,0.0))
        np.place(arr,np.isinf(arr), (0.0,0.0))
        return arr

    if grd.complete:
        a = nan_remove(grd.area)
        w = (nan_remove(grd.cawood)) * (a / 100.)
        l = (nan_remove(grd.cleaf))  * (a / 100.)
        r = (nan_remove(grd.cfroot)) * (a / 100.)

        cmass =  w + r + l
        #cmass = cmass.sum(axis=0,)
        grd.output_data = {  'clin' : nan_remove(grd.clin),#(npls)
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

    grd.tas  = None
    grd.rhs = None
    grd.ps = None
    grd.pr = None
    grd.rsds = None

    grd.tsoil  = None
    grd.photo  = None
    grd.aresp  = None
    grd.npp    = None
    grd.lai    = None
    grd.clit   = None
    grd.csoil  = None
    grd.hresp  = None
    grd.rcm    = None
    grd.runom  = None
    grd.evapm  = None
    grd.wsoil  = None
    grd.rm     = None
    grd.rg     = None
    grd.cleaf  = None
    grd.cawood = None
    grd.cfroot = None
    grd.area   = None
    grd.area0  = None
    grd.wue    = None
    grd.cue    = None


def rm_apply(gridcell_obj):
    # FLOW OF EXECUTION
    # Run model
    run_model(gridcell_obj)
    # Generate outputs
    grd_dict(gridcell_obj)
    # Clean Memory
    model_flush(gridcell_obj)
    # Return the modeled input gridcell 
    return(gridcell_obj)


def catch_nt(input_file, nx, ny, pixel_depht):

    """Get the number of layers in input_file
    input_file = flat binary (from fortran unfformated output)filename
    nx = (int) number of columns
    ny = (int) number of rows
    pixel_depth = (int) stride length in bitsGridcell
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
                    dtype=np.float32).reshape((layers,ny,nx))

#(2)

def make_output_array(var):
    if var in wo.monthly_out:
        z = nz
    elif var in wo.npls_out:
        z = npls
    else:
        return None
    return np.zeros(shape=(z,ny,nx), dtype=np.float32) - 9999.0


def ld_dict():
    know = varlist[:]
    adata = dict()
    for var in know:
        adata[var] = make_output_array(var)
    return adata


def assemble(land_data_list,dic=None,f=False):
    know = varlist[:]
    if dic is None:
        adata = ld_dict()
    else:
        adata = dic

    if not f:
        for grdcell in land_data_list:
            px,py = grdcell.pos
            for var in know:
                adata[var][:,py,px] = grdcell.output_data[var].copy()

    if dic is not None and f is False: return None

    def write_nc(varin):
        arr = adata[varin]
        fname = OUTPUT_NC_DIR + os.sep + varin + '.nc'
        wo.write_CAETE_output(fname,arr,varin)

    with conc.ThreadPoolExecutor(max_workers=26) as executor:
        for k in adata.keys():
            f = executor.submit(write_nc,k)
##            f.result()
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
            t1 = (fname_comp,nx,ny,32)
            lr = catch_nt(*t1)
            t2 = (fname_comp,lr,nx,ny)
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
        self.area0   = None


## GLOBAL VARS
lr = catch_nt('../input/npp.bin', nx, ny, 32)
npp_init = catch_data('../input/npp.bin', lr, nx, ny)
npp_init = np.ma.masked_array(npp_init, mask12)
npp_init = npp_init.mean(axis=0,)

std_shape = (12, ny, nx)

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

# Creating directories structure
# make_dir_spe(RESULTS_DIR)
# make_dir_spe(TMP_DIR)
# make_dir_spe(OUTPUT_NC_DIR)



if __name__ == "__main__":

    t0 = time.time()
    log = open('exec.log', mode='a')
    # iniciando o modelo para todas (land) as celulas do grid
    # este bloco de código cria uma lista que contém n instâncias da
    # classe gridcell (L-288) e depois aplica o modelo a cada uma delas.
    # Preferi deixar esta classe o mais limpa possível, pois as suans instầncias são modificada em
    # paralelo e para isso precisam ser pickladas (veja o modulo pickle e também o modulo multiprocessing)

    # Por isso as funções que iniciam e aplicam o modelo a cada instancia de gridcell
    # não são métodos propriamente ditos e sim, funções que manipulam estas instâncias.

    land_data = []
    id_n = 0
    print('\ninit CAETE --- %d PLSs' % npls, end='---> ')
    log.write('\n\n\ninit caete --- %d PLSs\n' % npls)
    log.write('--init-time--%s\n\n' % time.ctime())
    print(time.ctime())
    for Y in range(ny):               # 150, 230
        for X in range(nx):           # 230, 260
            if not mask[Y][X]:
                id_n += 1
                grd_cell = gridcell(X,Y)
                init_caete(grd_cell)
                land_data.append(grd_cell)
    log.write('--CAETE-in-filled--%s\n' % time.ctime())
    # del input arrays
    del global_pr
    del global_ps
    del global_tas
    del global_rhs
    del global_rsds
    del npp_init
    # divide land_data when data is too big - npls > i
    if npls <= 12:
        log.write('Iniciando multiprocessing - fila única\n')
        with mp.Pool(processes=disp_processors * 2, maxtasksperchild=20) as p:
            result = p.map(rm_apply, land_data)
        t1 = time.time()
        log.write('Elapsed time in model run:  %f seconds\n'% (t1 - t0))
        print('\nModelo aplicado a %d localidades-- %d PLSs' % (id_n,npls), end='--->')
        print(time.ctime())
        log.write('\nModelo aplicado a %d localidades-- %d PLSs\n' % (id_n,npls))
        log.write('Em: %s' % time.ctime())
        print('\nCALCULANDO SOMAS', end='--->')
        print(time.ctime())
        print('\nSalvando resultados')

        t0 = time.time()
        assemble(result)
        t1 = time.time()

        log.write('files_saved in %f seconds\n'% (t1 - t0))
        print('terminado', end='---: ')
        print(time.ctime())
        log.write('end_run %s\n' % time.ctime())

    else:
        if npls <= 200:
            n_process = disp_processors * 2
            hi = n_process * 30
        else:
            n_process = disp_processors * 3
            hi = n_process * 30
        n_chunks = ceil(len(land_data)/hi)
        log.write('Iniciando multiprocessing - chunks mode\n')
        id = 1
        files = []
        adata = ld_dict()
        print_progress(0, n_chunks, prefix = 'Progress:', suffix = 'Complete')
        for lst in chunks(land_data, hi):
            with mp.Pool(processes=n_process, maxtasksperchild=30) as p:
                result = p.map(rm_apply, lst)
            print_progress(id, n_chunks, prefix = 'Progress:', suffix = 'Complete')
            t2 = time.time()
            assemble(result,adata)
            t3 = time.time()
            log.write('->->-chunck %d -- gridcell data transfer to dic in %f seconds\n'% (id,(t3 - t2)))
            result = ['.']
            id += 1
        t4 = time.time()
        assemble(result,adata,f=True)
        t5 = time.time()
        log.write('---files_saved in %f seconds\n'% (t5 - t4))
        t1 = time.time()
        log.write('Elapsed time in model run:  %f seconds\n'% (t1 - t0))

        print('\nModelo aplicado a %d localidades-- %d PLSs' % (len(land_data),npls), end='--->')
        print(time.ctime())
        log.write('\nModelo aplicado a %d localidades-- %d PLSs\n' % (id_n,npls))
        log.write('---%s\n' % time.ctime())
        print('terminado', end='---: ')
        print(time.ctime())
        log.write('end_run %s\n' % time.ctime())
        log.close()


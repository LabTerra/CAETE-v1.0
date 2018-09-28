#!-*-coding:utf-8-*-
import os
import sys
import glob
import time
import numpy as np
import gdal
import write_output as wo
import netCDF4 as nc

# Import filepaths from homedir
sys.path.insert(0, '../src/')
import homedir

# UNTAR output files
os.system("ipython3 untar.py")

# This variable must store the correct path to the results folder
data_dir = homedir.RESULTS_DIR

# This variable contains the correct path to save all pls_attrs.csv together and the final csv for analysis
attr_dir = homedir.SAVE_CSV_FILES

csv_dir = homedir.SAVE_CSV_FINAL

# Create outputs folder if it dont exists
if not os.path.exists(attr_dir): os.mkdir(attr_dir)
if not os.path.exists(csv_dir): os.mkdir(csv_dir)
# Some variables
root  = os.getcwd()
nx = 720
ny = 360
lat = np.arange(-89.75, 90., 0.5)
lon = np.arange(-179.75, 180., 0.5)

# Defining some functions

def read_as_array(nc_fname, var):
    data = nc.Dataset(nc_fname).variables[var][:]
    return data


def folder_list(dr = data_dir):

    """Constructs a list of lists containing the structure 
       of directories that contains CAETÊ outputs
       dr : path to outputs"""

    os.chdir(dr)
    # creating a list with all folders results
    folders = os.listdir(os.getcwd())
    #print folders

    # creating a set with all npls number ex.: {'out12', 'out15'}
    pls_set = set([n.split('_')[0] for n in folders])
    #print pls_set
    # creating a list of lists containing run folder names
    # ex.:[['out12_r1', 'out12_r2'], [out50_r1, out50_r2], [out100, r1, out100_r2]]
    folder_l= [glob.glob1(os.getcwd(), n + '_*') for n in pls_set]
    #print folder_l
    os.chdir(root)
    return folder_l


def make_table():
    """ Constructs the final table of caete results"""

    import csv
    #from pandas import read_csv
    import pandas as pd

    fluxes = ['npp','photo','aresp','cue','wue','evapm','rcm']
    pools = ['area','cmass']
    traits = ['g1','vcmax','tleaf','twood','troot','aleaf','awood','aroot']


    def nan_remove(arr):
        np.place(arr,np.isnan(arr),(0.0,0.0))
        np.place(arr,np.isinf(arr),(0.0,0.0))
        return arr


    def annual_mean_sd(filein):
        dt = gdal.Open(filein + '.nc').ReadAsArray()
        return dt.mean(axis=0,), dt.std(axis=0,)


    def cwmv(area,traits):
        # area :: [np.array  1D] shape(npls,)
        # traits [np.array 1D ] shape(npls):: g1 || vcmax || tleaf || twood || troot || aleaf || awood || aroot
        assert area.shape == traits.shape, 'shape mismatch'
        return (area * traits).sum(axis=0,), pow((area * traits).std(),2)


    csv_header = ['ny','nx','lat','lon','forest','area_m2',
                  'run','gpp','ra','npp','rc','et', 'wue', 'cue',
                  'cmass','cleaf','cfroot', 'cawood',
                  'g1_cwm','vcmax_cwm','tleaf_cwm',
                  'twood_cwm','troot_cwm','aleaf_cwm',
                  'awood_cwm','aroot_cwm','g1_cwv',
                  'vcmax_cwv','tleaf_cwv','twood_cwv',
                  'troot_cwv','aleaf_cwv','awood_cwv',
                  'aroot_cwv']
                  # 'g1_cwm0','vcmax_cwm0',
                  # 'tleaf_cwm0','twood_cwm0','troot_cwm0',
                  # 'aleaf_cwm0','awood_cwm0','aroot_cwm0']
                  #'g1_cwv0','vcmax_cwv0','tleaf_cwv0',
                  #'twood_cwv0','troot_cwv0','aleaf_cwv0',
                  #'awood_cwv0','aroot_cwv0']

    # csv_header = [x.encode() for x in csv_header]

    # Read some metadata 
#    mask = np.load('mask12.npy')[0]
    mask_forest = np.load('mask_forests.npy')
    area_m2 = read_as_array("cell_area.nc", "cell_area")

    # Create the list of lists of output directories
    flds = folder_list()
    flds.sort()
    for fl in flds:
        # print fl each fl is a listo of runs
        fl.sort()
        rname = fl[0].split('_')[0] # to be used in pls_attrs_save

        rname1 = os.sep.join([csv_dir, rname])
        with open(rname1 + '.csv', mode='w') as fh:
            csv_writer = csv.writer(fh, delimiter=',')
            csv_writer.writerow(csv_header)
        root = os.getcwd()
        i = -1

        for folder in fl:
            print (folder)
            i += 1

            run = folder.split("_")[-1]
            #print run
            with open(rname1 + '.csv', mode='a') as fh:
                csv_writer = csv.writer(fh,delimiter=',')
                #csv_writer.writerow(csv_header)
                #files =  os.listdir(os.getcwd() + '/results/' + folder)
                os.chdir(data_dir + '/' + folder )

                # open files
                area_ocp = read_as_array("area.nc", "area") / 100.0
                cmass = (read_as_array("cmass.nc", "cmass") * area_ocp).sum(axis=0,)
                cleaf = (read_as_array("cleaf.nc", "cleaf") * area_ocp).sum(axis=0,)
                cfroot = (read_as_array("cfroot.nc", "cfroot") * area_ocp).sum(axis=0,)
                cawood = (read_as_array("cawood.nc", "cawood") * area_ocp).sum(axis=0,)
                attr_table = pd.read_csv('pls_attrs.csv',dtype=np.float32)

                rpath =  attr_dir + os.sep
                
                NPLS = rname[3:]
                attr_table.to_csv(rpath + 'pls_attrs' + '-' +str(run) + '-' + NPLS + '.csv', index=False)

                print("Making var_dict %s --- %s" % (run,time.ctime()))
                var_dict = dict(zip(fluxes,map(annual_mean_sd,fluxes)))
                print("ending var_dict %s --- %s\n\n" % (run,time.ctime()))

                mask = cleaf.mask
                print("Printing to file %s --- %s" % (run,time.ctime()))

                for Y in range(360):
                    for X in range(720):
                        if not mask[Y,X]:
                            photo = var_dict['photo'][0][Y,X] # gpp =
                            ra = var_dict['aresp'][0][Y,X] # ra =
                            npp1 = var_dict['npp'][0][Y,X] # npp=
                            rc = var_dict['rcm'][0][Y,X] # rc =
                            evapm = var_dict['evapm'][0][Y,X] # et =
                            wue = var_dict['wue'][0][Y,X]
                            cue = var_dict['cue'][0][Y,X]
                            if photo <= 1e-12:
                                pass
                            else:
                                area1 = area_ocp[:,Y,X]
                                line =[Y, # ny =
                                       X, # nx =
                                       lat[Y],
                                       lon[X],
                                       mask_forest[Y,X],
                                       area_m2[Y,X], # area_m2 =
                                       run, # run =
                                       '%.2f'%photo, # gpp =
                                       '%.2f'%ra, # ra =
                                       '%.2f'%npp1, # npp=
                                       '%.2f'%rc, # rc =
                                       '%.2f'%evapm, # et =
                                       '%.2f'%wue,
                                       '%.2f'%cue,
                                       # '%.4f'%var_dict['photo'][1][Y,X], # gpp_sig =
                                       # '%.4f'%var_dict['aresp'][1][Y,X], # ra_sig =
                                       # '%.4f'%var_dict['npp'][1][Y,X], # npp_sig =
                                       # '%.4f'%var_dict['rcm'][1][Y,X], # rc_sig =
                                       # '%.4f'%var_dict['evapm'][1][Y,X], # et_sig =
                                       
                                       '%.5f'%cmass[Y,X],
                                       '%.5f'%cleaf[Y,X],
                                       '%.5f'%cfroot[Y,X],
                                       '%.5f'%cawood[Y,X],
                                       
                                       #from run
                                       '%.6f'%cwmv(area1, attr_table[traits[0]])[0], # g1_cwm =
                                       '%.10f'%cwmv(area1, attr_table[traits[1]])[0], # vcmax_cwm =
                                       '%.6f'%cwmv(area1, attr_table[traits[2]])[0], # tleaf_cwm =
                                       '%.6f'%cwmv(area1, attr_table[traits[3]])[0], # twood_cwm
                                       '%.6f'%cwmv(area1, attr_table[traits[4]])[0], # troot_cwm =
                                       '%.6f'%cwmv(area1, attr_table[traits[5]])[0], # aleaf_cwm =
                                       '%.6f'%cwmv(area1, attr_table[traits[6]])[0], # awood_cwm =
                                       '%.6f'%cwmv(area1, attr_table[traits[7]])[0], # aroot_cwm =
                                       
                                       '%.6f'%cwmv(area1, attr_table[traits[0]])[1], # g1_cwv =
                                       '%.10f'%cwmv(area1, attr_table[traits[1]])[1], # vcmax_cwv =
                                       '%.6f'%cwmv(area1, attr_table[traits[2]])[1], # tleaf_cwv =
                                       '%.6f'%cwmv(area1, attr_table[traits[3]])[1], # twood_cwv
                                       '%.6f'%cwmv(area1, attr_table[traits[4]])[1], # troot_cwv =
                                       '%.6f'%cwmv(area1, attr_table[traits[5]])[1], # aleaf_cwv =
                                       '%.6f'%cwmv(area1, attr_table[traits[6]])[1], # awood_cwv =
                                       '%.6f'%cwmv(area1, attr_table[traits[7]])[1]] 
                                csv_writer.writerow(line)
                                
                                # from spinup (npp_pot,carbon pools in vegetation)
                                #  '%.4f'%cwmv(area_ocp0[:,Y,X], attr_table[traits[0]]),#[0], # g1_cwm =
                                #  '%.10f'%cwmv(area_ocp0[:,Y,X], attr_table[traits[1]]),#[0], # vcmax_cwm =
                                #  '%.4f'%cwmv(area_ocp0[:,Y,X], attr_table[traits[2]]),#[0], # tleaf_cwm =
                                #  '%.4f'%cwmv(area_ocp0[:,Y,X], attr_table[traits[3]]),#[0], # twood_cwm
                                #  '%.4f'%cwmv(area_ocp0[:,Y,X], attr_table[traits[4]]),#[0], # troot_cwm =
                                #  '%.4f'%cwmv(area_ocp0[:,Y,X], attr_table[traits[5]]),#[0], # aleaf_cwm =
                                #  '%.4f'%cwmv(area_ocp0[:,Y,X], attr_table[traits[6]]),#[0], # awood_cwm =
                                #  '%.4f'%cwmv(area_ocp0[:,Y,X], attr_table[traits[7]])]#[0], # aroot_cwm =
                                # # '%.4f'%cwmv(area_ocp0[:,Y,X], attr_table[traits[0]]),#[1], # g1_cwv =
                                # '%.10f'%cwmv(area_ocp0[:,Y,X], attr_table[traits[1]]),#[1], # vcmax_cwv =
                                # '%.4f'%cwmv(area_ocp0[:,Y,X], attr_table[traits[2]]),#[1], # tleaf_cwv =
                                # '%.4f'%cwmv(area_ocp0[:,Y,X], attr_table[traits[3]]),#[1], # twood_cwv
                                # '%.4f'%cwmv(area_ocp0[:,Y,X], attr_table[traits[4]]),#[1], # troot_cwv =
                                # '%.4f'%cwmv(area_ocp0[:,Y,X], attr_table[traits[5]]),#[1], # aleaf_cwv =
                                # '%.4f'%cwmv(area_ocp0[:,Y,X], attr_table[traits[6]]),#[1], # awood_cwv =
                                # '%.4f'%cwmv(area_ocp0[:,Y,X], attr_table[traits[7]])#[1]] # aroot_cwv =
                area_ocp = None
                area_ocp0 = None
                cmass = None
                cleaf = None
                cfroot = None
                cawood = None
                attr_table = None
            os.chdir(root)
    return None


def calc_diversity(runs):
    """runs :: list of runs"""
    os.chdir(root)
    os.chdir(data_dir)
    res = os.getcwd()
    os.chdir(runs[0])
    sh = read_as_array("area.nc", "area").shape
    
    os.chdir(res)
    div = np.zeros(shape=sh,dtype=np.float32)
    #lst_div = []
    for run in runs:
        os.chdir(run)
        dt = read_as_array("area.nc", "area")
        div += np.array(dt > 0.0, np.int32)/np.float32(len(runs))
        #lst_div.append(div)
        dt = None
        os.chdir(res)
    #div_arr = np.array(lst_div)
    #del(lst_div)
    div_arr = div.mean(axis=0,)
    del(div)
    os.chdir(root)
    return div_arr


def calc_stats_vars(runs,var):
    """ runs :: list containing run folders
    var  :: string ->>> var name ex.: npp"""

    assert len(runs) > 0,'lista runs vazia'
    # creating a list of arrays containing variour arrays of var as elements
    list_of_arrays = []
    for folder in runs:
        #print os.listdir(folder)
        files = glob.glob1(folder, var + '.nc')
        files = [ folder +'/'+ f for f in files]
        #print files
        for f in files:
            dt = gdal.Open(f).ReadAsArray()
            list_of_arrays.append(dt.copy())
            dt = None

    # running statistics among arrays in list of arrays
    # out = mean + median + std
    #print len(list_of_arrays)

    input_array = np.array(list_of_arrays)
    del(list_of_arrays)
    avg = np.mean(input_array,axis=0,)
    #med = np.median(input_array,axis=0,)
    sig = np.std(input_array,axis=0,)

    os.chdir(root)
    return avg,sig



def calc_stats_pools(runs,var):
    """ runs :: list containing run folders
    var  :: string ->>> var name ex.: cmass"""

    assert len(runs) > 0,'empty -runs list'
    # creating a list of arrays containing variour arrays of var as elements
    list_of_arrays = []
    for folder in runs:
        #print os.listdir(folder)
        files = glob.glob1(folder, var + '.nc')
        files = [ folder +'/'+ f for f in files]
        #print files
        for f in files:
            dt = read_as_array(f, var)
            dt = dt.sum(axis=0,)
            list_of_arrays.append(dt.copy())
            dt = None

    # running statistics among arrays in list of arrays
    # out = mean + median + std
    #print len(list_of_arrays)

    input_array = np.array(list_of_arrays)
    del(list_of_arrays)
    avg = np.mean(input_array,axis=0,)
    #med = np.median(input_array,axis=0,)
    sig = np.std(input_array,axis=0,)

    os.chdir(root)
    return avg,sig


def make_stats(runs):
    vars_tuple = 'cmass', 'npp', 'photo', 'evapm', 'rcm', 'aresp', 'wue', 'cue'
    #     print os.getcwd()
    os.chdir(data_dir)
    res= os.getcwd()
    run = runs[0].split('_')[0] + 'PLS_assembled/'
    os.mkdir(run)
    for var in vars_tuple:
        print (var) #, '...reading data'
        if var in wo.monthly_out:
            avg,sig = calc_stats_vars(runs,var)
        else:
            avg,sig = calc_stats_pools(runs,var)
        #print os.getcwd()
        os.chdir(data_dir + '/' + run)
        np.save(var + '_avg.npy', avg)
        #np.save(var + '_med.npy', med)
        np.save(var + '_sig.npy', sig)
        os.chdir(res)
    print('reading area --> richness')
    div = calc_diversity(runs)
    os.chdir(data_dir + '/' + run)
    np.save('richness' + '.npy', div)
    os.chdir(root)
    return run # returns folder name for pls results

if __name__ == '__main__':

    # Faz a tabela com dados de cada celula de grid
    make_table()

    # Salva os arquivos de medias de dp (netCDF files)
    folderl = folder_list()
    results = []
    for f in folderl:
       results.append(make_stats(f))

    for f in results:
        os.chdir(data_dir + '/' + f)
        f_to_save = glob.glob1(os.getcwd(), "*.npy")
        npls = f.split('P')[0].split('t')[-1]
        for npy in f_to_save:
            #print(npy)
            var = npy.split('.')[0] 
            arr = np.load(npy)
            ncfilename = var + npls + 'PLS' + '.nc'
            print(ncfilename)
            wo.write_CAETE_output(ncfilename,arr,var)
        os.chdir(root)

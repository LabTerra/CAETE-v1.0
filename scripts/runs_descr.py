import os
import glob
#import multiprocessing as mp
import numpy as np
import gdal
#import netCDF4 as nc

# Edit these lines to you output folders
data_dir = "/home/amazonfaceme/jpdarela/results_testing_numbering"
attr_dir = '/home/amazonfaceme/jpdarela/pls_tables_testing_numbering'

if not os.path.exists(attr_dir): os.mkdir(attr_dir)

root  = os.getcwd()
nx = 720
ny = 360

lat = np.arange(-89.75, 90., 0.5)
lon = np.arange(-179.75, 180., 0.5)

def CellAreas(lat,lon):
    """     Borrowed from ILAMB_code____

    Given arrays of latitude and longitude, return cell areas in square meters.

    Parameters
    ----------
    lat : numpy.ndarray
        a 1D array of latitudes which represent cell centroids
    lon : numpy.ndarray
        a 1D array of longitudes which represent cell centroids

    Returns
    -------
    areas : numpy.ndarray
        a 2D array of cell areas in [m2]

    Borrowed from ILAMB_lib
    """
    #from constants import earth_rad
    earth_rad = 6.371e6 # meters
    x = np.zeros(lon.size+1)
    x[1:-1] = 0.5*(lon[1:]+lon[:-1])
    x[ 0]   = lon[ 0]-0.5*(lon[ 1]-lon[ 0])
    x[-1]   = lon[-1]+0.5*(lon[-1]-lon[-2])
    if(x.max() > 181): x -= 180
    x  = x.clip(-180,180)
    x *= np.pi/180.

    y = np.zeros(lat.size+1)
    y[1:-1] = 0.5*(lat[1:]+lat[:-1])
    y[ 0]   = lat[ 0]-0.5*(lat[ 1]-lat[ 0])
    y[-1]   = lat[-1]+0.5*(lat[-1]-lat[-2])
    y       = y.clip(-90,90)
    y *= np.pi/180.

    dx    = earth_rad*(x[1:]-x[:-1])
    dy    = earth_rad*(np.sin(y[1:])-np.sin(y[:-1]))
    areas = np.outer(dx,dy).T

    return areas

def folder_list(dr = data_dir):
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

    import csv
    #from pandas import read_csv
    import pandas as pd

    fluxes = ['npp','photo','aresp','cue','wue','evapm','rcm']
    pools = ['area','area0','cmass']
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

    mask = np.load('mask12.npy')[0]
    mask_forest = np.load('mask_forests.npy')

    area_m2 = gdal.Open('cell_area.nc').ReadAsArray()

    for fl in folder_list():
        # print fl
        rname = fl[0].split('_')[0]
        with open(rname + '.csv', mode='w') as fh:
            csv_writer = csv.writer(fh, delimiter=',')
            csv_writer.writerow(csv_header)
        root = os.getcwd()
        i = -1

        for folder in fl:
            print (folder)
            i += 1
            run = folder.split("_")[-1]
            #print run
            with open(rname + '.csv', mode='a') as fh:
                csv_writer = csv.writer(fh,delimiter=',')
                #csv_writer.writerow(csv_header)
                #files =  os.listdir(os.getcwd() + '/results/' + folder)
                os.chdir(data_dir + '/' + folder )

                # open files
                area_ocp = gdal.Open('area.nc').ReadAsArray() / 100.0
                cmass =  (gdal.Open('cmass.nc').ReadAsArray() * area_ocp).sum(axis=0,)
                cleaf = (gdal.Open('cleaf.nc').ReadAsArray() * area_ocp).sum(axis=0,)
                cfroot = (gdal.Open('cfroot.nc').ReadAsArray() * area_ocp).sum(axis=0,)
                cawood = (gdal.Open('cawood.nc').ReadAsArray() * area_ocp).sum(axis=0,)
               #  clin = gdal.Open('clin.nc').ReadAsArray()
               #  cwin = gdal.Open('cwin.nc').ReadAsArray()
               #  cfin = gdal.Open('cfin.nc').ReadAsArray()
               #  area_ocp0 = np.zeros(shape=cfin.shape,dtype=np.float32)

               # total_biomass_pft = clin + cfin + cwin
               # total_biomass = clin.sum(axis=0,) + cwin.sum(axis=0,) + cfin.sum(axis=0,)

               # for ii in range(total_biomass_pft.shape[0]):
               #     area_ocp0[ii,:,:] = total_biomass_pft[ii,:,:] / total_biomass[:,:]

               # del(cwin,cfin,clin,total_biomass)

               # area_ocp0 = nan_remove(area_ocp0)

                attr_table = pd.read_csv('pls_attrs.csv',dtype=np.float32)

                rpath =  attr_dir + '/'
                attr_table.to_csv(rpath + 'pls_attrs' + '-' +str(run) + '-' +rname[3:] + '.csv', index=False)


                var_dict = dict(zip(fluxes,map(annual_mean_sd,fluxes)))

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

                            if photo <= 0.0001:
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
                                       '%.6f'%cwmv(area1, attr_table[traits[7]])[1]] # aroot_cwv =

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

                                csv_writer.writerow(line)

                area_ocp = None
                area_ocp0 = None
                cmass = None
                cleaf = None
                cfroot = None
                cawood = None
                attr_table = None
     
            os.chdir(root)
    return None
    # for each gridcell(360,720) in each run in runs  
    # load data arrays and make annual means (npp, gpp, ra, cue, wue, rcm, evamp)
    
    # load area1 = area_ocp[:,Y,X]
    # load cmass

def calc_diversity(runs):
    """runs :: list of runs"""
    os.chdir(root)
    os.chdir(data_dir)
    res = os.getcwd()
    os.chdir(runs[0])
    sh = gdal.Open('area.nc').ReadAsArray().shape
    os.chdir(res)
    div = np.zeros(shape=sh,dtype=np.float32)
    #lst_div = []
    for run in runs:
        os.chdir(run)
        dt = gdal.Open('area.nc').ReadAsArray()
        div += np.array(dt > 0.0, np.int32)/np.float32(len(runs))
        #lst_div.append(div)
        dt = None
        os.chdir(res)
    #div_arr = np.array(lst_div)
    #del(lst_div)
    div_arr = div.mean(axis=0,)
    #del(div)
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
            dt = gdal.Open(f).ReadAsArray()
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
    run = runs[0].split('_')[0] + 'PLSs_assembled/'
    os.mkdir(run)
    for var in vars_tuple:
        print (var)#, '...reading data'
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
    # cria uma pasta 
    import write_output as wo

    # lat = np.arange(-89.75, 90, 0.5)
    # lon = np.arange(-179.75, 180, 0.5)
    # areacell = CellAreas(lat,lon)
    # fname = '/home/jpdarela/Desktop/caete_jp/dev/caete_results/cell_area.nc'
    # wo.write_CAETE_output(fname,areacell, 'cell_area')

    mask = np.load('mask12.npy')
    folderl = folder_list()
    results = []
    for f in folderl:
       results.append(make_stats(f))


    # write_CAETE_output(nc_filename, arr, var, npls1=1):
    # out50PLS_assembled
    for f in results:
        os.chdir(data_dir + '/' + f)
        f_to_save = os.listdir(os.getcwd())
        npls = f.split('P')[0].split('t')[-1]
        for npy in f_to_save:
            var = npy.split('.')[0] 
            arr = np.load(npy)
            ncfilename = var + npls + 'PLS' + '.nc'
            print (ncfilename)#, arr.shape, var
            #if len(arr.shape) == 2:
            wo.write_CAETE_output(ncfilename,arr,var)
        #elif len(arr.shape) > 2:
           # wo.write_CAETE_output(ncfilename,arr,var)
        os.chdir(root)
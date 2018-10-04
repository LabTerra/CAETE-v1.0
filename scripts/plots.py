#_*_coding:latin-1_*_

import os
from glob import glob1

import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
import numpy as np
import pandas as pd

import dtype_dict as dt

data_dir = "/home/jpdarela/Desktop/caete/caete_results/"


var_0 = ['g1_cwm0','vcmax_cwm0','tleaf_cwm0','twood_cwm0',
        'troot_cwm0','aleaf_cwm0','awood_cwm0','aroot_cwm0']

var_1 = ['g1_cwm','vcmax_cwm','tleaf_cwm','twood_cwm',
        'troot_cwm','aleaf_cwm','awood_cwm','aroot_cwm'] 

var_2 = ['g1_cwv','vcmax_cwv','tleaf_cwv','twood_cwv',
         'troot_cwv','aleaf_cwv','awood_cwv','aroot_cwv'] 


axis_limits = [[3.8,4.7,1,10],[6.2e-5,8.8e-5,1,10],[3.5,6.,1,10],
                [45.,65.,1,10],[3.4,6.3,1,10],
                [0.15,0.35,1,10],[0.35,0.60,1,10],[0.18,0.35,1,10]]

axis_dict = dict(zip(var_1,axis_limits))


def read_csv_run(run):
    return glob1('pls_tables', '*' + str(run) + '.csv')


def read_data1():
    out50pls  = pd.read_csv('out50.csv',dtype=dt.dtypes)
    out100pls = pd.read_csv('out100.csv',dtype=dt.dtypes)
    out200pls = pd.read_csv('out200.csv',dtype=dt.dtypes)
    out500pls = pd.read_csv('out500.csv',dtype=dt.dtypes)

    return (out50pls,out100pls, out200pls, out500pls)

def read_data15(pls, eco2=False):
    if pls == 50:
        outpls  = pd.read_csv('out50.csv',dtype=dt.dtypes)
    elif pls == 100:
        outpls = pd.read_csv('out100.csv',dtype=dt.dtypes)
    elif pls == 200:
        outpls = pd.read_csv('out200.csv',dtype=dt.dtypes)
    elif pls == 500 and not eco2:
        outpls = pd.read_csv('out500.csv',dtype=dt.dtypes)
    elif pls == 500 and eco2:
        outpls = pd.read_csv('out500_eCO2.csv',dtype=dt.dtypes)
    else: assert False, 'zica'

    return outpls


def read_data16(eco2=False):
    if not eco2:
        outpls = pd.read_csv('out500.csv',dtype=dt.dtypes)
    elif eco2:
        outpls = pd.read_csv('out500_eCO2.csv',dtype=dt.dtypes)
    else: assert False, 'zica'



def read_data2(run,var,pls):
    assert run >= 0 or run <= 9
    out_50 = read_csv_run(pls)
    data_name = [f for f in out_50 if f.split('-')[1] == str(run)][0]
    data = pd.read_csv('./pls_tables/' + data_name)
    return data[var_1[var].split('_')[0]]


def make_tlist(dataset,var):
    return   (dataset[var_1[var]][dataset['run'] == 1][dataset['forest'] == 1],
              dataset[var_1[var]][dataset['run'] == 2][dataset['forest'] == 1],
              dataset[var_1[var]][dataset['run'] == 3][dataset['forest'] == 1],
              dataset[var_1[var]][dataset['run'] == 4][dataset['forest'] == 1],
              dataset[var_1[var]][dataset['run'] == 5][dataset['forest'] == 1],
              dataset[var_1[var]][dataset['run'] == 6][dataset['forest'] == 1],
              dataset[var_1[var]][dataset['run'] == 7][dataset['forest'] == 1],
              dataset[var_1[var]][dataset['run'] == 8][dataset['forest'] == 1],
              dataset[var_1[var]][dataset['run'] == 9][dataset['forest'] == 1],
              dataset[var_1[var]][dataset['run'] == 0][dataset['forest'] == 1])


def make_tlist3(dataset,var):
    return   (dataset[var_1[var]][dataset['run'] == 1][dataset['forest'] == 1],
              dataset[var_1[var]][dataset['run'] == 2][dataset['forest'] == 1],
              dataset[var_1[var]][dataset['run'] == 3][dataset['forest'] == 1],
              dataset[var_1[var]][dataset['run'] == 4][dataset['forest'] == 1],
              dataset[var_1[var]][dataset['run'] == 5][dataset['forest'] == 1],
              dataset[var_1[var]][dataset['run'] == 6][dataset['forest'] == 1],
              dataset[var_1[var]][dataset['run'] == 7][dataset['forest'] == 1],
              dataset[var_1[var]][dataset['run'] == 8][dataset['forest'] == 1],
              dataset[var_1[var]][dataset['run'] == 9][dataset['forest'] == 1])
              # dataset[var_1[var]][dataset['run'] == 0][dataset['forest'] == 1])

def make_tlist4(dataset,var):
    return  dataset[var_1[var]][dataset['forest'] == 1]   #][dataset['forest'] = 1]

def make_tlist5(dataset,var):
    return  dataset[var_2[var]][dataset['forest'] == 1]   #][dataset['forest'] = 1]

def runs(datasets, var):
    f, (ax1, ax2, ax3, ax4) = plt.subplots(4, sharex=True, sharey=True)
    f.set_figheight(10)
    f.set_figwidth(3)
    #f.set_dpi(400)

    titles = ['g1','Vcmax','Leaf Turnover','AWood Turnover','FRoot Turnover',
            'Leaf Allocation','AWood Allocation','FRoot Allocation']

    rs = ['50 PLS','100 PLS','200 PLS','500 PLS']
    iter_1 = [1,2,3,4,5,6,7,8,9,0]
    # axis 1
    ax1.set_title(titles[var])
    ax1.set_ylabel(rs[0])
    t_list = make_tlist(datasets[0], var)
    ax1.axis(axis_dict[var_1[var]])
    for x in iter_1:
        a = (read_data2(x,var,50).mean())
        if x == 0: x = 10
        ax1.vlines(a, x - 0.35, x + 0.35, colors='yellowgreen', linestyles='solid')
    ax1.boxplot(t_list, sym='', vert=False, whis=[0.5,99.5], widths=0.5)
    
    # axis 2
    t_list = make_tlist(datasets[1], var)
    ax2.axis(axis_dict[var_1[var]])
    ax2.set_ylabel(rs[1])
    for x in iter_1:
        a = (read_data2(x,var,100).mean())
        if x == 0: x = 10
        ax2.vlines(a, x - 0.35, x + 0.35, colors='yellowgreen', linestyles='solid')
    ax2.boxplot(t_list, sym='', vert=False, whis=[0.5,99.5], widths=0.5)

    # axis 3
    t_list = make_tlist(datasets[2], var)
    ax3.set_ylabel(rs[2])
    ax3.axis(axis_dict[var_1[var]])    
    for x in iter_1:
        a = (read_data2(x,var,200).mean())
        if x == 0: x = 10
        ax3.vlines(a, x - 0.35, x + 0.35, colors='yellowgreen', linestyles='solid')
    ax3.boxplot(t_list, sym='', vert=False, whis=[0.5,99.5], widths=0.5)

    # axis 4
    t_list = make_tlist(datasets[3], var)
    ax4.set_ylabel(rs[3])
    ax4.axis(axis_dict[var_1[var]])
    for x in iter_1:
        a = (read_data2(x,var,500).mean())
        if x == 0: x = 10
        ax4.vlines(a, x - 0.35, x + 0.35, colors='yellowgreen', linestyles='solid')
    ax4.boxplot(t_list, sym='', vert=False, whis=[0.5,99.5], widths=0.5)
    if var == 1:
        start, end = ax4.get_xlim()
        ax4.xaxis.set_ticks(np.linspace(start, end, 3))
        ax4.xaxis.set_major_formatter(ticker.FormatStrFormatter('%.1e'))
    f.subplots_adjust(hspace=0)
    plt.setp([a.get_xticklabels() for a in f.axes[:-1]], visible=False)
    plt.setp([a.get_yticklabels() for a in f.axes[:]], visible=False)
    plt.savefig(var_1[var] +'.png',dpi=200)


def boxplots_runs():

    datasets = read_data1()

    runs(datasets,0)
    runs(datasets,1)
    runs(datasets,2)
    runs(datasets,3)
    runs(datasets,4)
    runs(datasets,5)
    runs(datasets,6)
    runs(datasets,7)


def normalize(vector):
    ma = vector.max()
    mi = vector.min()
    return (vector - mi) / (ma - mi)

def normalize2(vector1, vector2):
    ma1, mi1 = vector1.max(), vector1.min()
    ma2, mi2 = vector2.max(), vector2.min()

    ma = max(ma1, ma2)
    mi = min(mi1, mi2)

    a = (vector1 - mi) / (ma - mi)
    b = (vector2 - mi) / (ma - mi)

    return a,b


def cwm_dataframe(dataset):
    #cols = pd.DataFrame(dict(zip(var_1, dataset[var_1][:]
    z = dict()
    for var in var_1:
        z[var] = normalize(dataset[var])
    return pd.DataFrame(z,columns=var_1)

def cwm_1dataframe(dataset,cwm=True):
    #cols = pd.DataFrame(dict(zip(var_1, dataset[var_1][:]
    if cwm:
        v_1 = var_1
    else:
        v_1 = var_2
    z = dict()
    for var in v_1:
        z[var] = normalize(dataset[var])
    return pd.DataFrame(z,columns=v_1)


def cwm_2dataframe(dataset):
    #cols = pd.DataFrame(dict(zip(var_1, dataset[var_1][:]
    var_1 = ['g1_cwm','vcmax_cwm','tleaf_cwm','twood_cwm',
        'troot_cwm','aleaf_cwm','awood_cwm','aroot_cwm',
        'g1_cwv','vcmax_cwv','tleaf_cwv','twood_cwv',
        'troot_cwv','aleaf_cwv','awood_cwv','aroot_cwv',
        'forest', 'ny', 'nx']
    z = dict()
    for var in var_1:
        z[var] = dataset[var][:]
    return pd.DataFrame(z,columns=var_1)


def application_plots(pls, app=False):
    if not app:
        data = read_data15(pls)
    else:
        data = read_data15(pls,True)    
    cc = cwm_dataframe(data)
    cc.boxplot(vert=False)
    plt.xlim((-0.05, 1.05))
    #plt.savefig('fig_teste.png', dpi=200)


def mount(trait, cwm=True):
    # out_n = read_data15(500)
    # out_eCO2 = read_data15(500,True)

    out_n = pd.read_csv('nCO2_cwm.csv')
    out_eCO2 = pd.read_csv('eCO2_cwm.csv')
    app = ['363 ppmv', '600 ppmv']

    if cwm:
        v = var_1
    else:
        v = var_2

    c1 = out_n[v[trait]][out_n['forest'] == 1][:]
    c2 = out_eCO2[v[trait]][out_eCO2['forest'] == 1][:]
    print(c1.shape, c2.shape)

    df = dict(zip(app,(c1,c2)))

    df = pd.DataFrame(df,columns=app)
    return df


def plot_hist(cwm=True):
    if cwm: cw = ' CWM'
    if not cwm: cw = ' CWV'
    t = ['g1','Vcmax','Leaf Turnover','Aboveground wood Turnover','Fine root Turnover',
         'Leaf Allocation','Abovegrouund wood Allocation','Fine root Allocation']
    for i in range(8):
        data = mount(i,cwm)
        data.plot(kind='hist',bins=100,alpha=0.5,title=t[i] + cw)

def vplot1(trait):
    t = ['g1','Vcmax','Tleaf','TAwood','TFroot','Aleaf','AAwood','AFroot']

    u1 = r'CWM ' + r'$\mu$' + r'mol' + r' $H_2O$' + r' $m^-$' + r'$^2$' + r' $s^-$' + r'$^1$'
    u2 = r'CWM ' + r'$\mu$' + r'mol' + r' $CO_2$' + r' $m^-$' + r'$^2$' + r' $s^-$' + r'$^1$'
    u3 = r'CWM ' + r'$\tau$' + ' L (anos)'
    u4 = r'CWM ' + r'$\tau$' + ' AW (anos)'
    u5 = r'CWM ' + r'$\tau$' + ' FR (anos)'
    u6 = r'CWM ' + r'$\alpha$' + ' L'
    u7 = r'CWM ' + r'$\alpha$' + ' AW'
    u8 = r'CWM ' + r'$\alpha$' + ' FR'
    u = [u1,u2,u3,u4,u5,u6,u7,u8]

    f1 = read_data15(500)      # NORMAL
    f2 = read_data15(500, True)# ECO2


    out = make_tlist(f1,trait)
    out2 = make_tlist(f2,trait)

    f, (ax1, ax2) = plt.subplots(2, sharex=True, sharey=True)
    ax1.set_title(t[trait])
    #ax1.set_ylim(0,10)
    ax1.set_yticklabels(('','r1','r2','r3','r4','r5','r6','r7','r8','r9','r10', ''))
    ax1.set_ylabel('363 ppmv')
    #ax1.boxplot(out)
    ax1.violinplot(out,vert=False, widths=1, showmedians=True, showmeans=True)#,bins=30)
    #ax2.set_ylim(0,10)
    ax2.set_yticklabels(('','r1','r2','r3','r4','r5','r6','r7','r8','r9','r10',''))
    ax2.set_ylabel('600 ppmv')
    ax2.set_xlabel(u[trait])
    #ax2.boxplot(out2)
    ax2.violinplot(out2,vert=False, widths=1,showmedians=True, showmeans=True)#, bins=30)
    f.subplots_adjust(hspace=0.3)
    plt.show()

def vplot_norm(cwm=True):
    colors = ['fuchsia','lime','gold','crimson','blue','green','darkorchid','cyan']
    #f1 = read_data15(500)      # NORMAL
    #f2 = read_data15(500, True)# ECO2
    f1 = pd.read_csv('nCO2_cwm.csv')
    f2 = pd.read_csv('eCO2_cwm.csv')
    nCO2 = []
    eCO2 = []
    if cwm:
        tl = make_tlist4
    else:
        tl = make_tlist5

    for i in range(8):
        out = tl(f1,i)
        out2 = tl(f2,i)

        temp1, temp2 = normalize2(out, out2)

        nCO2.append(temp1)
        eCO2.append(temp2)

    normal = np.array(pd.DataFrame(np.array(nCO2).T, columns=var_1))
    elevat = np.array(pd.DataFrame(np.array(eCO2).T, columns=var_1))

    var_names1 = [f.split('_')[0] for f in var_1]
    var_names0 = ['']
    var_names2 = ['']

    var_names = var_names0 + var_names1 + var_names2

    f, (ax1, ax2) = plt.subplots(2, sharex=True, sharey=True)
    ax1.set_title(' Traits CWMs distributions in Tropical Forests')
    ax1.set_yticklabels(var_names)
    ax1.set_xlim(left=-0.1, right=1.1, emit=True, auto=False)
    ax1.set_ylabel('363 ppmv')
    ax1.grid(color='k')
    v = ax1.violinplot(normal,vert=False,widths=1,showmedians=True, showmeans=True)#,bins=30)
    for i,c in enumerate(v['bodies']):
        c.set_facecolor(colors[i])
        c.set_edgecolor('black')
    v['cmeans'].set_color('k')
    #v['cmeans'].set_linewidth(0.2)
    ax2.set_yticklabels(var_names)
    ax2.set_xlim(left=-0.1, right=1.1, emit=True, auto=False)
    ax2.set_ylabel('600 ppmv')
    ax2.grid(color='k')
    ax2.set_xlabel('Normalized values')
    v1 = ax2.violinplot(elevat,vert=False,widths=1,showmedians=True, showmeans=True)#, bins=30)
    for i,c in enumerate(v1['bodies']):
        c.set_facecolor(colors[i])
        c.set_edgecolor('black')
    v1['cmeans'].set_color('k')
    f.subplots_adjust(hspace=0)
    plt.savefig('vplot_norm.png',dpi=500)
    #plt.show()

# -----------------------------------------------------------



def read_vars(var):
    nCO2 = read_data15(500)
    eCO2 = read_data15(500, True)

    vari = list(nCO2.keys()[7:21])

    colnames = ['363ppmv','600ppmv']
    n = nCO2[var][nCO2['forest'] == 1]
    e = eCO2[var][eCO2['forest'] == 1]

    d = dict(zip(colnames, (n,e)))
    #d = pd.DataFrame(d, columns=colnames)
    return d

def wue_cue_barh():

    groups=1
    bar_width = 0.1
    opacity = 1
    error_config = {'ecolor': '0.3'}
    index = np.arange(groups)

    nCO2 = read_data15(500)
    eCO2 = read_data15(500, True)

    f, (ax2, ax1) = plt.subplots(2,sharey=False, sharex=False)

    # WUE
    wmeans_eCO2 = eCO2['wue'][eCO2['forest'] == 1].mean()
    wstd_eCO2 = eCO2['wue'][eCO2['forest'] == 1].std()
    wmeans_nCO2 = nCO2['wue'][nCO2['forest'] == 1].mean()
    wstd_nCO2 = nCO2['wue'][nCO2['forest'] == 1].std()

    # CUE
    cmeans_eCO2 = eCO2['cue'][eCO2['forest'] == 1].mean()
    cstd_eCO2 = eCO2['cue'][eCO2['forest'] == 1].std()
    cmeans_nCO2 = nCO2['cue'][nCO2['forest'] == 1].mean()
    cstd_nCO2 = nCO2['cue'][nCO2['forest'] == 1].std()


    ax1.barh(index, wmeans_eCO2, bar_width,
             alpha=opacity,
             color='red',
             xerr=wstd_eCO2,
             error_kw=error_config,
             label='600 ppmv')

    ax1.barh(index + bar_width, wmeans_nCO2, bar_width,
             alpha=opacity,
             color='cyan',
             xerr=wstd_nCO2,
             error_kw=error_config,
             label='343 ppmv')

    ax2.barh(index, cmeans_eCO2, bar_width,
             alpha=opacity,
             color='red',
             xerr=cstd_eCO2,
             error_kw=error_config,
             label='600 ppmv')

    ax2.barh(index + bar_width, cmeans_nCO2, bar_width,
             alpha=opacity,
             color='cyan',
             xerr=cstd_nCO2,
             error_kw=error_config,
             label='343 ppmv')

    ax1.set_title('WUE')
    ax2.set_title('(média entre runs)CUE')
    #ax1.set_yticklabels(('363', '600'))
    #ax2.set_yticklabels(('363', '600'))

    ax1.set_ylim(index[0]-0.05, index[-1]+0.25)
    ax2.set_ylim(index[0]-0.05, index[-1]+0.25)
    ax1.set_xlabel('Unidade de WUE')
    ax2.set_xlabel('Unidade de CUE')
    plt.setp([a.get_yticklabels() for a in f.axes[:]], visible=False)
    f.subplots_adjust(hspace=0.5)
    plt.legend(prop={'size':8})
    #plt.legend()
    plt.show()

def bars_1():
    """PLot barplot for gpp ra npp [nCO2 eCO2]"""
    n_groups = 3
    nCO2 = read_data15(500)
    eCO2 = read_data15(500, True)

    means_eCO2 = [eCO2['gpp'][eCO2['forest'] == 1].mean(),
                  eCO2['ra'][eCO2['forest'] == 1].mean(),
                  eCO2['npp'][eCO2['forest'] == 1].mean()]

    std_eCO2 = [eCO2['gpp'][eCO2['forest'] == 1].std(),
                eCO2['ra'][eCO2['forest'] == 1].std(),
                eCO2['npp'][eCO2['forest'] == 1].std()]

    means_nCO2 =  [nCO2['gpp'][nCO2['forest'] == 1].mean(),
                  nCO2['ra'][nCO2['forest'] == 1].mean(),
                  nCO2['npp'][nCO2['forest'] == 1].mean()]

    std_nCO2 = [nCO2['gpp'][nCO2['forest'] == 1].std(),
                nCO2['ra'][nCO2['forest'] == 1].std(),
                nCO2['npp'][nCO2['forest'] == 1].std()]

    fig, ax = plt.subplots()

    index = np.arange(n_groups)
    bar_width = 0.3

    opacity = 1
    error_config = {'ecolor': '0.3'}

    rects1 = plt.bar(index, means_eCO2, bar_width,
             alpha=opacity,
             color='red',
             yerr=std_eCO2,
             error_kw=error_config,
             label='600 ppmv')

    rects2 = plt.bar(index + bar_width, means_nCO2, bar_width,
             alpha=opacity,
             color='cyan',
             yerr=std_nCO2,
             error_kw=error_config,
             label='363 ppmv')


    #plt.set_xlim(left=-0.1, right=1.1, emit=True, auto=False)

    plt.ylabel(r'$Kg$' + '$C$' + r' $ m^-$' + r'$^2$' + r' $year^-$' + r'$^1$')
    plt.title(r'$eCO_2$' + r' application')
    plt.xlim(index[0]-0.2, index[-1]+0.8)
    plt.xticks(index + bar_width, ('GPP', 'RA', 'NPP'))
    plt.legend()

    #plt.tight_layout()
    plt.show()

def g1_vcmax():
    nCO2 = read_data15(500)
    eCO2 = read_data15(500,True)

    ax = plt.axes()

     #ax.plot(nCO2.g1_cwm[nCO2.forest == 1], nCO2.vcmax_cwm[nCO2.forest==1])

     #ax.scatter(eCO2.g1_cwm[eCO2.forest == 1], eCO2.vcmax_cwm[eCO2.forest==1])
     #ax.set_xlim(5e-4, 10e-4)

    ax.semilogx(nCO2.vcmax_cwm[nCO2.forest == 1], nCO2.g1_cwm[nCO2.forest==1],'bo',
             eCO2.vcmax_cwm[eCO2.forest == 1], eCO2.g1_cwm[eCO2.forest==1],'ro', alpha=0.3)
    plt.show()
 
def data_500(e=False):

    if not e:
        return read_data15(500)
    else:
        return read_data15(500,True)


def cwm_map(varn = 0, cwm=True):
    if cwm:
        vl = var_1
    else:
        vl = var_2

    datan = pd.read_csv('nCO2_cwm.csv',dtype=np.float32)
    datae = pd.read_csv('eCO2_cwm.csv',dtype=np.float32)
    indexn = np.arange(datan.shape[0],dtype=np.int32)
    indexe = np.arange(datae.shape[0],dtype=np.int32)
    
    outn = np.zeros(shape=(360,720),dtype=np.float32) - 9999.0
    oute = np.zeros(shape=(360,720),dtype=np.float32) - 9999.0

    for i in indexn:
        if False: #datan.iloc[i]['forest'] == 0:
            continue
        else:
            nx = datan.iloc[i]['nx']
            ny = datan.iloc[i]['ny']
            data = datan.iloc[i][vl[varn]]
            outn[np.int32(ny), np.int32(nx)] = data
    for i in indexe:
        if False: #datae.iloc[i]['forest'] == 0:
            continue
        else:
            nx = datae.iloc[i]['nx']
            ny = datae.iloc[i]['ny']
            data = datae.iloc[i][vl[varn]]
            oute[np.int32(ny), np.int32(nx)] = data
            
    z = ((oute - outn)/outn) * 100#np.ma.masked_array(oute, oute == -9999.0, fill_value=-9999) - np.ma.masked_array(outn, oute == -9990.0, fill_value=-9999.0)
    return np.ma.masked_array(z, z == 0.0,fill_value=-9999.0), vl[varn]



def array2nc(nCO2=True, varn=0):

    if nCO2:
        namef = 'nCO2_cwm.csv'
    else:
        namef = 'eCO2_cwm.csv'

    datan = pd.read_csv(namef,dtype=np.float32)

    indexn = np.arange(datan.shape[0],dtype=np.int32)
    outn = np.zeros(shape=(360,720),dtype=np.float32) - 9999.0

    for i in indexn:
        nx = datan.iloc[i]['nx']
        ny = datan.iloc[i]['ny']
        data = datan.iloc[i][var_1[varn]]
        outn[np.int32(ny), np.int32(nx)] = data

    out_name  = namef.split('_')[0] + '-' + var_1[varn] + '.nc'

    save_nc(out_name, outn, out_name.split('.')[0])

def save_nc(fname, arr, varname):
    import netCDF4

    nc_filename = fname

    rootgrp = netCDF4.Dataset(nc_filename, mode='w', format='NETCDF4')

    la = arr.shape[0]
    lo = arr.shape[1]

        #dimensions
    rootgrp.createDimension("latitude", la)
    rootgrp.createDimension("longitude", lo)

        #variables

    latitude = rootgrp.createVariable(varname="latitude",
                                      datatype=np.float32,
                                      dimensions=("latitude",))

    longitude = rootgrp.createVariable(varname="longitude",
                                       datatype=np.float32,
                                       dimensions=("longitude",))

    var_ = rootgrp.createVariable(varname = 'cwm_dif',
                                  datatype=np.float32,
                                  dimensions=("latitude","longitude",),
                                  fill_value=-9999.0)

        #attributes
        ## rootgrp
    rootgrp.description =  'Differences betwen cmw - 363-600 ppmv- CAETE application'
    rootgrp.source = "jpdarela at rc.unesp.br"
    ## lat
    latitude.units = u"degrees_north"
    latitude.long_name=u"latitude"
    latitude.standart_name =u"latitude"
    latitude.axis = u'Y'
    ## lon
    longitude.units = "degrees_east"
    longitude.long_name = "longitude"
    longitude.standart_name = "longitude"
    longitude.axis = 'X'
    ## var
    var_.long_name = varname
    var_.units = '%'
    var_.standard_name='cwm-differences'
    var_.missing_value=-9999.0
    ## WRITING DATA

    longitude[:] = np.arange(-179.75, 180, 0.5)
    latitude[:] =  np.arange(-89.75, 90, 0.5)
    var_[:,:] = np.flipud(arr)
    rootgrp.close()

def save_diffs():

    for i in range(8):
        arr,name = cwm_map(i)
        varname = name + '_diff'
        save_nc(varname + '.nc', arr, varname)

# def plot_maps():

#     from mpl_toolkits.basemap import Basemap

#     # map = Basemap(projection='ortho', lat_0 = -23, lon_0 = -60)
#     # sa = {'projection' : 'aeqd',
#     #           'lon_0' : -60,
#     #           'lat_0' : -23,
#     #           'width' : 8000000,
#     #           'height' : 8000000}
#     # map = Basemap(**sa)


#     map = Basemap(projection='cyl', 
#               lat_0=0, lon_0=0,
#               llcrnrlon=-180, 
#               llcrnrlat=-90, 
#               urcrnrlon=180, 
#               urcrnrlat=90)

#     data = cwm_map(0).data
# #
#     # x = np.arange(-179.75, 180, 0.5)
#     # y =  np.arange(-89.75, 90, 0.5)

#     x = np.linspace(-180, map.urcrnrx + 180, data.shape[1])
#     y = np.linspace(-90, map.urcrnry + 90, data.shape[0])
#     xx, yy = np.meshgrid(x, y)

#     map.pcolormesh(xx, yy, data)
#     map.drawmapboundary(fill_color='aqua')
#     map.fillcontinents(color='#ddaa66',lake_color='aqua')
#     map.drawcoastlines()
#     #map.readshapefile('../sample_files/comarques', 'comarques')
#     plt.show()






# # def bars_2():
# #     """PLot barplot for WUE CUE [nCO2 eCO2]"""
# #     n_groups = 2
# #     nCO2 = read_data15(500)
# #     eCO2 = read_data15(500, True)

# #     means_eCO2 = [eCO2['wue'][eCO2['forest'] == 1].mean(),
# #                   eCO2['cue'][eCO2['forest'] == 1].mean()]

# #     std_eCO2 = [eCO2['wue'][eCO2['forest'] == 1].std(),
# #                 eCO2['cue'][eCO2['forest'] == 1].std()]

# #     means_nCO2 =  [nCO2['wue'][nCO2['forest'] == 1].mean(),
# #                   nCO2['cue'][nCO2['forest'] == 1].mean()]

# #     std_nCO2 = [nCO2['wue'][nCO2['forest'] == 1].std(),
# #                 nCO2['cue'][nCO2['forest'] == 1].std()]

# #     fig, ax = plt.subplots()

# #     index = np.arange(n_groups)
# #     bar_width = 0.4

# #     opacity = 1
# #     error_config = {'ecolor': '0.3'}

# #     rects1 = plt.bar(index, means_eCO2, bar_width,
# #              alpha=opacity,
# #              color='deeppink',
# #              yerr=std_eCO2,
# #              error_kw=error_config,
# #              label='600 ppmv')

# #     rects2 = plt.bar(index + bar_width, means_nCO2, bar_width,
# #              alpha=opacity,
# #              color='blue',
# #              yerr=std_nCO2,
# #              error_kw=error_config,
# #              label='363 ppmv')


# #     #plt.set_xlim(left=-0.1, right=1.1, emit=True, auto=False)

# #     plt.ylabel(r'$Kg$' + r' $ m^-$' + r'$^2$' + r' $year^-$' + r'$^1$')
# #     plt.title(r'$eCO_2$' + r' application')
# #     plt.xlim(index[0]-0.2, index[-1]+0.8)
# #     plt.xticks(index + bar_width, ('GPP', 'RA', 'NPP'))
# #     plt.legend()

# #     #plt.tight_layout()
# #     plt.show()

# def bars_3():
#     """PLot barplot for gpp ra npp [nCO2 eCO2]"""
#     n_groups = 2
#     nCO2 = read_data15(500)
#     eCO2 = read_data15(500, True)

#     means_eCO2 = [(eCO2['cleaf'][eCO2['forest'] == 1] * eCO2['area_m2'][eCO2['forest'] == 1]).sum() * 1e-12 /9,
#                   (eCO2['cawood'][eCO2['forest'] == 1] * eCO2['area_m2'][eCO2['forest'] == 1]).sum() * 1e-12 /9,
#                   (eCO2['cfroot'][eCO2['forest'] == 1] * eCO2['area_m2'][eCO2['forest'] == 1]).sum() * 1e-12 /9]

#     std_eCO2 = [eCO2['cleaf'][eCO2['forest'] == 1].std(),
#                 eCO2['cawood'][eCO2['forest'] == 1].std(),
#                 eCO2['cfroot'][eCO2['forest'] == 1].std()]

#     means_nCO2 =  [(nCO2['cleaf'][nCO2['forest'] == 1] * nCO2['area_m2'][nCO2['forest'] == 1]).sum() * 1e-12 /10,
#                    (nCO2['cawood'][nCO2['forest'] == 1] * nCO2['area_m2'][nCO2['forest'] == 1]).sum() * 1e-12 /10,
#                    (nCO2['cfroot'][nCO2['forest'] == 1] * nCO2['area_m2'][nCO2['forest'] == 1]).sum() * 1e-12 /10]

#     std_nCO2 = [nCO2['cleaf'][nCO2['forest'] == 1].std(),
#                 nCO2['cawood'][nCO2['forest'] == 1].std(),
#                 nCO2['cfroot'][nCO2['forest'] == 1].std()]

#     fig, ax = plt.subplots()
#     index = np.arange(n_groups)
#     bar_width = 0.2
     
#     opacity = 1
#     error_config = {'ecolor': '0.3'}

#     rects1 = plt.bar(index, means_eCO2, bar_width,
#              alpha=opacity,
#              color='red',
#              yerr=std_eCO2,
#              error_kw=error_config,
#              label='600 ppmv')

#     rects2 = plt.bar(index + bar_width, means_nCO2, bar_width,
#              alpha=opacity,
#              color='cyan',
#              yerr=std_nCO2,
#              error_kw=error_config,
#              label='363 ppmv')


#     #plt.set_xlim(left=-0.1, right=1.1, emit=True, auto=False)

#     plt.ylabel(r'$Pg$' + '$C$')
#     plt.title(r'$eCO_2$' + r' $application$')
#     plt.xlim(index[0]-0.2, index[-1]+0.8)
#     plt.xticks(index + bar_width, ('Leaf Biomass', 'AWood Biomass', 'FRoots Biomass'))
#     plt.legend()


#     #plt.tight_layout()
#     #ax.semilogy(10)
#     plt.show()




# def bars_4():
#     """PLot barplot for gpp ra npp [nCO2 eCO2]"""
#     n_groups = 1
#     nCO2 = read_data15(500)
#     eCO2 = read_data15(500, True)

#     means_eCO2 = eCO2['wue'][eCO2['forest'] == 1].mean()
#     std_eCO2 = eCO2['wue'][eCO2['forest'] == 1].std()

#     means_nCO2 = nCO2['wue'][nCO2['forest'] == 1].mean()
#     std_nCO2 = nCO2['wue'][nCO2['forest'] == 1].std()

#     fig, ax = plt.subplots()
#     index = np.arange(n_groups)
#     bar_width = 0.1
     
#     opacity = 1
#     error_config = {'ecolor': '0.3'}

#     rects1 = plt.bar(index, means_eCO2, bar_width,
#              alpha=opacity,
#              color='red',
#              yerr=std_eCO2,
#              error_kw=error_config,
#              label='600 ppmv')

#     rects2 = plt.bar(index + bar_width, means_nCO2, bar_width,
#              alpha=opacity,
#              color='cyan',
#              yerr=std_nCO2,
#              error_kw=error_config,
#              label='363 ppmv')


#     #plt.set_xlim(left=-0.1, right=1.1, emit=True, auto=False)

#     plt.ylabel(r'$Kg$' + '$C$' + r' $ m^-$' + r'$^2$' + r' $year^-$' + r'$^1$')
#     plt.title(r'$eCO_2$' + r' application')
#     #plt.xlim(index[0]-0.2, index[-1]+0.8)
#     plt.yticks(index + bar_width, ('WUE'))
#     plt.legend()
#     plt.show()


# #DBSCAN
# def dbscan_caete():
#     import numpy as np
#     from sklearn.cluster import DBSCAN
#     from sklearn import metrics
#     from sklearn.datasets.samples_generator import make_blobs
#     from sklearn.preprocessing import StandardScaler
#     X = pd.read_csv('out500.csv')
#     X = pd.DataFrame(X[X.keys()[18:34]])
#     varnames = X.keys()

#     X = StandardScaler().fit_transform(np.array(X))

#     db = DBSCAN(eps=0.3, min_samples=10).fit(X)
#     core_samples_mask = np.zeros_like(db.labels_, dtype=bool)
#     core_samples_mask[db.core_sample_indices_] = True
#     labels = db.labels_

#     n_clusters_ = len(set(labels)) - (1 if -1 in labels else 0)
#     #print(n_clusters)
#     unique_labels = set(labels)
#     colors = plt.cm.Spectral(np.linspace(0, 1, len(unique_labels)))
#     for k, col in zip(unique_labels, colors):
#         if k == -1:
#             # Black used for noise.
#             col = 'k'

#         class_member_mask = (labels == k)

#         xy = X[class_member_mask & core_samples_mask]
#         plt.plot(xy[:, 0], xy[:, 1], 'o', markerfacecolor=col,
#                  markeredgecolor='k', markersize=1)

#         xy = X[class_member_mask & ~core_samples_mask]
#         plt.plot(xy[:, 0], xy[:, 1], 'o', markerfacecolor=col,
#                  markeredgecolor='k', markersize=1)

#     plt.title('Estimated number of clusters: %d' % n_clusters_)
#     plt.show()

#     # hist_n = np.ones((8,normal.shape[0]))
#     # hist_e = np.ones((8,elevat.shape[0]))

    # for z in range(8):
    #     hist_n[z],edges= np.histogram(normal[z,:],bins=np.arange(50))
    #     hist_e[z],edges2 = np.histogram(elevat[z,:],bins=np.arange(50))

    # fig, ax1, ax2= plt.subplots(2,figsize=(6,6))



    # ax1.imshow(hist, cmap=plt.cm.Reds, interpolation='none', extent=[0,1,8,1])
    # ax1.set_aspect(2)
    # ax2.imshow(hist, cmap=plt.cm.Reds, interpolation='none', extent=[0,1,8,1])
    # ax2.set_aspect(2)

# for i in range(8):
#     vplot1(i)


    # means_eCO2 = [(eCO2['cmass'][eCO2['forest'] == 1] * eCO2['area_m2'][eCO2['forest'] == 1]).sum() * 1e-12 /7,
    #               (eCO2['cleaf'][eCO2['forest'] == 1] * eCO2['area_m2'][eCO2['forest'] == 1]).sum() * 1e-12 /7,
    #               (eCO2['cawood'][eCO2['forest'] == 1] * eCO2['area_m2'][eCO2['forest'] == 1]).sum() * 1e-12 /7,
    #               (eCO2['cfroot'][eCO2['forest'] == 1] * eCO2['area_m2'][eCO2['forest'] == 1]).sum() * 1e-12 /7]

    # std_eCO2 = [eCO2['cmass'][eCO2['forest'] == 1].std(),
    #             eCO2['cleaf'][eCO2['forest'] == 1].std(),
    #             eCO2['cawood'][eCO2['forest'] == 1].std(),
    #             eCO2['cfroot'][eCO2['forest'] == 1].std()]

    # means_nCO2 =  [(nCO2['cmass'][nCO2['forest'] == 1] * nCO2['area_m2'][nCO2['forest'] == 1]).sum() * 1e-12 /10,
    #                (nCO2['cleaf'][nCO2['forest'] == 1] * nCO2['area_m2'][nCO2['forest'] == 1]).sum() * 1e-12 /10,
    #                (nCO2['cawood'][nCO2['forest'] == 1] * nCO2['area_m2'][nCO2['forest'] == 1]).sum() * 1e-12 /10,
    #                (nCO2['cfroot'][nCO2['forest'] == 1] * nCO2['area_m2'][nCO2['forest'] == 1]).sum() * 1e-12 /10]

    # std_nCO2 = [nCO2['cmass'][nCO2['forest'] == 1].std(),
    #             nCO2['cleaf'][nCO2['forest'] == 1].std(),
    #             nCO2['cawood'][nCO2['forest'] == 1].std(),
    #             nCO2['cfroot'][nCO2['forest'] == 1].std()]




#def boxplot_runs(dataset, var, title, plss):
#     t_list = (dataset[var_1[var]][dataset['run'] == 1][dataset['forest'] == 1],
#               dataset[var_1[var]][dataset['run'] == 2][dataset['forest'] == 1],
#               dataset[var_1[var]][dataset['run'] == 3][dataset['forest'] == 1],
#               dataset[var_1[var]][dataset['run'] == 4][dataset['forest'] == 1],
#               dataset[var_1[var]][dataset['run'] == 5][dataset['forest'] == 1],
#               dataset[var_1[var]][dataset['run'] == 6][dataset['forest'] == 1],
#               dataset[var_1[var]][dataset['run'] == 7][dataset['forest'] == 1],
#               dataset[var_1[var]][dataset['run'] == 8][dataset['forest'] == 1],
#               dataset[var_1[var]][dataset['run'] == 9][dataset['forest'] == 1],
#               dataset[var_1[var]][dataset['run'] == 0][dataset['forest'] == 1])
#     plt.title(str('%s %s %s'%(var_1[var],str(plss),title)))
#     plt.xlabel(var_1[var])
#     plt.ylabel('Run')
#     plt.axis(axis_dict[var_1[var]])
#     plt.boxplot(t_list, sym='x', vert=False, whis=[2.5,97.5])
#     plt.show()

# def boxplot_runs2(dataset, var, title, plss):
#     t_list = (dataset[var_1[var]][dataset['run'] == 1],
#               dataset[var_1[var]][dataset['run'] == 2],
#               dataset[var_1[var]][dataset['run'] == 3],
#               dataset[var_1[var]][dataset['run'] == 4],
#             1 dataset[var_1[var]][dataset['run'] == 5],
#             2 dataset[var_1[var]][dataset['run'
#              runs(datasets,7) #dataset[var_1[var]][dataset['run'] == 7],
#               #dataset[var_1[var]][dataset['run'] == 8],
#               #dataset[var_1[var]][dataset['run'] == 9],
#               #dataset[var_1[var]][dataset['run'] == 10])
#     plt.title(str('%s %s %s'%(var_1[var],str(plss),title)))
#     plt.xlabel(var_1[var])
#     plt.ylabel('Run')
#     plt.axis(axis_dict[var_1[var]])
#     plt.boxplot(t_list, sym='x', vert=False, whis=[2.5,97.5])
#     plt.show()


# def boxplot_runs3(dataset, var, title, plss):
#     t_list = (dataset[var_1[var]][dataset['run'] == 1][dataset['forest'] == 1],
#              a
# _1[var]][dataset['run'] == 2][dataset['forest'] == 1],
#     runs(datasets,0)          dataset[var_1[var]][dataset['run'] == 3][dataset['forest'] == 1],
#               dataset[var_1[var]][dataset['run'] == 4][dataset['forest'] == 1],
#               dataset[var_1[var]][dataset['run'] == 5][dataset['forest'] == 1],
#               dataset[var_1[var]][dataset['run'] == 6][dataset['forest'] == 1],
#               dataset[var_1[var]][dataset['run'] == 7][dataset['forest'] == 1],
#               dataset[var_1[var]][dataset['run'] == 8][dataset['forest'] == 1],
#               dataset[var_1[var]][dataset['run'] == 9][dataset['forest'] == 1])
#               #dataset[var_1[var]][dataset['run'] == 0][dataset['forest'] == 1])
#     plt.title(str('%s %s %s'%(var_1[var],str(plss),title)))
#     plt.xlabel(var_1[var])
#     plt.ylabel('Run')
#     plt.axis(axis_dict[var_1[var]])
#     plt.boxplot(t_list, sym='x', vert=False, whis=[2.5,97.5])
#     plt.show()


# def violinplot_runs(dataset, var, title, plss):
#     t_list = (dataset[var_1[var]][dataset['run'] == 1][dataset['forest'] == 1],
#               dataset[var_1[var]][dataset['run'] == 2][dataset['forest'] == 1],
#               dataset[var_1[var]][dataset['run'] == 3][dataset['forest'] == 1],
#               dataset[var_1[var]][dataset['run'] == 4][dataset['forest'] == 1],
#               dataset[var_1[var]][dataset['run'] == 5][dataset['forest'] == 1],
#               dataset[var_1[var]][dataset['run'] == 6][dataset['forest'] == 1])
#               #dataset[var_1[var]][dataset['run'] == 7],
#               #dataset[var_1[var]][dataset['run'] == 8],
#               #dataset[var_1[var]][dataset['run'] == 9],
#               #dataset[var_1[var]][dataset['run'] == 10])
#     plt.title(str('%s %s %s'%(var_1[var],str(plss),title)))
#     plt.xlabel(var_1[var])
#     plt.ylabel('Run')
#     plt.axis(axis_dict[var_1[var]])
#     plt.violinplot(t_list, positions=range(1,7), vert=False, showextrema=True,showmedians=True)
#     plt.show()


# # plt.figure(1)
# # plt.subplot(141)
# # plt.

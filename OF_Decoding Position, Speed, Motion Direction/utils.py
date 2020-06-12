import numpy as np
import os
import scipy.stats as stats

def make_dir(di):
    def _make_dir(di):
        if not os.path.exists(di):
            os.mkdir(di)
            #print 'mkdir : {}'.format(di)
            return 1
        return 0
    
    folder_name_list=di.split('/')
    
    dir_list=[]
    for k,fn in enumerate(folder_name_list):
        if k==0:
            dir_list.append(fn)
        elif k>0:
            dir_list.append(dir_list[k-1] +'/'+ fn)
    r=0
    for dn in dir_list:
        r+=_make_dir(dn)
    if r>0:
        print('mkdir : {}'.format(di))
        
def write_dict(x):
    for k,a in enumerate(x):
        if k==0:
            print('{{\'{}\':{},'.format(a,a))
            continue
        if k==len(x)-1:
            print('\'{}\':{}}}'.format(a,a))
            continue
        print('\'{}\':{},'.format(a,a))
        
def ci(data):
    data=np.array(data)
    if data.ndim>1:
        print('error')
    n_samples = len(data)
    alpha     = 0.95

    mean_val = np.nanmean(data)
    sem_val  = np.nanstd(data)/np.sqrt(len(data)-1)
    ci       = stats.t.interval(alpha, len(data)-1, loc=mean_val, scale=sem_val)

    cilen = np.max(ci) - np.mean(ci)
    
    return cilen
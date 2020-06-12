import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import os
from utils import *
from inspect import currentframe
from utils import make_dir
import math

def plot_all(y_test,y_test_predicted,out,data_name,model='!model!',target_name=None):
    if type(target_name) == type(None):
        target_name = ['!target_name!'] * y_test.shape[1]
    #plot decoding result
    corr,R2,mae,y_test_predicted_smooth,corr_smooth,R2_smooth,mae_smooth=calc(y_test,y_test_predicted)


    plt.figure(figsize=[12,4])
    #from IPython.core.debugger import Pdb; Pdb().set_trace()
    for k in range(y_test.shape[1]):
        plt.subplot(1,y_test.shape[1],k+1)
        plt.plot(y_test[:,k],label='true')
        plt.plot(y_test_predicted[:,k],label='pred')
        plt.text(10,4.5,'corr : {}'.format(corr[k]))
        plt.text(10,4,'R2 : {}'.format(R2[k]))
        plt.text(10,3.5,'mae : {}'.format(mae[k]))
        plt.ylim([-5,5])
        #plt.text(10,8.5,'corr : {}'.format(corr[k]))
        #plt.text(10,8,'R2 : {}'.format(R2[k]))
        #plt.text(10,7.5,'mae : {}'.format(mae[k]))
        #plt.ylim([0,9])
        plt.title('{} by {}'.format(target_name[k],model))

    plt.legend()
    #plt.legend(bbox_to_anchor=(1.05, 1), loc='upper left')

    make_dir('{}/figure_{}'.format(out,model))
    plt.savefig('{}/figure_{}/{}_{}.pdf'.format(out,model,model,data_name))
    plt.close()
    
    
    plt.figure(figsize=[12,4])    
    for k in range(y_test.shape[1]):
        plt.subplot(1,y_test.shape[1],k+1)
        plt.plot(y_test[:,k],label='true')
        plt.plot(y_test_predicted_smooth[:,k],label='pred')
        plt.text(10,4.5,'corr : {}'.format(corr_smooth[k]))
        plt.text(10,4,'R2 : {}'.format(R2_smooth[k]))
        plt.text(10,3.5,'mae : {}'.format(mae_smooth[k]))
        plt.ylim([-5,5])
        #plt.text(10,8.5,'corr : {}'.format(corr_smooth[k]))
        #plt.text(10,8,'R2 : {}'.format(R2_smooth[k]))
        #plt.text(10,7.5,'mae : {}'.format(mae_smooth[k]))
        #plt.ylim([0,9])
        plt.title('{} by {}'.format(target_name[k],model))

    plt.legend()
    #plt.legend(bbox_to_anchor=(1.05, 1), loc='upper left')
    make_dir('{}/figure_{}'.format(out,model))
    plt.savefig('{}/figure_{}/{}_{}_smooth.pdf'.format(out,model,model,data_name))
    plt.close()
    
def data_load(datalist):
    #load data from excel file
    
    # load
    a=['position' in dname for dname in datalist]
    a=pd.ExcelFile(datalist[a.index(True)])
    position_df=a.parse()

    a=['trace' in dname for dname in datalist]
    a=pd.ExcelFile(datalist[a.index(True)])
    trace_df=a.parse(header=None)

    a=['trace' in dname for dname in datalist]
    a=pd.ExcelFile(datalist[a.index(True)])
    spike_df=a.parse(header=None)
    
    a=['info' in dname for dname in datalist]
    a=pd.ExcelFile(datalist[a.index(True)])
    info_df=a.parse(header=None)

    trace=trace_df.values[:,1:]
    spike=spike_df.values
    info=info_df.values
    position=position_df.values[3:,1:3]
    x_position=position[:,0]
    y_position=position[:,1]

    t=trace_df.values[:,0]
    n_neuron=trace.shape[1]
    n_time=len(t)

    #estimate firing rate
    firing_rate=estimate_firing_rate(spike)

    #if length of position and neural activity are different, I arrange the lengths
    if (not len(x_position)==n_time) or (not len(x_position)==len(spike)):
        n_time=np.min([len(x_position),len(trace),len(spike)])
        trace=trace[:n_time,:]
        spike=spike[:n_time,:]
        firing_rate=firing_rate[:n_time,:]
        x_position=x_position[:n_time]
        y_position=y_position[:n_time]
        position=position[:n_time]

    
    # smoothing of trace
    ker=np.ones(10)/10.0
    trace_smooth=np.zeros(trace.shape)
    for k in range(n_neuron):
        trace_smooth[:,k]=np.convolve(trace[:,k],ker,mode='same')

    return info, trace,spike,position,x_position,y_position,n_neuron,n_time,firing_rate,trace_smooth
 
def data_load3(datalist):
    #load data from excel file
    
    # load
    a=['position' in dname for dname in datalist]
    a=pd.ExcelFile(datalist[a.index(True)])
    position_df=a.parse()

    a=['trace' in dname for dname in datalist]
    a=pd.ExcelFile(datalist[a.index(True)])
    trace_df=a.parse(header=None)
    
    #a=['negacon' in dname for dname in datalist]
    #a=pd.ExcelFile(datalist[a.index(True)])
    #trace_df=a.parse(header=None)

    a=['trace' in dname for dname in datalist]
    a=pd.ExcelFile(datalist[a.index(True)])
    spike_df=a.parse(header=None)
    
    #a=['negacon' in dname for dname in datalist]
    #a=pd.ExcelFile(datalist[a.index(True)])
    #spike_df=a.parse(header=None)
    
    a=['Spatial' in dname for dname in datalist] #if you wanna change the deletion order, change the file name. (e.g., 'Spatial' to 'speed')
    a=pd.ExcelFile(datalist[a.index(True)])
    info_df=a.parse(header=None)
    
    #For position
    position=position_df.values[3:,1:3]
    #For velocity
    #position=position_df.values
    spike=spike_df.values
    trace=spike

    info=info_df.values
    x_position=position[:,0]
    y_position=position[:,1]

    t=trace_df.values[:,0]
    n_neuron=trace.shape[1]
    n_time=len(t)

    #estimate firing rate
    firing_rate=estimate_firing_rate(spike)

    #if length of position and neural activity are different, I arrange the lengths
    if (not len(x_position)==n_time) or (not len(x_position)==len(spike)):
        n_time=np.min([len(x_position),len(spike)])
        trace=trace[:n_time,:]
        spike=spike[:n_time,:]
        firing_rate=firing_rate[:n_time,:]
        x_position=x_position[:n_time]
        y_position=y_position[:n_time]
        position=position[:n_time]
   
    # smoothing of trace
    ker=np.ones(10)/10.0
    trace_smooth=np.zeros(trace.shape)
    for k in range(n_neuron):
        trace_smooth[:,k]=np.convolve(trace[:,k],ker,mode='same')

    return info,trace,spike,position,x_position,y_position,n_neuron,n_time,firing_rate,trace_smooth

def data_load4(datalist):
    #load data from excel file
    
    # load
    a=['position' in dname for dname in datalist]
    a=pd.ExcelFile(datalist[a.index(True)])
    position_df=a.parse()

    a=['trace' in dname for dname in datalist]
    a=pd.ExcelFile(datalist[a.index(True)])
    trace_df=a.parse(header=None)
    
    #a=['negacon' in dname for dname in datalist]
    #a=pd.ExcelFile(datalist[a.index(True)])
    #trace_df=a.parse(header=None)

    a=['trace' in dname for dname in datalist]
    a=pd.ExcelFile(datalist[a.index(True)])
    spike_df=a.parse(header=None)
    
    #a=['negacon' in dname for dname in datalist]
    #a=pd.ExcelFile(datalist[a.index(True)])
    #spike_df=a.parse(header=None)
    
    a=['info' in dname for dname in datalist]
    a=pd.ExcelFile(datalist[a.index(True)])
    info_df=a.parse(header=None)
    
    #For position
    position=position_df.values[0:,0:2]
    #For velocity
    #position=position_df.values
    spike=spike_df.values
    trace=spike

    info=info_df.values
    #from IPython.core.debugger import Pdb; Pdb().set_trace()
    x_position=position[:,0]
    y_position=position[:,1]

    t=trace_df.values[:,0]
    n_neuron=trace.shape[1]
    n_time=len(t)

    #estimate firing rate
    firing_rate=estimate_firing_rate(spike)

    #if length of position and neural activity are different, I arrange the lengths
    if (not len(x_position)==n_time) or (not len(x_position)==len(spike)):
        n_time=np.min([len(x_position),len(spike)])
        trace=trace[:n_time,:]
        spike=spike[:n_time,:]
        firing_rate=firing_rate[:n_time,:]
        x_position=x_position[:n_time]
        y_position=y_position[:n_time]
        position=position[:n_time]
   
    # smoothing of trace
    ker=np.ones(10)/10.0
    trace_smooth=np.zeros(trace.shape)
    for k in range(n_neuron):
        trace_smooth[:,k]=np.convolve(trace[:,k],ker,mode='same')

    return info,trace,spike,position,x_position,y_position,n_neuron,n_time,firing_rate,trace_smooth

def estimate_firing_rate(spike):
    #estimate firing rate from spike
    ker=gauss(np.linspace(-3,3,100),m=0,sig=0.2)

    firing_rate=np.zeros(spike.shape)
    for k in range(spike.shape[1]):
        firing_rate[:,k]=np.convolve(spike[:,k],ker,mode='same')
    return firing_rate

def gauss(x,m=0,sig=1):
    return 1.0/np.sqrt(2*np.pi*sig**2) * np.exp(-(x-m)**2 / 2/sig**2)


def calc(y_test,y_test_predicted,n=20):
    #calculate correlation, R2, and mae by using original predicted value and smoothed predicted value
    #mae was changed to MAE on July 27, 2018.
    corr=[np.corrcoef(y_test_predicted[:,k],y_test[:,k])[0,1] for k in range(y_test.shape[1])]
    R2=get_R2(y_test,y_test_predicted)

    y_test_predicted_smooth=np.vstack([np.convolve(y_test_predicted[:,k],1.0*np.ones(n)/n,mode='same') for k in range(y_test.shape[1])]).T

    corr_smooth=[np.corrcoef(y_test_predicted_smooth[:,k],y_test[:,k])[0,1] for k in range(y_test.shape[1])]
    R2_smooth=get_R2(y_test,y_test_predicted_smooth)
    
    tmp=np.absolute(y_test_predicted-y_test)
    tmp_smooth=np.absolute(y_test_predicted_smooth-y_test)
    
    tmp1=np.absolute(tmp-2.0*math.pi)
    tmp1_smooth=np.absolute(tmp_smooth-2.0*math.pi)
    
    tmp2=np.minimum(tmp1,tmp)
    tmp2_smooth=np.minimum(tmp1_smooth,tmp_smooth)
    
    mae=np.mean(tmp2,axis=0)
    #mae=np.mean(np.absolute(y_test_predicted-y_test),axis=0)
    mae_smooth=np.mean(tmp2_smooth,axis=0)
    #mae_smooth=np.mean(np.absolute(y_test_predicted_smooth-y_test),axis=0)
    
    return corr,R2,mae,y_test_predicted_smooth,corr_smooth,R2_smooth,mae_smooth

def neural_corr_quadrant(neural_data,position,use_set,n_discrete = 2):
    # calculate correlation between neural activity and position
    
    # neural_data : neural activity used in this function, such as firing rate
    # position : position trace of mouse
    # use_set : which timing are used to calculating correlation
    
    n_neuron=neural_data.shape[1]

    # discretization
    position_=position/(200/n_discrete)
    p=(position_).astype(np.int32)
    position_discrete=p[:,0]+p[:,1]*n_discrete
    
    # calculate correlation between position and neural_data
    score_all=[]
    for neuron_k in range(n_neuron):
        score=0
        for k in range(4):
            _p=(position_discrete==k)+0
            corr=np.corrcoef(_p[use_set],neural_data[use_set,neuron_k])[0,1]
            score+=np.abs(corr)#score of one certain neuron
        score_all.append(score)
    score_all=np.array(score_all)
    score_all[np.isnan(score_all)]=0

    return score_all

def neuron_thresholding(neural_data,position,use_set,rate,n_discrete = 2):
    """
    calculate correlation (or score) between neural_data and position using training data
    and thresholding neuron by the correlation
    
    Parameters
        neural_data : neural activity used in this function, such as firing rate
        position    : position trace of mouse
        use_set     : which timing are used to calculating correlation
        rate        : the rate of the number of neurons remained (if there are 100 neurons and rate = 0.8,
                                                                  80 neurons with high correlation are used)
        n_discrete  : how many segments are used for calculating correlation. if n_discrete is 2, it means we segment the field to 2 ** 2 fields, and if 4, to 4 ** 2 fields.
             
             
    Returns
        neural_data : activity of neurons remained with high correlation
        n_neuron    : number of neurons remained
        corr_th     : threshold of correlation
    """
    
    score_all = neural_corr_quadrant(neural_data,position,use_set,n_discrete)
    
    # how many neurons you remain
    n_neuron=neural_data.shape[1]
    how_many=rate * n_neuron # if you want to set how many neurons are remained, please change this one.
    how_many=int(np.round(how_many))
    print('{} neurons are used'.format(how_many))
    
    # sort and select neurons with high score
    s=np.argsort(score_all)
    neural_data=neural_data[:,s[-how_many:]]
    corr_th=np.min(score_all[s[-how_many:]])
    n_neuron=neural_data.shape[1]
    
    return neural_data,n_neuron,corr_th

def neuron_thresholding2(neural_data,position,use_set,rate,info,info_ind,n_discrete = 2):
    """
    calculate correlation (or score) between neural_data and position using training data
    and thresholding neuron by the correlation
    
    Parameters
        neural_data : neural activity used in this function, such as firing rate
        position    : position trace of mouse
        use_set     : which timing are used to calculating correlation
        rate        : the rate of the number of neurons remained (if there are 100 neurons and rate = 0.8,
                                                                  80 neurons with high correlation are used)
        n_discrete  : how many segments are used for calculating correlation. if n_discrete is 2, it means we segment the field to 2 ** 2 fields, and if 4, to 4 ** 2 fields.
             
             
    Returns
        neural_data : activity of neurons remained with high correlation
        n_neuron    : number of neurons remained
        corr_th     : threshold of correlation
    """
    
    score_all = info[:,info_ind]
    #from IPython.core.debugger import Pdb; Pdb().set_trace()

    # how many neurons you remain
    n_neuron=neural_data.shape[1]
    if rate == 0:
        how_many=n_neuron
        how_many=int(np.round(how_many))
        realnum=how_many
    else:
        how_many=rate * n_neuron # if you want to set how many neurons are remained, please change this one.
        how_many=int(np.round(how_many))
        realnum=n_neuron-how_many
    
    print('{} neurons are used'.format(realnum))
    
    # sort and select neurons with high score
    #if info_ind==2:
    s=np.argsort(score_all)[::-1]#from high to low
    #else:
     #   s=np.argsort(score_all)#from low to high
    
    if not rate == 0:
        neural_data=neural_data[:,s[how_many:]]
    #corr_th=np.min(score_all[s[how_many:]])
    n_neuron=neural_data.shape[1]
    
    return neural_data,n_neuron,info_ind

def neuron_thresholding3(neural_data,position,use_set,rate,n_discrete = 2):
    """
    calculate correlation (or score) between neural_data and position using training data
    and thresholding neuron by the correlation
    
    Parameters
        neural_data : neural activity used in this function, such as firing rate
        position    : position trace of mouse
        use_set     : which timing are used to calculating correlation
        rate        : the rate of the number of neurons remained (if there are 100 neurons and rate = 0.8,
                                                                  80 neurons with high correlation are used)
        n_discrete  : how many segments are used for calculating correlation. if n_discrete is 2, it means we segment the field to 2 ** 2 fields, and if 4, to 4 ** 2 fields.
             
             
    Returns
        neural_data : activity of neurons remained with high correlation
        n_neuron    : number of neurons remained
        corr_th     : threshold of correlation
    """

    # how many neurons you remain
    n_neuron=neural_data.shape[1]
    
    how_many=rate * n_neuron # if you want to set how many neurons are remained, please change this one.
    how_many=int(np.round(how_many))
    use_neuron=np.random.permutation(how_many)
    realnum=how_many
    
    print('{} neurons are used'.format(realnum))
    
    if not rate == 0:
        neural_data=neural_data[:,use_neuron]

    n_neuron=neural_data.shape[1]
    
    return neural_data,n_neuron

def velocity(position):
    #calcualte velocity from postion data
    position_actual_cm=position/5.0
    v_cm_s=np.sqrt(np.sum((np.diff(position_actual_cm,axis=0))**2,axis=1)) *3.0
      
    #velocity between t=-1 and t=0 is set as same one between t=0 and t=1
    #velocity between t=end and t=end+1 is set as same one between t=end-1 and t=en
    v_cm_s = np.hstack([[v_cm_s[0]],v_cm_s,[v_cm_s[-1]]])
    
    #v_m(t) is average of (velocity between t-1 and t) and (one between t and t+1)
    v_m=np.convolve(v_cm_s,[0.5,0.5],mode='valid')
    return v_m
 
def v_th(position,th):
    v_m = velocity(position)
    use_time_v=v_m>=th
    plt.plot(v_m)
    print(np.sum(use_time_v))
    
    return use_time_v

def get_spikes_with_history(neural_data,bins_before,bins_after,bins_current=1):
    """
    Function that creates the covariate matrix of neural activity

    Parameters
    ----------
    neural_data: a matrix of size "number of time bins" x "number of neurons"
        the number of spikes in each time bin for each neuron
    bins_before: integer
        How many bins of neural data prior to the output are used for decoding
    bins_after: integer
        How many bins of neural data after the output are used for decoding
    bins_current: 0 or 1, optional, default=1
        Whether to use the concurrent time bin of neural data for decoding

    Returns
    -------
    X: a matrix of size "number of total time bins" x "number of surrounding time bins used for prediction" x "number of neurons"
        For every time bin, there are the firing rates of all neurons from the specified number of time bins before (and after)
    """

    num_examples=neural_data.shape[0] #Number of total time bins we have neural data for
    num_neurons=neural_data.shape[1] #Number of neurons
    surrounding_bins=bins_before+bins_after+bins_current #Number of surrounding time bins used for prediction
    X=np.empty([num_examples,surrounding_bins,num_neurons]) #Initialize covariate matrix with NaNs
    X[:] = np.NaN
    #Loop through each time bin, and collect the spikes occurring in surrounding time bins
    #Note that the first "bins_before" and last "bins_after" rows of X will remain filled with NaNs, since they don't get filled in below.
    #This is because, for example, we cannot collect 10 time bins of spikes before time bin 8
    start_idx=0
    for i in range(num_examples-bins_before-bins_after): #The first bins_before and last bins_after bins don't get filled in
        end_idx=start_idx+surrounding_bins; #The bins of neural data we will be including are between start_idx and end_idx (which will have length "surrounding_bins")
        X[i+bins_before,:,:]=neural_data[start_idx:end_idx,:] #Put neural data from surrounding bins in X, starting at row "bins_before"
        start_idx=start_idx+1;
    return X




########## R-squared (R2) ##########

def get_R2(y_test,y_test_pred):
    
    """
        Function to get R2
        
        Parameters
        ----------
        y_test - the true outputs (a matrix of size number of examples x number of outputs)
        y_test_pred - the predicted outputs (a matrix of size number of examples x number of outputs)
        
        Returns
        -------
        R2_array: An array of R2s for each output
        """
    
    R2_list=[] #Initialize a list that will contain the R2s for all the outputs
    for i in range(y_test.shape[1]): #Loop through outputs
        #Compute R2 for each output
        y_mean=np.mean(y_test[:,i])
        R2=1-np.sum((y_test_pred[:,i]-y_test[:,i])**2)/np.sum((y_test[:,i]-y_mean)**2)
        R2_list.append(R2) #Append R2 of this output to the list
    R2_array=np.array(R2_list)
    return R2_array #Return an array of R2s




########## Pearson's correlation (rho) ##########

def get_rho(y_test,y_test_pred):
    
    """
        Function to get Pearson's correlation (rho)
        
        Parameters
        ----------
        y_test - the true outputs (a matrix of size number of examples x number of outputs)
        y_test_pred - the predicted outputs (a matrix of size number of examples x number of outputs)
        
        Returns
        -------
        rho_array: An array of rho's for each output
        """
    
    rho_list=[] #Initialize a list that will contain the rhos for all the outputs
    for i in range(y_test.shape[1]): #Loop through outputs
        #Compute rho for each output
        y_mean=np.mean(y_test[:,i])
        rho=np.corrcoef(y_test[:,i].T,y_test_pred[:,i].T)[0,1]
        rho_list.append(rho) #Append rho of this output to the list
    rho_array=np.array(rho_list)
    return rho_array #Return the array of rhos



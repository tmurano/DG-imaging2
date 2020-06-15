clear all; close all; clc;



load TM_Data.mat % if you want to make negative control, load TM_Data_d as shuffled data
TM = {TM_Data_arm TM_Data_dec};



Results = [];



for Type = 1:2 % forced arm / decision period
    
    
    RES = []; % Decoding accuracy
    
    
    for MouseID = 1:11    
        
        Data = TM{Type}{MouseID}; 
        [x CELL] = size(Data);
        X = Data(:,1:CELL-1); % Event rate data
        Y = Data(:,CELL); % LR choices (=0 or 1)
        
        rng(1) % for reproductibity
        SVM_Mdl = fitcsvm(X,Y,'Standardize',true,'KernelScale','auto'); % Support Vector Machine
        cSVM_Mdl = crossval(SVM_Mdl,'KFold',25); % 25-fold Cross Validation
        RES = [RES; 1 - kfoldLoss(cSVM_Mdl)]; % Decoding accuracy
        
    end
    
    
    Results = [Results RES];
    
  
end



save Decoding_Results.mat Results -v7.3;



%%%%%% end of program %%%%%%
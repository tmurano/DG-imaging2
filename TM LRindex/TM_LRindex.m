clear all; close all; clc; % This program is for calculating 'LR index' of all neurons.

  

% MouseID = {'WT_m17' 'WT_m28' 'WT_m29' 'WT_m2' 'WT_m5' 'WT_m59' 'WT_rn3'...
%    'CaMK_m19' 'CaMK_m22' 'CaMK_m30' 'CaMK_rn1'};
 
       
       

load('TM_Data.mat'); % if you want to make shuffled control, load TM_Data_d.mat file

LRindex_arm = [];   
LRindex_dec = []; 
for MouseID = 1:11  
    
    LRindex_arm{MouseID} = LRindex(TM_Data_arm{MouseID});  
    LRindex_dec{MouseID} = LRindex(TM_Data_dec{MouseID});       
     
end 




% save datasets
LRindex_WildType = [];
LRindex_aCaMKII = []; 
for MouseID = 1:11 
    
    if MouseID == 8 || MouseID == 9 || MouseID == 10 || MouseID == 11   
        LRindex_aCaMKII = [LRindex_aCaMKII; [LRindex_arm{MouseID}' LRindex_dec{MouseID}']];
    else
        LRindex_WildType = [LRindex_WildType; [LRindex_arm{MouseID}' LRindex_dec{MouseID}']];
    end    

end



save LRindex.mat LRindex_WildType LRindex_aCaMKII -v7.3;



%%%%%% end of program %%%%%%
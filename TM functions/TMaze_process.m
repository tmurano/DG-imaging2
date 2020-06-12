clear all; close all; clc;



TM_Data_arm = []; TM_Data_dec = []; 



for MouseID = 1:11

    

    FR_arm = []; FR_dec = [];   
    
    
    
for Day = 1:5
    
    
    
    %%%%%%%%%% load and resize data %%%%%%%%%%
    
    
    
    f = MouseFiles(MouseID, Day);    
    Ca = xlsread(strcat(f{1}, '.xlsx'));  % load Ca event data
    Pos = xlsread(strcat(f{2}, '.xlsx')); % load Mouse Position data
    
    
    
    % Skip f-frame (double count of position)
    x = length(Pos);   
    Pos1 = [];
    for i = 7:x % skip first 6frames (TTL signal delay between nVista system and TM behavioral system)
        if Pos(i-1, 1) == Pos(i, 1)
            Pos1 = Pos1;
        else
            Pos1 = [Pos1; Pos(i,2:3)];
        end
    end
    Pos1; % mouse XY position
    
    
    
    % Align the length of data    
    time_Ca = length(Ca); 
    time_Pos = length(Pos1);    
    time = min(time_Ca,time_Pos);    
    Spike = Ca(1:time,:); % Aligned Ca event data
    Pos = Pos1(1:time,:); % Aligned Position data 
    
    
 
    % Gaussian filtering
    z = Spike(:,:);
    window = 10;
    Spike = smoothdata(z,'gaussian',window);


        
    % Generation of Shuffled Ca trace Data 
    % Spike = Shuff(Spike);
     
    
    
    %%%%%%%%%% Mouse Position %%%%%%%%%%     

    % correct the camera misalighment
    x1 = (max(Pos(:,1)) + min(Pos(:,1)))/2 - 70;
    x2 = (max(Pos(:,2)) + min(Pos(:,2)))/2 - 50;
    Pos = [Pos(:,1)-x1 Pos(:,2)-x2]/2.5; % convert from pixel to cm
     
    
        
    %%%%%%%%%% Define period and answer %%%%%%%%%% 
        
    % Define periods % m-file: TmazePeriod.m
    f = TmazePeriod(Pos);    
    Arm = f{1}; % 5sec(15frames) post decision @ forced arm period    
    Dec = f{2}; % 5sec pre decision @ decision period
                
    % Define Correct/Error (or Left/Right)  
    g = MouseChoice(MouseID, Day); 
    LR_arm = g{1}; LR_dec = g{2}; 
    
    
        
    %%%%%%%%%% Extract Ca event during forced arm/decision period %%%%%%%%%% 
    
    arm = []; dec = []; 
    for k = 1:10
        arm = [arm; sum(Spike(Arm{k},:))/5]; %Event Rate hz/sec    
        dec = [dec; sum(Spike(Dec{k},:))/5]; %Event Rate hz/sec    
    end
    % 10 Trial x CELL % right column: 0 or 1 (=L or R)
    FR_arm = [FR_arm; arm LR_arm']; 
    FR_dec = [FR_dec; dec LR_dec']; 
    
          
    
end



TM_Data_arm{MouseID} = FR_arm; % Event rate in each trial, 50 trials x CELL. % right column: 0 or 1 (=L or R)


          
end



TM_Data_arm; 
TM_Data_dec; 


 
save TM_Data.mat TM_Data_arm TM_Data_dec -v7.3;
% save TM_Data_d.mat TM_Data_arm TM_Data_dec -v7.3; % to produce shuffled data



%%%%%% end of program %%%%%%
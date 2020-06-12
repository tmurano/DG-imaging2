clear all; close all; clc;



% Define Mouse ID
MouseID = {'m27' 'm29' 'm32' 'm44' 'm45' 'm46' 'rn3'... % WildType n=7
    'm19' 'm20' 'm22' 'm30' 'rn1'}; % CaMKII-HKO n=5



% Specify File Name / Mouse behaviour (X-Y position in OF)
FileName_position = {'081117 OF M27-n1_S1 position'... % WildType 7
    '092217 OF M29-n1_S1 position'...
    '092717 OF M32-n1_S1 position'...
    'M44_042718_position'...
    'M45_042718_position'...
    'M46_042718_position'... 
    'RN3_WT_position'...
    '091317 OF M19-n1_S1 position'... % CaMKII-HKO 5
    '091317 OF M20-n1_S1 position'...
    '090817 OF M22-n1_S1 position'...
    '092217 OF M30-n1_S1 position'...
    'RN1_KO_position'};



% Specify File Name / Ca imaging Data (binary processed)
FileName_Ca_events = {'081117_M27_Ca_event_8_0.5_selected_traces'... % WildType
    '092217_M29_Ca_events_8_0.5_selected_traces'...
    '092717_M32_Ca_events_8_0.5_selected_traces'...
    'M44_042718_Ca_spikes_selected_traces'...
    'M45_042718_Ca_spikes_selected_traces'...
    'M46_042718_Ca_spikes_selected_traces'...
    'RN3_WT_Ca_spikes_selected_traces'...
    '091317_M19_Ca_events_8_0.5_selected'... % CaMKII-HKO
    '091317_M20_Ca_events_8_0.5_selected'...
    '090817_M22_Ca_events_8_0.5_selected'...
    '092217_M30_Ca_events_8_0.5_selected'...
    'RN1_KO_Ca_spikes_selected_traces'}; 



% Information content of position, speed, and motion direction for WildType
% and aCaMKII mouse
PosInf_WildType = [];
SpInf_WildType = [];
DirInf_WildType = [];
PosInf_aCaMKII = [];
SpInf_aCaMKII = [];
DirInf_aCaMKII = [];

 

for ID = 1:12
    
    
    
    % Read Files
    Position = xlsread(strcat(FileName_position{ID},'.xlsx')); % read mouse X-Y position file        
    Ca_event = xlsread(strcat(FileName_Ca_events{ID},'.xlsx')); % read Ca transient file (0/1 binary)(Sampling rate is 3hz)    
    
    
    
    % Resize Data
    Position = Position(:,2:3); Position(1:3,:) = []; % skip first 3frames(=1sec) beacuse of delay of TTL signal
    [time_p x] = size(Position);
    [time_c x] = size(Ca_event);  
    time = min(time_p,time_c);
    Position = Position(1:time,:); % Align the length of vector
    Ca_event = Ca_event(1:time,:);       
    
    
    
    % Generation of Shuffled Data 
     Ca_event = Shuff(Ca_event);
    
    
    
    % Convertion of X-Y coordinate: (X,Y)=[1:200, 1:200] -> (X,Y)=[-1:1 -1:1]
    X = (Position(:,1)-100)/100;  
    Y = (100-Position(:,2))/100;  
    
    
    
    
    % Alignment of the center: to correct the camera misalighment
    X = X - (max(X) + min(X))/2; 
    Y = Y - (max(Y) + min(Y))/2;
    Coordinate = [X Y];
     
     
    
    % Calculating the Mouse Moving Speed
    % The Moving Speed was defined as the distance travelled between 1 sec before and after a given time point 
    Speed = [];
    for T = 1:time;        
        D = 0;
        for t = -3:3 % 1 sec before and after a given time point (3frames = 1sec)
            if T+t-1 <= 0 || T+t > time
                D = D;
            else
                x = Position(T+t-1,1)/5 - Position(T+t,1)/5;
                y = Position(T+t-1,2)/5 - Position(T+t,2)/5;
                d = sqrt(x^2+y^2);
                D = D + d;
            end
        end
        Speed(T) = D * 3/7;
    end
    Speed; %  Mouse Moving Speed (cm/sec)
     
    
    
    % Calculating the Motion Direction     
    % The motion direction (in radians) was computed from the direction of
    % change in two subsequent mouse positions (1 sec before and after a given time point).
    % North was defined as 0 radians; west was defined from 0 to π radians, and east was defined from 0 to –π radians.
    Direction = [];
    for i = 1:length(X)
        if i <= 3 || i >= length(X)-3 % 1 sec before and after a given time point (3frames = 1sec)
            Direction(i) = 0;
        else
            Direction(i) = atan2(Y(i+3)-Y(i-3), X(i+3)-X(i-3)); %defining head direction (-pi radian ~ +pi radian)
        end
    end 
    Direction; 
    
    
    
    % Calculating Spatial, Speed, and Direction Information 
    InfoCont_Pos(Coordinate,Ca_event,Speed);
    InfoCont_Sp(Speed,Ca_event);
    InfoCont_Dir(Direction,Ca_event,Speed); 
    
    
    
    if ID == 8 ||ID == 9 ||ID == 10 || ID == 11 || ID == 12 % Information content of all neurons in aCaMKII mouse
        PosInf_aCaMKII = [PosInf_aCaMKII InfoCont_Pos(Coordinate,Ca_event,Speed)];    
        SpInf_aCaMKII =  [SpInf_aCaMKII  InfoCont_Sp(Speed,Ca_event)];   
        DirInf_aCaMKII = [DirInf_aCaMKII InfoCont_Dir(Direction,Ca_event,Speed)]; 
    else % Information content of all neurons in WildType mouse
        PosInf_WildType = [PosInf_WildType InfoCont_Pos(Coordinate,Ca_event,Speed)];    
        SpInf_WildType =  [SpInf_WildType  InfoCont_Sp(Speed,Ca_event)];   
        DirInf_WildType = [DirInf_WildType InfoCont_Dir(Direction,Ca_event,Speed)]; 
    end
    
    
    
end

         

PosInf_WildType;           
SpInf_WildType;         
DirInf_WildType;
PosInf_aCaMKII;
SpInf_aCaMKII;       
DirInf_aCaMKII;



save InfoCont_all_data.mat PosInf_WildType SpInf_WildType DirInf_WildType...
    PosInf_aCaMKII SpInf_aCaMKII DirInf_aCaMKII -v7.3



%%%%%% end of program %%%%%%
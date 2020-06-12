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



% Population Vector Overlap
PVO_Pos = []; 
    


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
    
    
    
    % Velocity filtering (1cm/sec filtering, see Supplementary Fig. 8 and Supplementary Notes)
    Ca_event1 = [];
    Coordinate1 = []; 
    for i = 1:time  
        if Speed(i) >= 1 % when above 1cm/sec, included
            Ca_event1 = [Ca_event1; Ca_event(i,:)];
            Coordinate1 = [Coordinate1; Coordinate(i,:)]; 
        end
    end
    Ca_event1;
    Coordinate1; 
    
    
    
    % Calculating Population Vector Overlap among subareas in Open Field (for
    % deatils see Materials and Methods section.
    PVO_11 =  []; PVO_10 =  []; PVO_01 =  []; PVO_00 =  []; 
    for j = 1:length(Ca_event)        
        if X(j)>0 && Y(j)>0 
            PVO_11 =  [PVO_11; Ca_event(j,:)];
        elseif      X(j)>0 && Y(j)<0      
            PVO_10 =  [PVO_10; Ca_event(j,:)];     
        elseif      X(j)<0 && Y(j)>0           
            PVO_01 =  [PVO_01; Ca_event(j,:)];
        else
            PVO_00 =  [PVO_00; Ca_event(j,:)];
        end        
    end    
    PV = [mean(PVO_11); mean(PVO_10); mean(PVO_01); mean(PVO_00)];
    
    
    
    PVO = [];
    for l = 1:4
        for m = 1:4
            PVO(l,m) = sum(PV(l,:) .* PV(m,:)) / sqrt(sum(PV(l,:).*PV(l,:)) * sum(PV(m,:).*PV(m,:)));
        end
    end    
    PVO_Pos{ID} = PVO;
    
    
    
end



PVO_mean = [];
for p = 1:12
    
    PVO = PVO_Pos{p};
    imagesc(PVO); colorbar; caxis([0.5 1]); axis off; % visualizing PVO matrix
    saveas(gcf,strcat('PVO_Pos_',MouseID{p},'.png')); 
    PVO_mean(p) = mean([PVO(1,2) PVO(1,3) PVO(1,4) PVO(2,3) PVO(2,4) PVO(3,4)]); % Calculating mean PVO for each mouse
    
end
PVO_mean;
% xlswrite('PVO_mean.xlsx', PVO_mean);




%%%%%% end of program %%%%%%
function f = InfoCont_Pos(Coordinate,Ca_event,Speed)



Spatial_Information = [];



Coordinate; % X-Y Coordinate: range[-1:1,-1:1]
Ca_event; % Ca transient (0/1 binary)
Speed; % Mouse Moving Speed for velocity filtering


  
[time,CELL] = size(Ca_event); % recording time and number of cells recorded



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



[time,CELL] = size(Ca_event1); % Ca transient data after velocity filtering



% Calculating Spatial Information (bits/ca transients)
% for details see materials and methods, section "Statistical analysis of
% spatial, speed and direction information"

f1 = []; f2 = []; f3 = []; f4 = [];
Ca1 = []; Ca2 = []; Ca3 = []; Ca4 = [];



for i = 1:time
    
    if Coordinate1(i,1)>=0 && Coordinate1(i,2)>=0 % Field 1
        f1 = [f1 1];
        Ca1 = [Ca1; Ca_event1(i,:)];
        
    elseif Coordinate1(i,1)<0 && Coordinate1(i,2)>=0 % Field 2
        f2 = [f2 1];
        Ca2 = [Ca2; Ca_event1(i,:)];
        
    elseif Coordinate1(i,1)<0 && Coordinate1(i,2)<0 % Field 3
        f3 = [f3 1];
        Ca3 = [Ca3; Ca_event1(i,:)];
        
    else % Coordinate(i,1)>=0 && Coordinate(i,2)<0 % Field 4
        f4 = [f4 1];
        Ca4 = [Ca4; Ca_event1(i,:)];
        
    end
    
end


      
r1 = length(f1)/time;
r2 = length(f2)/time;
r3 = length(f3)/time;
r4 = length(f4)/time;



p = sum(Ca_event1)/time;
if length(f1) == 0
    p1 = zeros(1,CELL);
else    
    p1 = sum(Ca1)/length(f1);
end
if length(f2) == 0
    p2 = zeros(1,CELL);
else    
    p2 = sum(Ca2)/length(f2);
end
if length(f3) == 0
    p3 = zeros(1,CELL);
else    
    p3 = sum(Ca3)/length(f3);
end
if length(f4) == 0
    p4 = zeros(1,CELL);
else    
    p4 = sum(Ca4)/length(f4);
end



for i = 1:CELL
                
    if p1(i)/p(i) == 0 % Information at Filed 1
        Inf1 = 0;              
    else
        Inf1 = r1 * (p1(i)/p(i)) * log2(p1(i)/p(i));
    end
    
    if p2(i)/p(i) == 0 % Information at Filed 2
        Inf2 = 0;              
    else
        Inf2 = r2 * (p2(i)/p(i)) * log2(p2(i)/p(i));
    end
    
    if p3(i)/p(i) == 0 % Information at Filed 3
        Inf3 = 0;              
    else
        Inf3 = r3 * (p3(i)/p(i)) * log2(p3(i)/p(i));
    end
    
    if p4(i)/p(i) == 0 % Information at Filed 4
        Inf4 = 0;              
    else
        Inf4 = r4 * (p4(i)/p(i)) * log2(p4(i)/p(i));
    end    
    
    Spatial_Information(i) = Inf1 + Inf2 + Inf3 + Inf4;
        
end



Spatial_Information(isnan(Spatial_Information)==1) = 0; 
f = Spatial_Information;



end
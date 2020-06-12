function f = InfoCont_Sp(Speed,Ca_event);



Speed_Information = [];



Speed; % Mouse Moving Speed (cm/sec)
Ca_event; % Ca transient (0/1 binary)



[time,CELL] = size(Ca_event);



% Calculating Speed Information (bits/ca transients)
% for details see materials and methods, section "Statistical analysis of
% spatial, speed and direction information"

f1 = []; f2 = [];
Ca1 = []; Ca2 = [];



for i = 1:time
    
    if Speed(i)>1 % Run
        f1 = [f1 1];
        Ca1 = [Ca1; Ca_event(i,:)];
        
    else %Speed(i)<=0 % Stop
        f2 = [f2 1];
        Ca2 = [Ca2; Ca_event(i,:)];
        
    end
            
end
      


r1 = length(f1)/time;
r2 = length(f2)/time;



p = sum(Ca_event)/time;  
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



for i = 1:CELL
    
    if p1(i)/p(i) == 0 % Information at Running period
        Inf1 = 0;              
    else
        Inf1 = r1 * (p1(i)/p(i)) * log2(p1(i)/p(i));
    end
    
    if p2(i)/p(i) == 0 % Information at Stop period
        Inf2 = 0;              
    else
        Inf2 = r2 * (p2(i)/p(i)) * log2(p2(i)/p(i));
    end
    
    Speed_Information(i) = Inf1 + Inf2;
    
end



Speed_Information(isnan(Speed_Information)==1) = 0;
f = Speed_Information;
    


end
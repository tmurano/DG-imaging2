function f = InfoCont_Dir(Direction,Ca_event,Speed)



Direction_Information = [];



Direction; % Motion Direction (radian)
Ca_event; % Ca transient (0/1 binary)
Speed; % Mouse Moving Speed for velocity filtering


        
[time,CELL] = size(Ca_event); 



% Velocity filtering to remove small movement of mouse
Ca_event1 = [];
Direction1 = []; 
for i = 1:time
    if Speed(i) >= 4 % above 4cm/sec
        Ca_event1 = [Ca_event1; Ca_event(i,:)];
        Direction1 = [Direction1 Direction(i)];  
    end
end
Ca_event1;
Direction1; 
    
    
        
[time,CELL] = size(Ca_event1); 



% Calculating Speed Information (bits/ca transients)
% for details see materials and methods, section "Statistical analysis of
% spatial, speed and direction information"

HD_class = ceil(Direction1*4/pi) + 4; % classifying direction into 8 classes: (-pi to +pi radian) -> (1~8 class)
h = histogram(HD_class);
p = h.Values./sum(h.Values); % probability of head direction(class 1~8) 
  
    
 
for i = 1:CELL  
 
    d = HD_class'.* Ca_event1(:,i); d(find(d==0))=[];    
    d = [d;1;2;3;4;5;6;7;8]; h = histogram(d);     
    r = (h.Values-1)/mean(h.Values-1); % probability of firing (class 1~8)    
    A = p .* r .* log2(r); A(find(isnan(A)==1)) = []; % diretion informatioin
    Direction_Information(i) = sum(A);

end



Direction_Information(isnan(Direction_Information)==1) = 0;
f = Direction_Information;
    


close all;



end
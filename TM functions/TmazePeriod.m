 function f = TmazePeriod(Pos)

 
Pos; % Mouse X-Y Position
x = Pos(:,1); y = Pos(:,2);




Area = []; % define area mouse staying
for i = 1:length(Pos)
    if (x(i)<20 && y(i)<10) || (x(i)>36 && y(i)<10)
        Area(i) = 1; % Side Lane
    elseif y(i) < 10
        Area(i) = 0; % Decision Area
    else        
        Area(i) = -0.5; % Center Area
    end
end 



t = []; a = []; % define the timing of area transition
for i = 1:length(Area)-1
    if Area(i+1) - Area(i) == 1 % Center Entry
        t = [t i]; a = [a 1];              
    elseif Area(i+1) - Area(i) == -1 % Center Exit
        t = [t i]; a = [a -1];                      
    else
        t = t; a = a;
    end
end



for i = 1:length(a)
    if a(i) == -1
        a(i)= 0; a(i+1)= 0; 
        t(i)= 0; t(i+1)= 0; 
    else
        a = a;
        t = t;
    end
end
a(find(a==0)) = [];
t(find(t==0)) = [];



time = length(Area); 



post_Forced = []; pre_Choice = []; 
for i = 1:10       
    post_Forced{i} = [t(i*2-1):t(i*2-1)+14]; % 15frames (=5sec)
    pre_Choice{i} = [t(i*2)-17:t(i*2)-3];
end 



f = {post_Forced pre_Choice}; 



 end
 function f = Shuff(Ca_event)
 
 
Ca_event; % Ca transient data

 
% Generation of Shuffle Data
rng(1); % for Reproducibility
r = randperm(1000); % 1000-fold shuffing



t = ceil(length(Ca_event)/1000); 
R = [];
for i = 1:1000 % 1000-fold Shuffle
    R = [R r(i)*t-(t-1):r(i)*t];
end
R(find(R>length(Ca_event))) = [];
Ca_event = Ca_event(R,:); % Shuffled Ca trace data    
 


f = Ca_event;



 end
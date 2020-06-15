function f = LRindex(X)



[trials CELL] = size(X);



R_l = []; R_r = [];
for i = 1:50
    if X(i,CELL) == 1  
        R_l = [R_l; X(i,1:CELL-1)];
    else      
        R_r = [R_r; X(i,1:CELL-1)];  
    end    
end   
L = mean(R_l); R = mean(R_r);  



LRindex = [];
for i = 1:CELL-1   
    if L(i) == 0 && R(i) == 0
        LRindex(i) = 0;
    elseif L(i) > 0 && R(i) == 0 % LRindex = +∞
        LRindex(i) = pi;
    elseif L(i) == 0 && R(i) > 0 % LRindex = -∞
        LRindex(i) = -pi;
    else
        LRindex(i) = log2(L(i)/R(i)); % definition of LR index
    end    
end

Max = max(LRindex); 
Min = min(LRindex);
LRindex(find(LRindex==pi)) = Max; % fix to maximum
LRindex(find(LRindex==-pi)) = Min; % fix to minimum


    
f = LRindex;



end
 function [N] = normalizeValues(I)
    s= std(I);
    m= mean(I);
    N= (I-m)/s ;
end

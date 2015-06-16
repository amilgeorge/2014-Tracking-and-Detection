function [J] = bilateralFilter(I,sigmad,sigmar)


% padrows=floor(3*sigmad/2);
% padcols=floor(3*sigmad/2);
% 
% if(strcmp(border,'mirror')==1)
% paddedI=padarray(I,[padrows padcols],'symmetric');
% elseif(strcmp(border,'clamp')==1)
% paddedI=padarray(I,[padrows padcols],'replicate');   
% else
% paddedI=padarray(I,[padrows padcols]);  
% end
I=double(I);
rowsI=size(I,1);
colsI=size(I,2);

for i=1:rowsI
    for j=1:colsI
        K(i,j) = getBfilterdPixelVal(I,i,j,sigmad,sigmar);
    end
end
J=K;
end

function [pixelVal] = getBfilterdPixelVal(I,x,y,sigmad,sigmar)

sizex=3*sigmad;
sizey=3*sigmad;


midx=(sizex+1)/2;
midy=(sizey+1)/2;
N=0;
htemp=0;
for i=1:sizex
    for j=1:sizey
        kx=i-midx;
        ky=j-midy;
        c=exp((-1/2)*(sqrt(kx^2+ky^2)/sigmad)^2);% distance fn
        neigbourPixelVal=getPixelVal(x+kx,y+ky,I);
        currentPixelVal=getPixelVal(x,y,I);
        s=exp((-1/2)*(sqrt((neigbourPixelVal-currentPixelVal)^2)/sigmar)^2);
        htemp=htemp+(neigbourPixelVal*c*s);
        N=N+(c*s);
    end
end


pixelVal=htemp/N;


end

function [val] = getPixelVal(x,y,I)
rowsI=size(I,1);
colsI=size(I,2);
if(x<1||x>rowsI||y<1||y>colsI)
    val=double(0);
else
    val=I(x,y);
end

end

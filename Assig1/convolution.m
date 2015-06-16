function [J] = convolution(I,H,border)
transposedKernal=rot90(H,2);
%disp(transposedKernal);
padrows=floor(size(transposedKernal,1)/2);
padcols=floor(size(transposedKernal,2)/2);

if(strcmp(border,'mirror')==1)
paddedI=padarray(I,[padrows padcols],'symmetric');
elseif(strcmp(border,'clamp')==1)
paddedI=padarray(I,[padrows padcols],'replicate');   
else
paddedI=padarray(I,[padrows padcols]);  
end

rowsI=size(I,1);
colsI=size(I,2);

for i=1:rowsI
    for j=1:colsI
        K(i,j)=getCorrPixelValue(i+padrows,j+padcols,paddedI,transposedKernal);
    end
end

J=K;
end

function [val] = getCorrPixelValue(x,y,I,kernal)
rowsH=size(kernal,1);
colsH=size(kernal,2);
midHx=idivide(int32(rowsH), int32(2), 'floor') +1;
midHy=idivide(int32(colsH),int32( 2), 'floor') +1;
sum=double(0);
for i=1:rowsH
    for j=1:colsH

    sum =sum + kernal(i,j)*double(getPixelVal((x+(-midHx+i)),(y+(-midHy+j)),I));
    end
end
if(sum>0)
    if(sum>255)
        val=uint8(255);
    else
    val=uint8(sum);
    end
else
    val=0;
end
end

function [val] = getPixelVal(x,y,I)
rowsI=size(I,1);
colsI=size(I,2);
if(x<1||x>rowsI||y<1||y>colsI)
    val=0;
else
    val=I(x,y);
end

end
Input = imread('lena.gif');
I=double(Input);

s0=1.5 ;
k=1.2 ;

for i=1:5
    s=s0*(k^(i-1));
    scale_array(i)=s;
end



logImagesMatrix=zeros(size(I,1),size(I,2),size(scale_array,2));

for i=1:5
   logKernelForScalei= scale_array(i)*scale_array(i)* fspecial('log',fix(6*scale_array(i)), scale_array(i));
    logImagesMatrix(:,:,i)= imfilter(I,logKernelForScalei);
end


constant_factor=0.06 ;
threshold_h=1500 ;

harrisImagesMatrix=zeros(size(I,1),size(I,2),size(scale_array,2));

for i=1:5
        L = multiscale_harris(I,s0,i-1,k, constant_factor,threshold_h);
        harrisImagesMatrix(:,:,i)=L ;
end

corners=zeros(size(I,1),size(I,2),size(scale_array,2));
threashold_l=10;

for i=1:5
        [row,column]=find(harrisImagesMatrix(:,:,i));
        for m=1:size(row)
                logValue=logImagesMatrix(row(m),column(m),i);
                if(i>1 && i < size(scale_array,2))
                    logValuePre=logImagesMatrix(row(m),column(m),i-1);
                    logValueNext=logImagesMatrix(row(m),column(m),i+1);
                    if(logValue > logValuePre && logValue > logValueNext && logValue > threashold_l)
                        corners(row(m),column(m),i)=1 ; 
                    end
                elseif(i==1) 
                        logValueNext=logImagesMatrix(row(m),column(m),i+1);
                        if(logValue > logValueNext && logValue > threashold_l)
                             corners(row(m),column(m),i)=1 ; 
                        end 
                elseif(i ==size(scale_array,2))
                            logValuePre=logImagesMatrix(row(m),column(m),i-1);
                            if(logValue > logValuePre && logValue > threashold_l)
                                corners(row(m),column(m),i)=1 ; 
                            end
                end 
        end
end

figure ;

imagesc(I);
title('Input Image');
for l=1:size(corners,3)
        figure ;
        t='Sigma is '+l;
        
        [pointsx,pointsy]=find(corners(:,:,l)>0);
%circles = zeros

RGB = repmat(Input,[1,1,3]);
for i=1:size(pointsx,1)
    RGB(pointsx(i),pointsy(i),1) = 255;
    RGB(pointsx(i),pointsy(i),2) = 255;
    RGB(pointsx(i),pointsy(i),3) =0;
end
        %imagesc(corners(:,:,l));
imagesc(RGB);
        %subplot(1,size(corners,3),l);
        %imagesc(corners(:,:,l));
        
        title(l);
end






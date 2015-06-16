function [ oH ] = colorHist( Img, region )
xmin = region(1,1);
ymin = region(1,2);
xmax = region(2,1);
ymax = region(2,2);

croppedImg=imcrop(Img,[xmin,ymin,xmax-xmin,ymax-ymin]);
figure;
imshow(croppedImg);
[H S V] = rgb2hsv(croppedImg) ;
figure;
imagesc(H);
histo=histogram(H,256);
oH=histo.Values;
end


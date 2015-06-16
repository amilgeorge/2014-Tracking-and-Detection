close all;
I=imread('sequence/2043_000140.jpeg');
imshow(I);

hold on;
[X,Y]=getpts();

xmin = X(1);
xmax=X(2);

ymin=Y(1);
ymax =Y(2);

H=colorHist(I,[xmin ymin;xmax ymax]);

for imgNo=141:143
    I2Name=getImageName(imgNo);
    I2=imread(I2Name);
    I2Cropped=imcrop(I2,[xmin,ymin,xmax-xmin,ymax-ymin]);
    probMap1=probMap(I2Cropped,H);
    figure;
    bar3(probMap1);

    %plotProbMap(probMap1)
end

disp(X);



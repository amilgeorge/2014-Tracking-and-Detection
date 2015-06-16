A = imread('image2.jpg'); 
greyimage = rgb2gray(A);

G1f=gaussian(3);
tic;
gaussianResult1=convolution(greyimage,G1f,'mirror');
gaussian2DtimeElapsed= toc;

[G1fx,G1fy]=hvgaussianfilters(3);
tic;
h1=convolution(greyimage,G1fx,'mirror');
h2=convolution(h1,G1fy,'mirror');
gaussian1DtimeElapsed= toc;

figure;
subplot(1,2,1)
imshow(gaussianResult1);
title('2D Gaussian')
subplot(1,2,2)
imshow(h2);
title('1D Gaussian')
gaussian2DTimePrint=['Gaussian 2D Time taken',num2str(gaussian2DtimeElapsed)];
gaussian1DTimePrint=['Gaussian 1D Time taken',num2str(gaussian1DtimeElapsed)];
disp(gaussian2DTimePrint);
disp(gaussian1DTimePrint);
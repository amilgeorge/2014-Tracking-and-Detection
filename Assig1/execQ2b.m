A = imread('image2.jpg');

greyimage = rgb2gray(A);
greyimage = double(greyimage);
G1f=gaussian(1);
tic;
gaussianResult1=convolution(greyimage,G1f,'mirror');
gaussian2DtimeElapsed= toc;

[G1fx,G1fy]=hvgaussianfilters(1);
tic;
h1=convolution(greyimage,G1fx,'mirror');
h2=convolution(h1,G1fy,'mirror');
gaussian1DtimeElapsed= toc;

figure;
subplot(1,2,1)
imagesc(gaussianResult1);
title('2D Gaussian')
subplot(1,2,2)
imagesc(h2);
title('1D Gaussian')

diff=sumofSquaredDiff(gaussianResult1,h2);
disp(diff);
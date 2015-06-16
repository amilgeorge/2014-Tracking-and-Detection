A = imread('image3.jpg'); 
greyimage = rgb2gray(A);

G1f=gaussian(1);
gaussianResult1=convolution(greyimage,G1f,'mirror');

G3f=gaussian(3);
gaussianResult3=convolution(greyimage,G3f,'mirror');

figure;
subplot(1,2,1)
imshow(mat2gray(gaussianResult1));
title('Gaussian sigma 1')
subplot(1,2,2)
imshow(mat2gray(gaussianResult3));
title('Gaussian Sigma 3')
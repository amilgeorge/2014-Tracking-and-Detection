A = imread('../../lena.gif'); 
%greyimage = rgb2gray(A);
%J=bilateralFilter(A,3,1);


G1 = fspecial('gaussian',[5 5],1);
G2 = fspecial('gaussian',[15 15],5);
G3 = fspecial('gaussian',[30 30],10);
disp(G1);

Ig1 = imfilter(A,G1,'same');
Ig2 = imfilter(A,G2,'same');
Ig3 = imfilter(A,G3,'same');

figure;

subplot(1,3,1);
imagesc(Ig1);
title('sigma 1');

subplot(1,3,2);
imagesc(Ig2);
title('sigma 5');

subplot(1,3,3);
imagesc(Ig3);
title('sigma 10');
A = imread('../../lena.gif'); 
%greyimage = rgb2gray(A);
J=bilateralFilter(A,3,100);
disp(J);
figure;
subplot(1,2,1);
imagesc(A);
title('Original');
subplot(1,2,2);

imagesc(J);
title('Bilateral Filtered');
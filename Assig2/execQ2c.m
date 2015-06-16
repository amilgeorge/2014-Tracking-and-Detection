A = imread('../../lena.gif'); 
%greyimage = rgb2gray(A);
J1=bilateralFilter(A,1,1);
J2=bilateralFilter(A,5,10);
J3=bilateralFilter(A,11,11);
disp(J);
figure;
imagesc(A);
title('Original');

figure;

subplot(1,3,1);
imagesc(J1);
title('sigmad 1');

subplot(1,3,2);
imagesc(J2);
title('sigmad 5');

subplot(1,3,3);
imagesc(J3);
title('sigmad 11');
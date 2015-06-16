A = imread('image3.jpg'); 
greyimage = rgb2gray(A);
kernel=[1/9,1/9,1/9;1/9,1/9,1/9;1/9,1/9,1/9];
result=convolution(greyimage,kernel,'mirror');
imshow(mat2gray(result));
title('Mean Filtered Image')
A = imread('image2.jpg'); 
greyimage = rgb2gray(A);

kernel=[-1,0,1;-1,0,1;-1,0,1]
result=convolution(greyimage,kernel,'mirror');
Gx=imfilter(greyimage,kernel,'conv');
disp(result);
imshow(mat2gray(result));
title('conv')
figure
imshow(Gx);
title('imfilter')

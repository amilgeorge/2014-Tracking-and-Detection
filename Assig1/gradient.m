function [] =gradient()
A = imread('image.jpg'); 
greyimage = rgb2gray(A);
greyimage = double(greyimage);
Dx = [-1,0,1;-1,0,1;-1,0,1];
Dy = [-1,-1,-1;0,0,0;1,1,1];

tic;
Gx=imfilter(greyimage,Dx,'conv');
Gy=imfilter(greyimage,Dy,'conv');
time1=toc;


gradMag=sqrt(double(Gx.^2+Gy.^2));
gradDir=atan2(Gy,Gx);

%---------------Part C----------------
[Gfx,Gfy]=hvgaussianfilters(1);
%disp(Gfx);
associatedFilterX=imfilter(Dx,Gfx,'conv');
associatedFilterY=imfilter(Dy,Gfy,'conv');

Ix=imfilter(greyimage,associatedFilterX,'conv');
Iy=imfilter(greyimage,associatedFilterY,'conv');

figure;
imshow(greyimage);
title('Source Image');

figure;
subplot(1,2,1);
imshow(Gx);
title('Gradient X');
subplot(1,2,2);
imshow(Gy);
title('Gradient Y');

figure;
subplot(1,2,1)
imagesc(gradMag);
title('Gradient Magnitude')
subplot(1,2,2)
imagesc(gradDir);
title('Orientation')

figure;
subplot(1,2,1)
imshow(Ix);
title('Ix after Noise Reduction')
subplot(1,2,2)
imshow(Iy);
title('Iy after Noise Reduction')

end

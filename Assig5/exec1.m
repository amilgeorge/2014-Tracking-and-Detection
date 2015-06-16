 I = rgb2gray(imread('imagesequence/img1.ppm'));
% points = detectHarrisFeatures(I);
% strongest = points.selectStrongest(20);
% %imshow(Iq hold on;
% %plot(strongest);
% 
% [X,Y] = getpts(get(imshow(I),'Parent'));
% patchsize=40;
% I2 = I(X-patchsize/2:X+patchsize/2-1,X-patchsize/2:X+patchsize/2-1);
% figure;
% imshow(I2);
% 
% M=rand(3);
% d=det(M);
% 
% if(d<0)
%     M=M(1,:)*-1;
% end

theta=10;
rotate = [cosd(theta) -sind(theta) 0; sind(theta) cosd(theta) 0; 0 0 1];
Shy =0;
Shx = 1;
shear = [1 Shy 0;Shx 1 0; 0 0 1];
sx=1;
sy=1;
scale = [sx 0 0;0 sy 0; 0 0 1];


A = rotate * shear * scale;
tform=affine2d(A);
%tform = affine3d(shear3d);

outputImage = imwarp(I,tform);
figure;
imshow(outputImage);
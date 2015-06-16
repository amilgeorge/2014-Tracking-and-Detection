A = imread('../../harris.jpg'); 
I = double(rgb2gray(A));
dxkernal=[1,0,-1;1,0,-1;1,0,-1];
dykernal = dxkernal';
[Gx,Gy]=imgradientxy(I);

Ix=imfilter(I,dxkernal,'same');
Iy=imfilter(I,dykernal,'same');

sigmain=0.5;
sigmadn=0.7 * sigmain;
gdnkernal = fspecial('gaussian',fix(6*sigmadn), sigmadn);

Ix=imfilter(Ix,gdnkernal,'same');
Iy=imfilter(Iy,gdnkernal,'same');

ginkernal = fspecial('gaussian',fix(6*sigmain), sigmain);
ginkernal=ginkernal.*sigmadn^2;

Ix2 = imfilter(Ix.^2, ginkernal, 'same'); 
Iy2 = imfilter(Iy.^2, ginkernal, 'same');
Ixy = imfilter(Ix.*Iy,ginkernal, 'same');

alpha = 0.04;
R = (Ix2.*Iy2 - Ixy.^2) - alpha*(Ix2 + Iy2).^2; 

figure;
subplot(1,2,1);
imshow(I);
subplot(1,2,2);
imagesc(R);
thresh = 500; % Harris corner threshold
nonmaxrad = 3; % Non-maximal suppression radius
dmax = 100;
w = 11; % Window size for correlation matching

im1 = rgb2gray(imread('tum_mi_1.jpg'));
im2 = rgb2gray(imread('tum_mi_2.jpg'));

% Find Harris corners in image1 and image2
[cim1, r1, c1] = harris(im1, 1, thresh, 3);
show(im1,1), hold on, plot(c1,r1,'r+');

[cim2, r2, c2] = harris(im2, 1, thresh, 3);
show(im2,2), hold on, plot(c2,r2,'r+');

drawnow
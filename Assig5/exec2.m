I = rgb2gray(imread('imagesequence/img1.ppm'));
points = detectHarrisFeatures(I);
X=points.Location;
M=getRobustHarrisPoints(I,10,2);
imshow(I);
hold on
plot(M(:,1), M(:,2), 'r*');
disp(M);
%imshow(I); hold on;
%plot(points);
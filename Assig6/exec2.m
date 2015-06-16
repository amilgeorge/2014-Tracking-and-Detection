A = load('Classifiers.mat');
classifiers=A.classifiers;
noOfClassifiers=size(classifiers,2);

haarFeaturesArray = HaarFeatures.empty(noOfClassifiers - 1,0);
for i=2:noOfClassifiers
haarFeaturesArray(i-1)=HaarFeatures(classifiers(:,i));
end

windowSize = 19;
face1 = rgb2gray(imread('test_images/face1.jpg'));
face2 = rgb2gray(imread('test_images/face2.jpg'));
face3 = rgb2gray(imread('test_images/face3.jpg'));
[imgSizeRows,imgSizeCols]=size(face1);
I=face2;
I1=impyramid(I,'reduce');
I2=impyramid(I1,'reduce');
I3=impyramid(I2,'reduce');
I4=impyramid(I3,'reduce');

slidingWindow(I1,haarFeaturesArray);
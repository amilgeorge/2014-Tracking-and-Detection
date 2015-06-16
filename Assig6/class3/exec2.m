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
for i=1:(imgSizeRows - 19)
    for j=1:(imgSizeCols - 19)
        
    end
end
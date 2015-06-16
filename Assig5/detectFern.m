function [ output_args ] = detectFern( fernCollection, I )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
M = size(fernCollection);
fern=fernCollection(1);
distribution=fern.distribution
numClasses = size(distribution,2);

p = zeros(1,numClasses);

for i=1:numClasses
    
end

for i=1:M
numFeatures=size(fernTree.features,1);
index=0;
for j=1:numFeatures
    index=2*index;
    if(I(fernTree.features(j,1,1),fernTree.features(j,2,1))< I(fernTree.features(j,1,2),fernTree.features(j,2,2)));
        index=index+1;
    end
    
end

index=index+1;
for i=1:numClasses
p(i)=fernTree.distribution(index,i);
end

end

end


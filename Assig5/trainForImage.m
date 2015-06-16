function [ fernTree ] = trainForImage( I,fernTree, c )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
numFeatures=size(fernTree.features,1);
index=0;
for i=1:numFeatures
    index=2*index;
    if(I(fernTree.features(i,1,1),fernTree.features(i,2,1))< I(fernTree.features(i,1,2),fernTree.features(i,2,2)))
        index=index+1;
    end
    
end
index=index+1;
fernTree.distribution(index,c) = fernTree.distribution(index,c) + 1;

end



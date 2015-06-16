classdef fernTree < handle
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        id
        features
        distribution
    end
    
    methods
        function f = fernTree(id,noOfFeatures,noOfClasses)
        f.id=id;
        f.features=zeros(noOfFeatures,2,2);
        for i=1:noOfFeatures
            f.features(i,1,1)=randi(50);
            f.features(i,2,1)=randi(50);
            f.features(i,1,2)=randi(50);
            f.features(i,2,2)=randi(50);
        end
        f.distribution=zeros(2^noOfFeatures,noOfClasses);
        end
    end
    
end


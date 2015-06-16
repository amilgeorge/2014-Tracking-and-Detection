classdef fernfeature
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        x1
        y1
        x2
        y2
    end
    
    methods
         function feature = fernfeature()
             patchsize=40;
             feature.x1=randi(patchsize);
             feature.y1=randi(patchsize);
             feature.y2=randi(patchsize);
             feature.x2=randi(patchsize);
         end
    end
    
end


function [ o ] = integralImg( image )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
o=cumsum(cumsum(image')');

end


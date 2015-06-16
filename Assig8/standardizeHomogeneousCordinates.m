function [ O ] = standardizeHomogeneousCordinates( tX2 )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    tX3(1,:)=tX2(1,:)./tX2(3,:);
    tX3(2,:)=tX2(2,:)./tX2(3,:);
    %tX2(3,:)=tX2(3,:)./tX2(3,:);
    O=tX3;

end


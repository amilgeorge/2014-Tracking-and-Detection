function [ o ] = plotProbMap( map )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[R C] = size(map);

Y = zeros(R*C,3);

for i=1:R
    for j=1:C
        Y((i-1)*C+j,:) = [i , j , map(i,j)];
    end
end

bar3(map);

end


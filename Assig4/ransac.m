function [ o ] = ransacHomography( inputPoints1,inputPoints2, noOfModelElements,thresholdDistance )

[input1x,input1y]=size(inputPoints1);

permutation=randperm(input1x);
selectedindexes = permutation(1:noOfModelElements);

modelPoints = zeros(noOfModelElements,inputy);
for i=1:length(selectedindexes)
    modelPoints(i,:) = inputPoints1(selectedindexes(i),:);
end

H=[0]%homography func;


o=0;
end

function [ o ] = distHomography(H,x1,x2,t)

Hx1=H*x1;
invHx2 = H\x2 % check if it is x2'


dist = sum((x1-invHx2).^2)  + sum((x2-Hx1).^2);
inliers = find(abs(d2) < t);    
end



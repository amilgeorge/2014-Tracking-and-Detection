function [ o ] = slidingWindow( greyimage,haarFeaturesArray )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
iimg=integralImg(double(greyimage));


detectFaceWithParameters = @(x) detectface(x,haarFeaturesArray);
J=nlfilter(iimg,[19 19],detectFaceWithParameters);
figure;
subplot(1,2,1);
imshow(J);
subplot(1,2,2);
imshow(greyimage);

end

function o=detectface(iImg,haarFeaturesArray)

noOfClassifiers=size(haarFeaturesArray,2);

alphas=zeros(noOfClassifiers,1);
hx = zeros(noOfClassifiers,1);
for i=1:noOfClassifiers
haarfeature=haarFeaturesArray(1,i);    
t=haarfeature.haarFeaturesCompute(iImg);
  
        meanPos=haarfeature.meanPos;
        %sdPos=haarfeature.sdPos;
        maxPos=haarfeature.maxPos;
        minPos=haarfeature.minPos;
        clNo= haarfeature.clNo;
        alphas(i,1)=haarfeature.alpha;
        %error=haarfeature.error;
        %falseNegError=haarfeature.falseNegError;
        %falsePosError=haarfeature.falsePosError;

        lowerbound = meanPos - abs(meanPos - minPos) * (clNo -5)/50;
        upperbound = meanPos + abs(maxPos  - meanPos) * (clNo -5)/50;
        
        if(t>=lowerbound && t<=upperbound)
            hx(i) =1;
        else
                hx(i)=0;
        end

end
lhs = sum(hx.*alphas);
rhs = 0.5*sum(alphas);
if lhs >= rhs
    o=1;
else
    o=0;
end

end

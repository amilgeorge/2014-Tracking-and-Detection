function [ robustPoints ] = getRobustHarrisPoints( I,numPoints,error )

points = detectHarrisFeatures(I);
P=corner(I);
[X,Y]=size(I);

harrisMatrix=buildCornerMatrix(P,X,Y,error);

matrix = zeros(X,Y);

for i=1:20
    transformMatrix=getAffineTransformationMatrix();
    tform=affine2d(transformMatrix);
    outputImage = imwarp(I,tform);
    harrispoints = detectHarrisFeatures(outputImage);
    Ptmp=corner(outputImage);
    [Xtmp,Ytmp]=size(outputImage);
    tmpCornerMatrix=buildCornerMatrix(Ptmp,Xtmp,Ytmp,error);
    invtform=tform.invert;
    invCornerMatrixAugmented = imwarp(tmpCornerMatrix,invtform);
    %figure;
    %imagesc(invCornerMatrixAugmented);
    %figure;
    %imagesc(tmpCornerMatrix);
    [invCornerMatrixSizeX,invCornerMatrixSizeY]=size(invCornerMatrixAugmented);
    xshiftleft=floor((invCornerMatrixSizeX - X)/2);
    yshifttop=floor((invCornerMatrixSizeY - Y)/2);
    xshiftright=(invCornerMatrixSizeX - X) - xshiftleft;
    yshiftbottom=(invCornerMatrixSizeY - Y) - yshifttop;
    invCornerMatrix=invCornerMatrixAugmented(xshiftleft+1:invCornerMatrixSizeX-xshiftright,yshifttop+1:invCornerMatrixSizeY - yshiftbottom);
    matrix=matrix+invCornerMatrix;
end

lenPoints=size(P,1);
cornerFreqMatrix = zeros(lenPoints,3);
e=error;
for i=1:lenPoints
    xloc=fix(P(i,1));
    yloc=fix(P(i,2));
    xlow=max(1,xloc-e);
    xhigh=min(Y,xloc+e);
    ylow=max(1,yloc-e);
    yhigh=min(X,yloc+e);
    submat=matrix(ylow:yhigh,xlow:xhigh); 
    freq=max(submat(:));
    try
    cornerFreqMatrix(i,:) = [xloc,yloc,freq];
    catch err
        disp(i);
    end
end
sortedcornerFreqMatrix=sortrows(cornerFreqMatrix,-3);
robustPoints=sortedcornerFreqMatrix(1:numPoints,1:2);

end

function [M] = buildCornerMatrix(cornerPoints,X,Y,error)

M=zeros(X,Y);
numCornerPoints=size(cornerPoints,1);
e=error;

for i=1:numCornerPoints
    xloc=fix(cornerPoints(i,1));
    yloc=fix(cornerPoints(i,2));
    xlow=max(1,xloc-e);
    xhigh=min(Y,xloc+e);
    ylow=max(1,yloc-e);
    yhigh=min(X,yloc+e);
        
    M(ylow:yhigh,xlow:xhigh)=1;
end

end

function [ probDist ] = probMap( colorImg, hist )

numBins = 256;


[H S V] = rgb2hsv(colorImg) ;
[R C]=size(H);
probDist = zeros(size(H));
for i=1:R
    for j=1:C
        binNo=round(H(i,j)*(numBins - 1 ) + 1);
        probDist(i,j) = hist(round(binNo));
    end
end

probDist = (probDist/ max(probDist(:))) *255;
end


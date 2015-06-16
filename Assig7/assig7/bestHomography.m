function [ o ] = bestHomography( i,j )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
imgName1 = getImageName(i);
imgName2 = getImageName(j);
img1=(imread(imgName1));
img2=(imread(imgName2));

img1g =single(rgb2gray(img1)) ;
img2g = single(rgb2gray(img2)) ;


[f1,d1] = vl_sift(img1g) ;
[f2,d2] = vl_sift(img2g) ;

[matches, scores] = vl_ubcmatch(d1,d2) ;

numMatches = size(matches,2) ;

X1 = f1(1:2,matches(1,:)) ; X1(3,:) = 1 ;
X2 = f2(1:2,matches(2,:)) ; X2(3,:) = 1 ;

errorthreshold = 36;
maxInliers = 0;
maximumInlierCountThreshold = round(numMatches * .9);



for t = 1:100
  
    
    subset = vl_colsubset(1:numMatches, 4) ;
    H=homography2d(X1(:,subset),X2(:,subset));
    
    tX2=H*X1;
    tX2(1,:)=tX2(1,:)./tX2(3,:);
    tX2(2,:)=tX2(2,:)./tX2(3,:);
    tX2(3,:)=tX2(3,:)./tX2(3,:);
    diff=tX2(:,:) - X2(:,:);
    error = diff(1,:).^2 + diff(2,:).^2  ;
    
    inliers = sum(error < errorthreshold);
    tmpInlierIndexes = find(error<errorthreshold);
    
    
    
    if(inliers > maxInliers)
        bestH=H;
        maxInliers =inliers;
        inliersIndexes = tmpInlierIndexes;
        if(maxInliers >= maximumInlierCountThreshold)
            break;
        end
    end
    
    
    
end

 H_usingInliers=homography2d(X1(:,inliersIndexes),X2(:,inliersIndexes));
 %showMatchedFeatures(img1,img2,X1(1:2,inliersIndexes(1:10))',X2(1:2,inliersIndexes(1:10))','montage');
o = H_usingInliers;
end

function [ imageName ] = getImageName( i )
if(i<10)
formatSpec = 'img_sequence/000%d.png';
else
    formatSpec = 'img_sequence/00%d.png';
    
end

imageName =  sprintf(formatSpec,i);
end


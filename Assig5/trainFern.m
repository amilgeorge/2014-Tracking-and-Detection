function [ o ] = trainFern( numFerns,fernDepth)

pathClass=['class1/';'class2/'];

classSize=size(pathClass,1);
% create ferns
fernCollection=fernTree.empty;
for i=1:numFerns
fernCollection(i)=fernTree(i,fernDepth,2);
end


%train ferns
for p=1:classSize
mypath=pathClass(p,:);
Imgs = dir(fullfile(mypath,'*.ppm'));
NumImgs = size(Imgs,1);
for i=1:NumImgs
    fileName = [mypath Imgs(i).name];
    I = rgb2gray(imread(fileName));
    for j=1:numFerns
        fern=fernCollection(j);
        trainForImage(I,fern,p);
    end
end
end

%normalize

for i=1:numFerns
fern=fernCollection(i);
sumDist=sum(fern.distribution);

  dist=fern.distribution;
  distSize=size(fern.distribution,1);
  for f=1:distSize
    for j=1:classSize
        if(sumDist(j)==0)
        else
        dist(f,j) = dist(f,j)/sumDist(j); 
        end
    end
  end
end


save('ferntest.mat','fernCollection')

end


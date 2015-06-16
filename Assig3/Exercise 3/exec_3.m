clear; close all;

tic()

initialImage = double( rgb2gray(imread('../Assig7/img_sequence/0000.png')) );
[height, width, d] = size(initialImage);
numImages = 44;

A = [472.3  0.64   329.0; % intrinsic matrix A (fixed for the whole sequence)
      0     471.0  268.3;
      0      0        1];

startingValuesForRandT = [0;0;0;0;0;0];
saveRotAndTraValues = zeros(6,numImages);

[projectedPointsIn3D, initialFrames, initialDescriptors] = initialPose_1(initialImage);
otherImages = zeros(height, width, numImages);

for i=1:numImages
  
    i
    if(i < 10)
        imageName = sprintf('../Assig7/img_sequence/000%d.png', i);
    else
        imageName = sprintf('../Assig7/img_sequence/00%d.png', i);
    end
    
     currentImage = single(rgb2gray(imread(imageName)));
    otherImages(:, :, i) = currentImage;

    [m1, m2, inliers, H, M] = correspondences(otherImages(:, :, i), initialFrames, initialDescriptors, projectedPointsIn3D);
    
    func = @(startingValuesForRandT) energyFunction(A,startingValuesForRandT,M,m2);
    [startingValuesForRandT,energy] = fminsearch(func, startingValuesForRandT);
    
    % Part4 - a) Jacobian : returns Jacobian (not finished :S one error
    % happening
    % computeJacobian( A,p, M, mTilda)
    
    % Part4 - b) :Should be fixed the condition
    %opts = optimoptions(@lsqnonlin,'Jacobian','on');
    %[startingValuesForRandT,energy] = lsqnonlin(func,startingValuesForRandT,[],[],opts);
    
    
    saveRotAndTraValues(:,i+1) = startingValuesForRandT;
    startingValuesForRandT
    energy

end
       
 % plot3(projectedPointsIn3D(1,:),projectedPointsIn3D(2,:),projectedPointsIn3D(3,:),'bx');
  %hold on; 

points=[]; 
for i=1:45 
    params = saveRotAndTraValues(:,i); 
    [R T]=CalcRandT_3(params); 
    new=(-R)'*T; 
    points=[points; new']; 
end
plot3(points(:,1),points(:,2),points(:,3),'-rx');
grid on

toc()
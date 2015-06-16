function [ firstMatches, secondMatches, H, inliers, M3D] = correspondences(image, initialFrames, initialDescriptors, M)

 [frames,descriptors] = vl_sift(single(image));
 
 matches = vl_ubcmatch(initialDescriptors, descriptors);

firstMatches = initialFrames(1:2, matches(1, :));
firstMatches(3,:) = ones(1,size(firstMatches,2));

secondMatches = frames(1:2,matches(2,:));
secondMatches(3,:) = ones(1,size(secondMatches,2));

[H,inliers] =RansacHomography(firstMatches,secondMatches,0.002);

firstMatches = firstMatches(:,inliers(1,:));
secondMatches = secondMatches(:,inliers(1,:));

% firstMatches = initialFrames(1:2, matches(1, :)); 
% secondMatches = frames(1:2,matches(2,:)); 
% [~, inlier1, inlier2] = estimateGeometricTransform(cornerPoints(firstMatches'), cornerPoints(secondMatches'), 'affine');
% firstMatches = inlier1.Location'; 
% firstMatches(3,:) = ones(1,size(firstMatches,2)); 
% secondMatches = inlier2.Location'; 
% secondMatches(3,:) = ones(1,size(secondMatches,2));
% inliers = [inlier1.Location';inlier2.Location'];

M3D = 0;
if size(M,1) > 0
    M3D = M(:, inliers(1, :));
end

end
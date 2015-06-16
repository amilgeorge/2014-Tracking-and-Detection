function [projectedPointsIn3D, frames, descriptors] = initialPose_1(image)

[frames,descriptors] = vl_sift(single(image)); % SIFT features for the image

A = [472.3  0.64   329.0; % intrinsic matrix A (fixed for the whole sequence)
      0     471.0  268.3;
      0      0        1];

% We are asuming that this is the initial pose estimation so we have no
% rotation and no translation
numberOfPoints = size(frames, 2); % number of SIFT points in the image
projectedPointsIn3D = zeros(4, numberOfPoints); % 4 rows for coordinates and numberOfPoints: nr of columns

    for i = 1:numberOfPoints
    
        m = [frames(1:2, i); 1]; % 2D points coordinates homogenized
        
        % Calculation of 3D points. This also does the projection in plane z=1 since
        % the z-coordinate is 1
        M =A\m;%   we could use also this formula: inv(A) * m;
    
        % Now we project the points
        projectedPointsIn3D(:, i) = [M(1)/M(3); M(2)/M(3); 1;1]; % gets all the points calculated in M
    
    end
end
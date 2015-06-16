function [newpts, T] = Normalisepts(pts)
% indices of points not at infinity
finiteind = find(abs(pts(3,:)) > eps);

if length(finiteind) ~= size(pts,2)
    warning('points at infinity');
end

%points have scale of 1
pts(1,finiteind) = pts(1,finiteind)./pts(3,finiteind);
pts(2,finiteind) = pts(2,finiteind)./pts(3,finiteind);
pts(3,finiteind) = 1;
% Centroid of points
c = mean(pts(1:2,finiteind)')';      
% Shift origin to centroid.
newp(1,finiteind) = pts(1,finiteind)-c(1);
newp(2,finiteind) = pts(2,finiteind)-c(2);

dist = sqrt(newp(1,finiteind).^2 + newp(2,finiteind).^2);
meandist = mean(dist(:));

scale = sqrt(2)/meandist;

T = [scale   0   -scale*c(1)
     0     scale -scale*c(2)
     0       0      1      ];

newpts = T*pts;
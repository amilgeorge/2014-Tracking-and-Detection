function [H,inliers]=RansacHomography(x1,x2,t)
[rows,npts] = size(x1);
if rows == 2
        x1 = [x1; ones(1,npts)];
        x2 = [x2; ones(1,npts)];        
end
[x1, T1] = Normalisepts(x1);
[x2, T2] = Normalisepts(x2);
s = 4;
[H,inliers] = RANSAC([x1; x2],s, t);
Hlin = Homography(x1(:,inliers), x2(:,inliers));
H = T2\Hlin*T1;

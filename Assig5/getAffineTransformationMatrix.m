function [M] = getAffineTransformationMatrix(  )
theta=1+179*rand(1,1);
%scale_width between 1 to 100

scale=1+99*rand(2,1);
scale_width=scale(1,1);
scale_height=scale(2,1);

M=[(scale_width* cosd(theta)) scale_height*sind(theta) 0; - scale_width*sind(theta) scale_height*cosd(theta) 0; 0 0 1];

end


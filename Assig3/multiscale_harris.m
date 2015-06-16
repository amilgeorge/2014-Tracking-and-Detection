function [O]=multiscale_harris(I,initial_scale, scale_level, scale_step, constant_factor, threshold_value)

Dx = [-1 0 1;-1 0 1; -1 0 1 ];
Dy = [-1 -1 -1;0 0 0; 1 1 1 ];
I1=I;
I=double(I);

sigma_In= initial_scale*(scale_step ^ scale_level);
%sigma_In=0.5;
sigma_Dn=0.7*sigma_In ;

gussian_kernel=fspecial('gaussian',fix(6*sigma_Dn),sigma_Dn);

X=conv2(Dx,gussian_kernel) ;
I_derivative_x=conv2(I, X,'same');

Y=conv2(Dy,gussian_kernel);
I_derivative_y=conv2(I, Y,'same');

gussian_kernel2=fspecial('gaussian',fix(6*sigma_In),sigma_In);
gussian_kernel_final=(sigma_Dn ^ 2) .* gussian_kernel2;


I_derivative_x_guassianed=conv2( I_derivative_x .^ 2,gussian_kernel_final,'same');
I_derivative_y_guassianed=conv2( I_derivative_y .^ 2 ,gussian_kernel_final,'same');
I_derivative_xy_guassianed=conv2(I_derivative_x .* I_derivative_y,gussian_kernel_final,'same' );

determinant_M= (I_derivative_x_guassianed .* I_derivative_y_guassianed) - ((I_derivative_xy_guassianed .^ 2)) ;
trace_M=( I_derivative_x_guassianed) + (I_derivative_y_guassianed) ;


R= (determinant_M - constant_factor* (trace_M .^ 2));
R(R < threshold_value )= 0 ;
 
O = R > imdilate(R, [1 1 1; 1 0 1; 1 1 1]);

%yellow = uint8([255 255 0]);
[pointsx,pointsy]=find(O>0);
%circles = zeros

RGB = repmat(I1,[1,1,3]);
for i=1:size(pointsx,1)
    RGB(pointsx(i),pointsy(i),1) = 255;
    RGB(pointsx(i),pointsy(i),2) = 255;
    RGB(pointsx(i),pointsy(i),3) =0;
end
    


end
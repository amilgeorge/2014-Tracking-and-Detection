J=imread('lena.gif');
grayImage=J ;
I=grayImage;

initial_scale = 1.5 ;
scale_step=1.2 ;
constant_factor=0.04 ;
threshold_value=1000 ;


scale_level=0 ;
Output1 = multiscale_harris(I,initial_scale,scale_level,scale_step, constant_factor,threshold_value);

figure ;
subplot(1,4,1);
imshow(grayImage);

subplot(1,4,2);
imagesc(Output1);

scale_level=5 ;
Output2 = multiscale_harris(I,initial_scale,scale_level,scale_step, constant_factor,threshold_value);
subplot(1,4,3);
imagesc(Output2);


scale_level=17 ;
Output3 = multiscale_harris(I,initial_scale,scale_level,scale_step, constant_factor,threshold_value);
subplot(1,4,4);
imagesc(Output3);





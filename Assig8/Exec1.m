I=rgb2gray(imread('image_sequence/0000.png'));
imshow(I);

hold on;
[X,Y]=getpts();
x=X(1);
y=Y(1);
patchsize=100;
rectX=[x,x+patchsize,x,x+patchsize];
rectY=[y,y,y+patchsize,y+patchsize];
plot(rectX,rectY,'r*');
impixelinfo;

TemplateCordinates=[rectX;rectY];
Range=[-10;10];

Rx = zeros(1,121);
Ry = zeros(1,121);

topLeftx=x;
topLefty=y;

for i=1:10
    for j=1:10
        Rx(1,(i-1)*10+j) = topLeftx + (i-1)*10;
        Ry(1,(i-1)*10+j) =topLefty + (j-1)*10;
    end
end

plot(Rx, Ry,'r*');

R=[Rx;Ry;];

Training(I,TemplateCordinates,Range,R);
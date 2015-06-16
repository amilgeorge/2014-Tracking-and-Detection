clear ;
close all ;
J=rgb2gray(imread('image_sequence/0000.png'));
imshow(J);

hold on;
[X,Y]=getpts();
x=X(1);
y=Y(1);
patchsize=100;
rectX=[x,x+patchsize,x+patchsize,x];
rectY=[y,y,y+patchsize,y+patchsize];
plot(rectX,rectY,'b*');
impixelinfo;

TemplateCordinates=[rectX;rectY];


Rx = zeros(1,121);
Ry = zeros(1,121);

topLeftx=x;
topLefty=y;

for i=1:11
    for j=1:11
        Rx(1,(i-1)*11+j) = topLeftx + (i-1)*10;
        Ry(1,(i-1)*11+j) =topLefty + (j-1)*10;
    end
end

plot(Rx, Ry,'r*');

%Rectangular grid
R=[Rx;Ry;];
RHomo=[R;ones(1,size(R,2))] ;
for i=1:5
    Range=[-3*i ;3*i];
    A=Training(J,TemplateCordinates,Range,R);
    Ai{i}=A;
end
IReferenceGrid=impixel(J,Rx,Ry);
IReferenceGrid=IReferenceGrid(:,3);
IReferenceGridNorm=normalizeValues(IReferenceGrid);
   
movingGridPointsX=Rx;
movingGridPointsY=Ry;

initialParameterVector=TemplateCordinates;

%changed to homog. later
currentParameterVector= initialParameterVector ;
%change to homogeneous
initialParameterVectorHomo=[initialParameterVector;ones(1,size(initialParameterVector,2))];
  
NumberOfImages=5;
for i=1 : NumberOfImages
    I=rgb2gray(imread(getImageName(i)));
    figure ;
    imshow(I);
    hold on ;
    for k=1:size(Ai)
        Ak = Ai{size(Ai)-k+1};
    for j=1:10
    %2a
    IGridMoving=impixel(I,movingGridPointsX,movingGridPointsY);
    IGridMoving=IGridMoving(:,3);
   
    %2b
    IGridMovingNorm=normalizeValues(IGridMoving)
    %2c
     deltaIntesity= normalizeValues(IGridMovingNorm - IReferenceGridNorm) ;
     %2d
     %A=A/sum(A(:));
     deltaParam= Ak*deltaIntesity ;
     %2e
     currentParameterVectorHomo =[currentParameterVector;ones(1,size(currentParameterVector,2))]; 
     %current homography
     Hc=homography2d(initialParameterVectorHomo, currentParameterVectorHomo);
   
     %update homography
     deltaParamReShaped= reshape(deltaParam,2,[]);
     newParamVector= currentParameterVector + deltaParamReShaped ;
     newParamVectorHomo= [newParamVector; ones(1,size(newParamVector,2))] ;
     Hu=homography2d(currentParameterVectorHomo,newParamVectorHomo);
     
     %New homography
     Hn=Hc*Hu ;
     
     %New parameter Vector
     newParamVector1= Hn*initialParameterVectorHomo ;
     newParamVector1Stand=standardizeHomogeneousCordinates(newParamVector1);
    if j<5
     plot(newParamVector1Stand(1,:)' , newParamVector1Stand(2,:)','b-');
    else
     plot(newParamVector1Stand(1,:)' , newParamVector1Stand(2,:)','r-');
    end
     currentParameterVector=newParamVector1Stand ;
    
     movingGridPointsHomo=Hn * RHomo ;
     movingGridPointsStand= standardizeHomogeneousCordinates(movingGridPointsHomo);
     movingGridPointsX=movingGridPointsStand(1,:)';
     movingGridPointsY=movingGridPointsStand(2,:)' ;
    end 
     
    end
    plot(newParamVector1Stand(1,:)' , newParamVector1Stand(2,:)','g-');
    end






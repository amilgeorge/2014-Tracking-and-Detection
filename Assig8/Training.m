function [ A ] = Training( I, TemplateCordinates, Range,R)

%UNTITLED Summary of this function goes here

%   Detailed explanation goes here

I=double(I);
X1=TemplateCordinates(:,1);
X2=TemplateCordinates(:,2);
X3=TemplateCordinates(:,3);
X4=TemplateCordinates(:,4);

MIN=Range(1,1);
MAX=Range(2,1);



RxHomo=[R;ones(1,size(R,2))] ;

noOfGridPoints =size(R,2);
N= noOfGridPoints+1000 ;
 
DelataIntesity=[] ;
DeltaParameter= [];

for i=1:N
    rand = randi([MIN MAX],size(TemplateCordinates));
    CNew=TemplateCordinates+rand ;
    CHomo=[TemplateCordinates;ones(1,size(TemplateCordinates,2))];
    CNewHomo =[CNew;ones(1,size(CNew,2))]; 
    H=homography2d(CHomo, CNewHomo);
    %warped=imwarp(I,projective2d(H'),'OutputView',imref2d(size(I)));
 
    RTrans= H\RxHomo ;
    RTransStand= standardizeHomogeneousCordinates(RTrans);
    Iarr=impixel(I,RTransStand(1,:)',RTransStand(2,:)');
    IIntensityValues=Iarr(:,3);
    %imshow(warped);
    %q=impixel(I,x,y);
    Iarr1=impixel(I,R(1,:)',R(2,:)');
    IIntensityValues1=Iarr1(:,3);
     
   normalized =normalizeValues(IIntensityValues);
   normalized1 =normalizeValues(IIntensityValues1);
   
   
   %moving - static grid
   DelataIntesity= [ DelataIntesity (normalized- normalized1) ];
   randValuesFlat=rand(:) ;
   DeltaParameter= [ DeltaParameter randValuesFlat ] ;
  
end
   
    
    In=DelataIntesity ;
    noise =10*randn(size(In));
    In = In +noise;
    P=DeltaParameter;
    Q= In*In'; 
    A = P* In'/ Q ; 
end

 

 
I=imread('img_sequence/0000.png');

A=[472.3 0.64 329.0 ; 0 471.0 268.3 ; 0 0 1];
rAlpha= 0 ;
rBeta= 0 ;
rGamma= 0;
t1= 0 ;
t2= 0;
t3= 0;
inR_T = [rAlpha,rBeta,rGamma;t1,t2,t3];
[TwoDSiftPoints, ThreeDSiftPoints] = getThreeDSiftPoints(I);

%detectFaceWithParameters = @(x) detectface(x,haarFeaturesArray);
figure;
C = zeros(44,3);
for i=1:44

H=bestHomography(0,i);
twoDSiftPointMapping = H * TwoDSiftPoints;
 twoDSiftPointMapping(1,:)=twoDSiftPointMapping(1,:)./twoDSiftPointMapping(3,:);
    twoDSiftPointMapping(2,:)=twoDSiftPointMapping(2,:)./twoDSiftPointMapping(3,:);
    twoDSiftPointMapping(3,:)=twoDSiftPointMapping(3,:)./twoDSiftPointMapping(3,:);
E=@(x) EnergyFunction(A,x,ThreeDSiftPoints,twoDSiftPointMapping);
%E4=@(x1) EnergyFunction4(A,x1,ThreeDSiftPoints,twoDSiftPointMapping);
options = optimoptions(@lsqnonlin,'Algorithm','levenberg-marquardt');
options=optimoptions(options,'Jacobian','on');
options=optimoptions(options,'Display','iter-detailed');
options=optimoptions(options,'TolX',1e-1);

x=fminsearch(E,inR_T);
%y=lsqnonlin(E4,inR_T,[],[],options);
%x=y;
outR=getRotationMatrix(x(1,1),x(1,2),x(1,3));
outT=[x(2,1);x(2,2);x(2,3)];
inR_T = x;
c=estimateCameraPosition(outR,outT);
C(i,:)=c';  
end
figure;
plot3(C(:,1),C(:,2),C(:,3));

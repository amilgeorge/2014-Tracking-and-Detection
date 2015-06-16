function [E] = EnergyFunction(A,inR_T,M,m)

rAlpha = inR_T(1,1);
rBeta = inR_T(1,2);
rGamma = inR_T(1,3);
t1 = inR_T(2,1);
t2 =inR_T(2,2);
t3=inR_T(2,3);
%RX = [cos(rAlpha) -sin(rAlpha) 0 ; sin(rAlpha) cos(rAlpha) 0 ; 0 0 1  ]; 
%RY = [cos(rBeta) 0 sin(rBeta) ; 0 1 0 ; -sin(rBeta) 0 cos(rBeta) ] ;
%RZ = [ 1 0 0 ; 0 cos(rGamma) -sin(rGamma) ; 0 sin(rGamma) cos(rGamma)]; 
R=getRotationMatrix(rAlpha,rBeta,rGamma) ;
T=[t1 t2 t3]';

RAndT=[R T];

m1=A * RAndT * M;
 m1(1,:)=m1(1,:)./m1(3,:);
    m1(2,:)=m1(2,:)./m1(3,:);
    m1(3,:)=m1(3,:)./m1(3,:);
EMatrix = (m1-m).^2 ;

E=sum(EMatrix(:));



end 
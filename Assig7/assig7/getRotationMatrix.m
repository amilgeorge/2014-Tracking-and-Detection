function [ R ] = getRotationMatrix( rAlpha,rBeta,rGamma )


RX = [cos(rAlpha) -sin(rAlpha) 0 ; sin(rAlpha) cos(rAlpha) 0 ; 0 0 1  ]; 
RY = [cos(rBeta) 0 sin(rBeta) ; 0 1 0 ; -sin(rBeta) 0 cos(rBeta) ] ;
RZ = [ 1 0 0 ; 0 cos(rGamma) -sin(rGamma) ; 0 sin(rGamma) cos(rGamma)] ;

R=RX*RY*RZ;
end


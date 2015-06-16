function [ rotation, translation ] = CalcRandT( rotTraArray )

alphaX = rotTraArray(1);
betaY = rotTraArray(2);
gammaZ = rotTraArray(3);
traX = rotTraArray(4);
traY = rotTraArray(5);
traZ = rotTraArray(6);

% rotationInX = [1      0           0
%                0 cos(alphaX) -sin(alphaX)
%                0 sin(alphaX) cos(alphaX)];
%     
% rotationInY = [cos(betaY)    0     sin(betaY)
%                     0        1        0
%                -sin(betaY)   0    cos(betaY)];
% 
% rotationInZ = [cos(gammaZ)   -sin(gammaZ)  0
%                sin(gammaZ)  cos(gammaZ)  0
%                     0             0       1];

rotationInX = [1      0           0
               0 cos(gammaZ) -sin(gammaZ)
               0 sin(gammaZ) cos(gammaZ)];
    
rotationInY = [cos(betaY)    0     sin(betaY)
                    0        1        0
               -sin(betaY)   0    cos(betaY)];

rotationInZ = [cos(alphaX)   -sin(alphaX)  0
               sin(alphaX)  cos(alphaX)  0
                    0             0       1];

rotation = rotationInZ * rotationInY * rotationInX;

translation = [traX; traY; traZ];

end


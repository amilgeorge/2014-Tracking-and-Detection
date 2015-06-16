function [ jacobianImpl ] = computeJacobian( A,p, M, mTilda)
syms r1 r2 r3 t1 t2 t3 u v w X Y Z real;
syms mOvermTilda1 mOvermTilda2 mOvermTilda3 mOvermTilda4 mOvermTilda5 mOvermTilda6;
syms mTildaOverMCam1 mTildaOverMCam2 mTildaOverMCam3 mTildaOverMCam4 mTildaOverMCam5 mTildaOverMCam6 ...
    mTildaOverMCam7 mTildaOverMCam8 mTildaOverMCam9;
syms last1 last2 last3 last4 last5 last6 last7 last8 last9 last10 last11 last12 last13 last14 last15 last16;

 m = [u;v];
 mTilda = [u;v;w];
 p=[r1,r2,r3,t1,t2,t3];
 M=[X;Y;Z];
 A = [472.3  0.64   329.0; % intrinsic matrix A (fixed for the whole sequence)
      0     471.0  268.3;
      0      0        1];

 mOvermTilda1 =  diff(m(1), mTilda(1));
 mOvermTilda2 =  diff(m(1), mTilda(2));
 mOvermTilda3 =  diff(m(1), mTilda(3));
 mOvermTilda4 =  diff(m(2), mTilda(1));
 mOvermTilda5 =  diff(m(2), mTilda(2));
 mOvermTilda6 =  diff(m(2), mTilda(3));
 res1 = [mOvermTilda1, mOvermTilda2, mOvermTilda3; mOvermTilda4, mOvermTilda5, mOvermTilda6];
 
 rotationInX = [1      0           0
                 0 cos(r1) -sin(r1)
                 0 sin(r1) cos(r1)];
    
rotationInY = [cos(r2)    0     sin(r2)
                    0        1        0
               -sin(r2)   0    cos(r2)];

rotationInZ = [cos(r3)   -sin(r3)   0
               sin(r3)    cos(r3)   0
                 0          0       1];

rotation = rotationInZ * rotationInY * rotationInX;

translation = [t1; t2; t3];

MCam = norm(rotation*M + translation);
 
 mTildaOverMCam1 = diff(mTilda(1), MCam(1));
 mTildaOverMCam2 = diff(mTilda(1), MCam(2));
 mTildaOverMCam3 = diff(mTilda(1), MCam(3));
 mTildaOverMCam4 = diff(mTilda(2), MCam(1));
 mTildaOverMCam5 = diff(mTilda(2), MCam(2));
 mTildaOverMCam6 = diff(mTilda(2), MCam(3));
 mTildaOverMCam7 = diff(mTilda(3), MCam(1));
 mTildaOverMCam8 = diff(mTilda(3), MCam(2));
 mTildaOverMCam9 = diff(mTilda(3), MCam(3));
 
 res2 = [mTildaOverMCam1, mTildaOverMCam2, mTildaOverMCam3;
         mTildaOverMCam4, mTildaOverMCam5, mTildaOverMCam6;
         mTildaOverMCam7, mTildaOverMCam8, mTildaOverMCam9];

 last1 = diff(MCam(1), r1);
 last2 = diff(MCam(1), r2);
 last3 = diff(MCam(1), r3);
 last4 = diff(MCam(1), t1);
 last5 = diff(MCam(1), t2);
 last6 = diff(MCam(1), t3);
 last7 = diff(MCam(2), r1);
 last8 = diff(MCam(2), r2);
 last9 = diff(MCam(2), r3);
 last10 = diff(MCam(2), t1);
 last11 = diff(MCam(2), t2);
 last12 = diff(MCam(2), t3);
 last13 = diff(MCam(3), r1);
 last14 = diff(MCam(3), r2);
 last15 = diff(MCam(3), r3);
 last16 = diff(MCam(3), t1);
 last17 = diff(MCam(3), t2);
 last18 = diff(MCam(3), t3);
 
 res3 = [ last1,  last2,  last3,  last4,  last5,  last6;
          last7,  last8,  last9,  last10, last11, last12;
          last13, last14, last15, last16, last17, last18];
 
  jacobianImpl = res1*res2*res3;

     
% m = [ u;v ] dhe mTilda = [u; v; w]
% m = A[R|T]M
% f(p) = [ u(ProjA, R(p), T(p)(M1)); v(ProjA, R(p), T(p)(M1));...]
% = [f_M1(p); ...]
%f_M1(p) = m(mTilda(MCam(p)))
%where:
%MCam(p) returns M1 in the camera coordinates system defined by p
% mTilda(MCam) returns the projection in the homogeneous coordinates
%m(mTilda) returns the 2D vector corresponding to mTilda
%
%J = [delta_f mbi delta_p] = [f_M1(p); ...], ku:
%[f_M1(p)]=[delta_m mbi delta_mTilda](2x3) *
% * [delta_mTilda mbi delta_MCam] (3x3) *
% * [delta_MCam mbi p] (3x6)
%
% dhe m(mTilda) = [u v] = [U/W; V/W], ku mTilda = [U;V;W]
%
% delta_m mbi delta_mTilda = [delta_u mbi delta_U, delta_u mbi delta_V, delta_u mbi delta_W
% ; delta_v mbi delta_U, delta_v mbi delta_V, delta_v mbi delta_W] =
% = [1/W  0  -U/(W^2); 0 1/W  -V/(W^2)]
%
% mTilda(MCam) = A*MCam, prandaj
% delta_mTilda mbi delta_MCam = A
%
% MCam(p) = R(p)*M1 + T, with p=[r1, r2, r3, t1, t2, t3]' 
% pra (T=[t1, t2, t3]'). Prandaj:
%
% delta_MCam mbi delta_p =
% =[ delta_MCam mbi delta r1, ..., delta_MCam mbi delta_t3] =
% =[[delta_R mbi delta_r1]*M1, ..., [delta_R mbi delta_r3]*M1, I(3x3)]
% The matrices [delta_R mbi delta_r3] (3x3) can be
% computed from the expansion of R  (with Rodrigues)
% MCam = RM + T
end


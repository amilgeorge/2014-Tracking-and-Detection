function [TwoDSiftPoints, ThreeDSiftPoints] = getThreeDSiftPoints(I)

A=[472.3 0.64 329.0 ; 0 471.0 268.3 ; 0 0 1];
I = single(rgb2gray(I)) ;
[f,d] = vl_sift(I) ;

noOfSiftPoints = size(f,2) ;

%taking x and y ordinates only
P = f(1:2,:) ;

TwoDSiftPoints = ones(3,noOfSiftPoints) ;
ThreeDSiftPoints = ones(4,noOfSiftPoints) ;

for i=1:noOfSiftPoints
        %express position vector in homogeneous cordinates
        positionVector=[P(1,i) P(2,i) 1 ];
        TwoDSiftPoints(1,i)=P(1,i) ;
        TwoDSiftPoints(2,i)= P(2,i) ;
      
        N=A\positionVector' ;
        ThreeDSiftPoints(1,i)=N(1) ;
        ThreeDSiftPoints(2,i)=N(2) ;
        ThreeDSiftPoints(3,i)=N(3) ;
        
end 

end
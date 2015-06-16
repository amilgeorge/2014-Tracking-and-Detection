function T = getNormalizationMatrix( P )
%1.Translation of the centroid to the origin
%Find the Centroid
x=mean(P(1,:));
y=mean(P(2,:));
%translation transformation
T1 = [ 1 0 -x ; 0 1 -y ; 0 0 1 ];

%2.Make sure average distance to the origin is sqrt(2)
P = T1 * P;
%compute the distances to the origin (Note: -0)
distances = sqrt(P(1,:).^2+P(2,:).^2);
%form the scaling factor
s = sqrt(2) / mean(distances);
T2 = [ s 0 0 ; 0 s 0 ; 0 0 1 ];
%Combine both transformations
T = T2 * T1;
end


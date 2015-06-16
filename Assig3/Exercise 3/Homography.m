function H = dlt( x1, x2 )
%1.normalize
U = getNormalizationMatrix(x1);
x1=U*x1;
T = getNormalizationMatrix(x2);
x2=T*x2;
%2.perform dlt
%get the number of points
n = size( x1, 2 );

A=[];

for i=1:n
    x_pr = x2( 1, i );
    y_pr = x2( 2, i );
    w_pr = x2( 3, i );
    x = x1( :, i );

    Ai = [ 0, 0, 0,    -w_pr * x',   y_pr * x' ;
           w_pr * x',     0, 0, 0,  -x_pr * x' ];
    A = [ A ; Ai ];
end

%singular value decomposition
[u,d,v] = svd( A );
H=reshape(v(:,9),3,3);
%3.denormalize
H=H';
H=T\H*U;
H=H/H(3,3);
end


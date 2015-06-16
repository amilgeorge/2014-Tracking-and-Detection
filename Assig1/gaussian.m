function [out1] = gaussian(sigma)
dim=int8(3*sigma);

midDim=(dim+1)/2;
for i=1:dim  
     x = i-(midDim);
    for j=1:dim
        y = j-(midDim);
        %disp(x);
        %disp(y);
        %den = double(2.0*sigma*sigma);
        %num = double(double(-(x*x+y*y)))
        %abc = num/den;
        %disp(abc);
        pow = double(-(x*x+y*y))/double(2.0*sigma*sigma);
        A(i,j)=exp(pow)/(2.0*pi*sigma*sigma);
        %disp(temp);
        
       
        
    end
    
end
%disp(A);
out1=A/sum(A(:));

end

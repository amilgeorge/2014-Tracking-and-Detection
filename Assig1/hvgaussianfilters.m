function [hfilter,vfilter] =hvgaussianfilters(sigma)
dim=int8(3*sigma);
midDim=(dim+1)/2;
for i=1:dim 
     x = i-(midDim);
     pow = double(-(x*x))/double(2.0*sigma*sigma);
        val=exp(pow)/sqrt(2.0*pi*sigma*sigma);
        A(i,1)=val;
        B(1,i)=val;
end
hfilter = B/sum(B(:))
vfilter = A/sum(A(:))

end
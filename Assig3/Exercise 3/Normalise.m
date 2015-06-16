function nx = Normalise(x)    
[rows,npts] = size(x);
nx = x;
% indices of points not at infinity
finiteind = find(abs(x(rows,:)) > eps);
if length(finiteind) ~= npts
    warning('Some points are at infinity');
end
% Normalise points that are not at infinity
for r = 1:rows-1
nx(r,finiteind) = x(r,finiteind)./x(rows,finiteind);
end
nx(rows,finiteind) = 1;
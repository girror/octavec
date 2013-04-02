function y = chebseries(c,x)
% Input
% c matrix of coefficients size m * n
% x vector of values size 1 by p
% Output matrix y size m by p
% y(r,s) = sum(c(r,j)* T(j-1, x), j=1..n)
m = size(c,1);
n = size(c,2);
p = size(x,2);
a=zeros(m,p);
b=zeros(m,p);
d=zeros(m,p);
xx = ones(m,1)*x;
for k=n:-1:1
  d=b;
  b=a;
  a = c(:,k)*ones(1,p)+ 2 * (b .* xx) - d;
end

y = a - (b .* xx);

   

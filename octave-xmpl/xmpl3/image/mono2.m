function img = mono2(r,g,b)
[n,m] = size(r);
img = zeros(n,m);
img(1:n,1:m) = 0.3*r(1:n,1:m) + 0.6*g(1:n,1:m) +0.1*b(1:n,1:m);

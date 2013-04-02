function img = mono1(r,g,b)
    [n,m] = size(r);
 
    img = zeros(n,m);
 
    for i = 1:n
        for j = 1:m
            img(i,j) = 0.3*r(i,j) + 0.6*g(i,j) +0.1*b(i,j);
        end
    end
end

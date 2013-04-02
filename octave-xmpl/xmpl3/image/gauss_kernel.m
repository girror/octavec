function kernel = gauss_kernel(radius)

radius = radius + 1 ;
size = radius*2 + 1 ;

for k = 1:size
  kernel(k) = exp(-0.5*(((k-radius)/(radius*2))^2)/(0.2^2)) ;
end

for j = 1:size-2
  kernel2(j) = kernel(j+1) ;
end

if (length(kernel2)==1)
  kernel2(1) = 1 ;
end


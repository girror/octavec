tic
b = zeros(1,1001);
for x = 1:1000
  b(x) = b(x+1) ;
end
toc

tic
b = zeros(1,1001);
for x = 1000:1
  b(x) = b(x+1) ;
end
toc

tic
b = zeros(1,1001);
b(1:1000) = b(2:1001);
toc
  
  

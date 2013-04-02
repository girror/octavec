function test_vec1
  dx = pi/30;
  nx = 1 + 2*pi/dx;
  for i = 1:nx
     x(i) = (i-1)*dx;
     y(i) = sin(3*x(i));
  end
end


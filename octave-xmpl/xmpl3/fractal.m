function fractal
   x = zeros(1,12000);
   y = x;
   for i = 2:12000
      x(i) = y(i-1)*(1+sin(0.7*x(i-1))) - 1.2*sqrt(abs(x(i-1)));
      y(i) = 0.21 - x(i-1);
   end
end

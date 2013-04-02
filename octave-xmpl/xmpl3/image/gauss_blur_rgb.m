function [r, g, b ] = gauss_blur_rgb(r,g,b,kernel)
  r =  gauss_blur(r,kernel);
  g =  gauss_blur(g,kernel);
  b =  gauss_blur(b,kernel);
end

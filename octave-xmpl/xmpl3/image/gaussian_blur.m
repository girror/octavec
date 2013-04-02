function [r, g, b] = gaussian_blur(r, g, b, radius)
  kernel = gauss_kernel(radius) ;

  [r, g, b] = gauss_blur_rgb(r, g, b, kernel);

end

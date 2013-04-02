function [r, g, b] = convolve_rgb(r, g, b, kernel, kw, kh)
  r = convolve(r, kernel, kw, kh);
  g = convolve(g, kernel, kw, kh);
  b = convolve(b, kernel, kw, kh);
end

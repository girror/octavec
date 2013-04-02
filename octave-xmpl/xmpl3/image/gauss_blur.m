function img_new = gauss_blur(img, kernel)
  img_new = convolve(img, kernel, length(kernel), 1);
  img_new = convolve(img_new, kernel, 1, length(kernel));
end

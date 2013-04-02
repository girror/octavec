function p = get_pixel(x, y, img, width, height)

  if (x <= 0) x = 0 ;
  end
  if (x >= width) x = width - 1 ;
  end
  if (y <= 0) y = 0 ;
  end
  if (y >= height) y = height-1 ;
  end

  p = img(x + y*width + 1) ;
end

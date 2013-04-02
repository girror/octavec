function img_new = convolve(img, kernel, kw, kh)
  [width, height] = size(img) ;

  normalize = true;

  x1 = 1 ; y1 = 1 ;
  x2 = width ; y2 = height ;
  
  uc = floor(kw/2) ;
  vc = floor(kh/2) ;

  img_new = img ;

  scale = 1.0 ;

  if(normalize)
    sum = 0.0 ;
    for z = 1:length(kernel)
      sum = sum + kernel(z) ;
    end
    if(sum != 0.0)
      scale = 1.0 / sum ;
    end
  end

  xedge = width - uc ;
  yedge = height - vc ;


  sum = zeros(x2,y2);

  for y = y1:y2
    for x = x1:x2
      i = 1 ;
      edge_pixel = y<vc || y>=yedge || x<uc || x>=xedge ;
      for v = -vc:vc
	for u = -uc:uc
	  if edge_pixel
	    sum(x,y) = sum(x,y) + get_pixel(x + u, y + v, img, width, height)*kernel(i++) ;
	  else
	    sum(x,y) = sum(x,y) + img(x+u+1,y+v+1)*kernel(i++);
	  end
	end
      end
    end
  end

  for y = y1:y2
    for x = x1:x2
      img_new(x,y) = sum(x,y)*scale;
    end
  end
%  img_new(x1:x2,y1:y2) = sum(x1:x2,y1:y2)*scale;
end

function data = puncturing (x, y)

  fprintf ('    puncturing (%d)\n', length(x));

  global PUNCTURING_MODE;

  switch PUNCTURING_MODE
    case 1/2
      data=zeros(2*length(x),1);
      for i = 1:length(x)
	data(2*(i-1)+1) = x(i);
	data(2*(i-1)+2) = y(i);
      end
    case 2/3
      data=zeros(3*length(x)/2,1);
      for i = 1:2:length(x)
	data(3*(i-1)/2+1) = x(i);
	data(3*(i-1)/2+2) = y(i);
	data(3*(i-1)/2+3) = y(i+1);
      end
    otherwise
      fprintf ('puncturing mode %g not implemented.\n', PUNCTURING_MODE);
      return
  end

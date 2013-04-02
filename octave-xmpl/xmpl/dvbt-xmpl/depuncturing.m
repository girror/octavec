function [x, y] = depuncturing (data)

  fprintf ('    depuncturing (%d)\n', length(data));

  global PUNCTURING_MODE;

  switch PUNCTURING_MODE
    case 1/2
      x=zeros(length(data)/2,1);
      y=zeros(length(data)/2,1);

      for i = 1:length(x)
	x(i) = data(2*(i-1)+1);
	y(i) = data(2*(i-1)+2);
      end
      
    case 2/3
      x=zeros(2*length(data)/3,1);
      y=zeros(2*length(data)/3,1);

      for i = 1:2:length(x)
	x(i+0) = data(3*(i-1)/2+1);
	x(i+1) = 0.5;
	y(i+0) = data(3*(i-1)/2+2);
	y(i+1) = data(3*(i-1)/2+3);
      end

    otherwise
      fprintf ('puncturing mode %g not implemented.\n', PUNCTURING_MODE);
      return
  end

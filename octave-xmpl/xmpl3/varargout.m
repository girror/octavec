function [a, ...] = tt(i)
  a= 1 ;
  varargout{1} = 2 ; 
  varargout{2} = 3+i;
end
[asd, b] = tt(12)
[asd, b, c] = tt(12)
asd = tt(12)

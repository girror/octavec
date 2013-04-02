function x = cinco(x, y)
 
  usage_msg = "rem (x, y)";
 
  if (nargin != 2)
    usage (usage_msg);
  endif
 
  if (any (size (x) != size (y)) && ! (is_scalar (x) || is_scalar (y)))
    error ("rem: argument sizes must agree");
  endif
 
  ## Matlab allows complex arguments, but as far as I can tell, that's a
  ## bunch of hooey.
 
  if (any (any (imag (x))) || any (any (imag (y))))
    error ("rem: complex arguments are not allowed");
  endif
 
  if (nargin == 2)
    retval = x - y .* fix (x ./ y);
  else
    error (usage_msg);
  endif
 
endfunction
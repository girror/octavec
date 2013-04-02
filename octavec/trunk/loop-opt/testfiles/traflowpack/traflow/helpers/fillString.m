function retval = fillString(txt,bw,sym)
  if(sym==1)
    retval =  sprintf(" ");
    for i = 1:(bw-4-txt)
      retval = sprintf("%s ",retval);
    endfor
    else
    retval = sprintf("+");
    for i = 1:(bw-2)
      if(i==(bw-2))
        retval = sprintf("%s--+",retval);
      else
        retval = sprintf("%s-",retval);
      endif
    endfor
  endif
endfunction

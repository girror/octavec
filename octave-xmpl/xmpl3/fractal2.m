## Generates a fractal signal of lenght N
##=================================================================================
## Author:  Jose Luis Hernandez Caceres (2000) <cacerjlh@yahoo.com>
##================================================================================
function [senhal]=fractal2 (N)
   beta=2
   for r=1:N
      sp(r)=sqrt(100*r^(-beta));
   endfor;
   fase=2*pi*rand(N,1);
   for r=1:N
      z(r)=sin(fase(r))*sp(r)+cos(fase(r))*sp(r)*sqrt(-1);
   endfor;
   ift=ifft(z);
   senhal=real(ift);
   senhal=senhal';
   plot(senhal)
endfunction
fractal2(10000) ;

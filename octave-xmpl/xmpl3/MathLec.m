function MathLec
% ------------------ a percent sign makes the rest of line a comment -------------
%
%
% (0)  This file should work well with MatLab 5+ and Octave 2.1.35+
%
% (1)  At the prompt, you may change directory by typing
%      cd directory_name (e.g. e:\mystuff in MatLab and /cygdrive/e/mystuff in Octave)
%
% (2)  Don't know in which directory you are? Type pwd and hit Return.
%
% (3)  To see the files in the current directory, type dir and hit Return.
%
% (4)  Change this file in a text editor.
%
% (5)  To execute this program from the command line: type MathLec and hit Return.
%
% (6)  Clear the memory between runs of the program: type clear and hit Return.
%
% (7)  Leave MatLab or Octave: type exit and hit Return.
%
%
%  Paul Söderlind (Paul.Soderlind@hhs.se), revised Nov 2002
%-------------------------------------------------------------------------


diary('MathLec.out');                %printing: to screen AND the file MathLec.out

disp('---------------------- How to load data from ascii file ---------------');
disp(' ');      %print a blank line

%The following is a portion of MathLec.txt (percentage signs added here):
%1861   10.094   9.998   -999.99
%1862   10.128   9.994   0.037
%1863   10.156  10.044   0.092
%1864   10.176  10.061   0.098


x   = load('MathLec.txt');        %loading into matrix, semicolon (;) to suppress printing
vvi = find( x == -999.99);        %find indices of all -999.99
x(vvi) = NaN;                     %all -999.99 to NaN
year = x(:,1);                    %picking out first column
lnY  = ...                        %MatLab commands continue until line break,
       x(:,2);                    %A multiline command is created by using ...
lnC  = x(:,3);                    %at end of line
R    = x(:,4);

disp('--------------------- create matrix, some math, OLS -------------------');
disp(' ');                        %disp(x) prints x and a line break


Q = 1;
q = [ 1,2,3;                      %create 2x3 matrix
      4,5,6 ];                    %note: no ... is needed within [ ]
disp(' ');disp('Q');disp(Q);      %print matrix
disp(' ');disp('q');disp(q);      %MatLab IS case sensitive

q2 = reshape(q,3,2);              %reshaping q to 3 rows, 2 columns
disp(' ');disp('q2');disp(q2)  ;  %works columnwise

p   = (1:10:21)';                 %creating sequence of 1,11,21
disp(' ');disp('p'); disp(p);

z   = [q; (p')];                  %transposing p, concatenating vertically with q
disp(' ');disp('z'); disp(z);

z3a = z^3;                        %matrix power, like z*z*z
disp(' ');disp('z3a=z^3'); disp(z3a);

z3b = z.^3;                       %element-by-element power, like z.*z.*z
disp(' ');disp('z3b=z.^3'); disp(z3b);


w  = [ 10,11,12;                  %create 2x3 matrix
       13,14,15 ];
disp(' ');disp('q');disp(q);
disp(' ');disp('w');disp(w);

y1 = q + w;                       %matrix addition
disp(' ');disp('y1=q + w');disp(y1);

y2 = q.*w;                           %element-by-element multiplication
disp(' ');disp('y2=q.*w');disp(y2);  %element-by-element operators (eg. x.*y) work
                                     %if x is scalar and y matrix, or
                                     %x and y are both TxK



ett = ones( size(lnY,1),1 );      %a vector with ones, #rows from variable
x = [ett, lnY];                   %x is Tx2 matrix
y   = lnC;                        %just to get standard OLS notation
b   = inv(x'*x)*x'*y;             %OLS. x'x doesn't work; use x'*x
u   = y - x*b;                    %OLS residuals
R2  = 1 - u'*u/(  (y-mean(y))'*(y-mean(y)) );
disp(' ');disp('OLS coefficients');
disp(b);
disp(' ');disp('R2');
disp(R2);


lambda = eig(  cov([lnC,lnY]) );  %eigenvalues of covariance matrix
x_05   = chol( cov([lnC,lnY]) );  %cholesky decomposition    ""

x = lnC(1) + R(1);
if isnan(x) == 1;                 %check if NaN
  disp(' ');disp('lnC(1) or r(1) contains a missing value');
end;


x = randn(100,3);                 %matrix of random draws from N(0,1)
disp(' ');disp('Mean and Std of random draws from N(0,1): ');
disp(mean(x));          %mean of each column in matrix, gives row vector
disp(std(x));


disp('---------------------- Writing a loop ---------------------------------');
disp(' ');

i = 1;
x = 0;
while i <= 10;
  x = x + i;
  disp(x);
  i = i + 1;
end;

disp('-------------------- Writing nested loops -----------------------------');
disp(' ');
disp('Calculate vech(x) of square matrix x');

x = reshape(1:9,3,3);             %generate square matrix
[m,n] = size(x);                  %find #rows and #column

v = zeros(n*(n+1)/2,1);           %to put results in
k = 1;
for j = 1:n;                      %loop over columns in x
  for i = j:n;                    %loop over rows on and below diagonal
    v(k) = x(i,j);
    k = k + 1;                    %update index in v
  end;
end;

disp(' ');disp('Original matrix: ');
disp(x);
disp(' ');disp('vech of the matrix: ');
disp(v);

disp('---------------------- Functions --------------------------------------');
disp(' ');

x = 1;
disp('x before proc: ');          %a function must be defined in its own file
disp(x);                          %one function per file, same name as function
x = MathLecB( x,2,3 );            %calling on function in file MathLecB.m


disp(' ');disp('x from proc: ');
disp(x);                    %note how the value of x is changed


disp('---------------------- Graphs -----------------------------------------');
disp(' ');

t = (-3:6/99:6)';

  title('Result from MathLecC and 3cos(t)');
  xlabel('t');
#  plot( t,MathLecC(t),'-1;From MathLecC;',t,(3*cos(t)),'-2;3cos(t);' );
  disp(' ');disp('Program is paused. Take a look at the figure, perhaps print, then hit any key');
#  pause;
#  closeplot;
  title('The second figure');
  xlabel('t');
#  plot( t,exp(t),';;' );              %';;' gives default line and no legend
  disp(' ');disp('Program is paused. Take a look at the figure, perhaps print, then hit any key');
#  pause;


disp('---------------------- Extra: optimization ----------------------------');
disp(' ');

  disp('Octave has no built-in optimization routine, see http://octave.sourceforge.net/')


disp('------------------ More advanced graphs -------------------------------');
disp(' ');

b = linspace(-3,3,20)';
c = linspace(1,7,25)';

loss1 = 2*b.^2;
loss2 = repmat(NaN,length(b),length(c)); %mesh(c,b,loss2) wants loss2 to be length(b) x length(c)
for j = 1:length(c);                     %create loss2 column by column
  loss2(:,j) = 2*b.^2 + (c(j)-4)^2 - 0.0*b.*(c(j)-4);
end;

#  closeplot;
  gnuplot_has_multiplot = 1;      %tell Octave that gnuplot can do multiplots
  automatic_replot = 0;
  %gset('terminal postscript eps monochrome');    %uncomment if you want eps file with figure
  %gset('output \"mathlec.eps\"');                %uncomment if you want eps file with figure
#  multiplot(2,2);                 %2x2 multiplot on a page
  gset('nokey');                  %no automatic legends
  title('Line plot');
    axis([-3,3,0,20]);
#    mplot(b,loss1);
  title('Bar plot');
#    [xb,yb] = bar(b,loss1);
    axis([-3,3,0,20]);
#    mplot(xb,yb);
  title('Stairs plot');
#    [xb,yb] = stairs(b,loss1);
    axis([-3,3,0,20]);
#    mplot(xb,yb);
  title('Mesh plot');
    axis([1,7,-3,3,0,30]);
#    mesh(c,b,loss2);              %note the order of c and b
#  multiplot(0,0);
  gset('key');
  automatic_replot = 1;

disp('---------------------- cleaning up after program ----------------------');
disp(' ');

diary off;                        %close te output file


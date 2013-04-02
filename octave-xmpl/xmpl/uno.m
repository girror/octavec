function x = uno (i)    
  i = 7;
  a = 1:10
  [n,m] = size(a)
  g = is_bool(m)
  disp(zeros(2,3))
  x = 4.6
  v = 0.7
  for j = a
   a(j) = v + a(j)
   v = v++
  end
 gg = [1:10] 
 b = 1:10
 c = 1:10
 dd = [1.2:1:10]
  for i = 1:1:10
     c(i) = a(i) + b(i)
  end
 mm = zeros(4,5)
 ff = find(mm)
 bb = (6 != a) 
 ag = (5 * ones(1,9))'
 x = 9 + x
 v = x + 8 + v 
 table = (NaN * ones ( 256 , 1 ))
 rt = is_scalar(c)
 fr = is_scalar(3)
 st = is_scalar('sfsf')
 ee = fix(4)
 WW = fix(6.7)
 mat = fix([2.3,5.6])
 table = (NaN * ones ( 256 , 1 )) 
 symbols = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'  
 base = 16   
 rr = flipud ( [ 1 2 ; 3 4 ] )
 d = '47'  
 j = tolower(d)
xx = [1,2,4]
yy = 6
retvals = xx - yy .* fix ( xx ./ yy )   

#d = strjust ( d , 'right' )     
#table ( toascii ( symbols ( 1 : 1 : base ) ) ) = 0 : 1 : base - 1
#table ( toascii ( ' ' ) ) = 0 
#d = reshape ( table ( toascii ( d ) ) , size ( d ) ) 
#out = (d * base .^ ( columns ( d ) - 1 : - 1 : 0 )')
#disp(out)  
#k = [size(d), size(d)]
bbb = base2dec ( '47' , 16 )   
endfunction    
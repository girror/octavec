function constants_tb
# Load function
#source("constants.m");

# Evaluate function
#disp(constants(5))

#a = 6.4
#b = 3
#y = a + b

#x = (45 + 5 ) /4

#c = 4 + 6 * 2
#disp(constants(c))


#r = 1:3:11
#rr = 1:1:45.5
#rrr = 1.2:1:10.4

#y = 0 - 5i  
#g = 5 + 3i * 4

#a = 6
#k = []
#q = [1,2,3] 
#g = [1,3,5.6; 4.5,6.7, 8]

#a = "sdf"
#b = "raa"
#c = "eee"
#t = [a,b,c]
#g = [a;b;c]

#aa = [1,2]
#bb = [5,6]
#cc = [10,11]
#f = [aa; bb;cc]



#[x,y] = size([1,2,3])

%s = "abc"  CHECK THIS
%b = "ddd"
%c(1) = s(1)

#[[1];[2];[3]]
#b =  [1,2,3] * 7 

#a = ones(3,2) * zeros(2,3)


a = [[2,3]; [3,4]; [4,5]] * [ [3,4,5]; [15,16,17]]  


#a = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16; 4,5,6,7,8,9,10,1,12,13,14,15,16,17,18,19]

#a(1:1:2,1:2:8)
#c = a(:,:) 


a = [4,5,6]  
a(1,1,1) = 5     

%a(:,:,:,4,1,1) = ones(2,3,4)
%b=a

#r = rand(3,4)
#c = cat(5, ones(2, 3, 4), rand(2,3,4));

#a = ones(3,4,5)
#a(:)


% subscripts
#a = rand(3,2,4)
#d = a(1:2:3,:,:)

#a = 3
#d = a(1)


#a = ones(3,4,5)
#b = a(:)

%a(3,[2,5],1,1) = 8 NEEDS AN UPDATE
#a(3,5,1,1) = 8


%ranges
#(1:1:1)
#(1:1:2)
#(1:-1:0)
#(1:1:0)
#a = (1:0:45)

#a = [1,2,3]
#for x = a disp(x) endfor

#  n = 5
#  for i = 1:1:n
#    c(i) = 5
#  end

#e(2) = 4


##a = ones(1,5)
##for x = a
#####  c(x) = a(x)
##end

###a.x = {}
###a.x.y = "sfsd" 
###a.x.y(:)

#disp(a.x.y) 

#a.f = [1, 2 5; 4 5 2]
#a.g = [5, 4 3; 2 8 4 ]
#t =  a.f  / a.g

#x = zeros(1)


#b = 4
#a = 5
#c = a+b
#d = a*b
#e = a/b 
#f = a-b 

#b = 4.5
#a = 5.8
#c = a+b
#d = a*b
#e = a/b
#f = a-b 

#a = 4.5
#b = 5
#c = a+b
#d = a*b
#e = a/b
#f = a-b 


#a = [4 4; 5 5] * [4 4; 5 5] 
#b = 5
#c = a+b
#d = a*b
#e = a/b
#f = a-b



#a = [4 4 4; 5 5 5] * [1 1 ; 1 1; 1 1] 
#b = [2,3; 5,6] * [1  ; 1 ] 
#c = a + b

#d = a*b
#e = a/b
#f = a-b


#r = abs([2,3,4])
#s = abs(r(2))

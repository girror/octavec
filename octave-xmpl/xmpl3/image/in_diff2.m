function img_new = in_diff2(img)

[n,m] = size(img);
img_new=zeros(n,m);
%img_new(1:n-1,1:m-1) = img(1:n-1,1:m-1) - img(2:n,1:m-1);
img_new1(1:n-1,1:m-1) = ( ( (img(1:n-1,1:m-1) - img(2:n,1:m-1)) + (img(1:n-1,2:m) - img(2:n,2:m)) ) / 2 ) .^ 2 ;
img_new2(1:n-1,1:m-1) = ( ( (img(1:n-1,1:m-1) - img(1:n-1,2:m)) + (img(2:n,1:m-1) - img(2:n,2:m)) ) / 2 ) .^ 2 ;
img_new(1:n-1,1:m-1) = sqrt((img_new1(1:n-1,1:m-1) + img_new2(1:n-1,1:m-1) ) / 2) ;

end

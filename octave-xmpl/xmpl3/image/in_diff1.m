function img_new = in_diff1(img)

[n,m] = size(img);

img_new=zeros(n,m);

for i = 1:n-1
  for j = 1:m-1
    img_new1(i,j) = ( ( (img(i,j) - img(i+1,j)) + (img(i,j+1) - img(i+1,j+1)) ) / 2 ) ^ 2 ; 
    img_new2(i,j) = ( ( (img(i,j) - img(i,j+1)) + (img(i+1,j) - img(i+1,j+1)) ) / 2 ) ^ 2 ;
    img_new(i,j) = sqrt((img_new1(i,j) + img_new2(i,j) ) / 2) ;
  end
end

end

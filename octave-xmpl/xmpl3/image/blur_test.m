[r, g, b] = imread("./tmp.bmp") ;
[r, g, b] = gaussian_blur(r, g, b, 5) ;

imwrite("./test-new.jpg", r, g, b);
%system("display ./test-new.jpg");

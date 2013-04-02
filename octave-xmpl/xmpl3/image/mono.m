[r,g,b] = imread("./test.jpg") ;

tic;
t1 = mono1(r,g,b);
tt1 = toc ;

tic;
t2 = mono2(r,g,b);
tt2 = toc ;

if(t1==t2) 
  disp(["succeeded monochrome : " num2str(tt1) "s vs " num2str(tt2) "s"]);
else
  disp("failed monochrome");
end

tic;
t1 = in_diff1(t1);
tt1 = toc ;

tic;
t2 = in_diff2(t2);
tt2 = toc ;

if(t1==t2) 
  disp(["succeeded intensity diff : " num2str(tt1) "s vs " num2str(tt2) "s"]);
else
  disp("failed intensity diff");
end

imwrite("./test-new.jpg",give_edge(t2,40));

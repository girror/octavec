runs = 3 ;
cumulate = 0; b = 0;
for i = 1:runs
  a = abs(randn(800, 800)/2);
#  tic; 
    b = a.^1000; 
#  timing = toc;
#  cumulate = cumulate + timing;
end
#timing = cumulate/runs;
#times(2, 1) = timing;
#disp(num2str(timing))


runs = 3;
cumulate = 0; a = 0; b = 0;
for i = 1:runs
  tic;
    a = abs(randn(1500, 1500)/10);
    b = a';
    a = reshape(b, 750, 3000);
    b = a';
  timing = toc;
  cumulate = cumulate + timing;
end;
timing = cumulate/runs;
times(1, 1) = timing;
disp(num2str(timing))


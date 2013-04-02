function img = give_edge(x,threshold)
  [n,m] = size(x);
  for i = 1:n
    for j = 1:m
      if x(i,j) < threshold
        img(i,j) = 255;
      else
        img(i,j) = 0;
      end
    end
  end
end

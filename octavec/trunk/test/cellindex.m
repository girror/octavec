function ret = cellindex
  c = {1 2 3 4 5};
  c{1} = 5;
  c{2} = c{4};
  t = c{2};
  t == 4;
  c{4} = 10;
  c{2,2} = "moooi";
  t1 = c{:};
  ret = true;
end

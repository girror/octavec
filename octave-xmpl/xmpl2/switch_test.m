function x = switch_test

  switch 5
    case (1)
      x = 1;
    case (2)
      x = 2;
    case (3)
      x = 4;
    otherwise 
      x = 80;
  end
  x = x + 1
end

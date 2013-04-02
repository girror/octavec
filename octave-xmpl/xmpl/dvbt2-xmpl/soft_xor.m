function x = soft_xor (a, b)

  if b < 0.5
    x = a;
  elseif a == 0.5
    x = 0.5;
  elseif b > 0.5
    x = 1-a;
  end

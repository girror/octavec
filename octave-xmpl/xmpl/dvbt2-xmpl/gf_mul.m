function result = gf_mul (a,b)

  global GFLOG;
  global GFEXP;

  if a == 0 | b == 0
    result = 0;
  else
    log_result = GFLOG(a) + GFLOG(b);
    while log_result > length(GFEXP)
      log_result = log_result - length(GFEXP);
    end
    result = GFEXP(log_result);
  end
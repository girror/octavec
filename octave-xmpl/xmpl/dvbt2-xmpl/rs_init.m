function rs_init (alpha, t)

  global RS_GENERATOR;

  RS_GENERATOR=zeros(2*t+1,1);
  % RS_GENERATOR = x + alpha
  RS_GENERATOR(1) = alpha;
  RS_GENERATOR(2) = 1;

  for k = 3:2*t+1
    
    RS_GENERATOR(k) = 1;

    for l = k-1:-1:2
      RS_GENERATOR(l) = gf_add(RS_GENERATOR(l-1), ...
			       gf_mul(alpha, RS_GENERATOR(l)));
    end

    RS_GENERATOR(1) = gf_mul(alpha, RS_GENERATOR(1));
    
  end
  
  
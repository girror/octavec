function gf_init (field_generator_coeff)

  global GFLOG;
  global GFEXP;
  
  field_generator_coeff=sort(field_generator_coeff);
  
  w=max(field_generator_coeff);
  n=2^w;
  
  field_generator=zeros(1,w+1);
  for k = 1:length(field_generator_coeff)
    field_generator(1+field_generator_coeff(k)) = 1;
  end

  GFLOG=zeros(n-1,1);
  GFEXP=zeros(n-1,1);
  
  pe=zeros(1,w+1);
  pe(1)=1;
  
  for k = 1:n-1
    value=0;
    for l = 0:w-1
      if pe(1+l) == 1
	value = value + 2^l;
      end
    end
    GFEXP(k)=value;
    GFLOG(value)=k;

    pe=[0 pe(1:w)];
    if pe(w+1) == 1
      pe = xor(pe, field_generator);
    end
  end
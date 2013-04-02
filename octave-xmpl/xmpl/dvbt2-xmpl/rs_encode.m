function data_out = rs_encode (data_in)

  fprintf ('    rs_encode (%d)\n', length(data_in));

  global PACKET_LENGTH;
  global RS_PARITY_BYTES;

  d = RS_PARITY_BYTES;

  parity=zeros(d,1);

  data = [data_in ; zeros(239-length(data_in), 1)];

  for k = length(data):-1:1
    feedback = gf_add (data(k), parity(d));

    if feedback ~= 0
      for l = d:-1:2
	parity (l) = gf_add (parity(l-1), ...
			     gf_mul (feedback, parity(l)));
      end
      parity (1) = gf_mul (feedback, parity(l-1));
    else
      parity = [0 ; parity(1:d-1)];
    end
  end
  
  data_out=[data_in ; parity];
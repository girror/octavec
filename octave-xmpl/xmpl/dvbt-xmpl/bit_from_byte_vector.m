function data_out = bit_from_byte_vector (data_in)

  fprintf ('    bit_from_byte_vector (%d)\n', length(data_in));

  % make big-endian bit-vector from byte-vector
  data_out=zeros(length(data_in)*8,1);
  for i = 1:length(data_in)
    data_byte=data_in(i);
    for j = 1:8
      if data_byte >= 127.5
	data_out(8*(i-1)+j)=1.0;
      end
      data_byte=rem(data_byte,128)*2;
    end
  end

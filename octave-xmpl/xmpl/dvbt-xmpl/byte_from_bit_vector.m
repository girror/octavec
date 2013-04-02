function data_out = byte_from_bit_vector (data_in)

  fprintf ('    byte_from_bit_vector (%d)\n', length(data_in));

  % make byte-vector from big-endian bit-vector
  data_out=zeros(length(data_in)/8,1);
  for i = 1:length(data_out)
    data_byte=0;
    for j = 1:8
      if data_in(8*(i-1)+j) <= 0.5
	data_bit=0;
      else
	data_bit=1;
      end
      data_byte=2*data_byte + data_bit;
    end
    data_out(i)=data_byte;
  end
  
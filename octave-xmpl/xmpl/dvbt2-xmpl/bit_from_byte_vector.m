function data_out = bit_from_byte_vector (data_in)
% bit_from_byte_vector convert byte vector into bit vector
%
% bit_vector = bit_from_byte_vector(byte_vector) takes a vector
% of numbers ranging from 0.0 to 255.0. These numbers are converted
% to a vector of bits 8 times the length of the input vector.
% The bytes are processed in big-endian manner
%
% See also byte_from_bit_vector.

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

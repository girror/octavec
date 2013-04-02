function data_out = byte_from_bit_vector (data_in)
% bit_from_byte_vector convert bit vector into byte vector
%
% byte_vector = byte_from_bit_vector(bit_vector) takes a vector
% of soft bits, i.e., floating point numbers with values of 0.0
% or 1.0. This vector of bits is converted into a vector of
% big-endian bytes, i.e., a vector of numbers ranging from 0.0
% 255.0. The output vector has a length of 1/8th of the input
% vector.
%
% See also bit_from_byte_vector

  % make byte-vector from big-endian bit-vector
  data_out=zeros(ceil(length(data_in)/8),1);
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
  
function result = byte_xor (byte_vector1, byte_vector2)

  fprintf('      byte_xor\n');
  
  result=byte_vector1;

  for i=1:length(byte_vector1)
    byte1=byte_vector1(i);
    byte2=byte_vector2(i);
    result_byte=0;
    for j = 1:8
      bit1=rem(byte1,2);
      bit2=rem(byte2,2);
      result_bit=xor(bit1,bit2);
      result_byte=result_byte + result_bit*2^(j-1);
      byte1=fix(byte1/2);
      byte2=fix(byte2/2);
    end
    result(i)=result_byte;
  end
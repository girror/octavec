function [sequence, prbs_register_out] = prbs_sequence (byte_length, prbs_register)

  fprintf('      prbs_sequence\n');

  bit_length=8*byte_length;

  bit_sequence=zeros(bit_length,1);
  for i = 1:bit_length
    new_bit=xor(prbs_register(14),prbs_register(15));
    prbs_register=[new_bit prbs_register(1:14)];
    bit_sequence(i)=new_bit;
  end

  sequence=zeros(1,byte_length);
  for i = 1:byte_length
    for j = 1:8
      sequence(i)=sequence(i)+bit_sequence(8*(i-1)+j)*2^(8-j);
    end
  end

  prbs_register_out=prbs_register;
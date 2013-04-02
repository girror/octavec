function data_out = outer_interleave (data_in)

  fprintf ('    outer_interleave (%d)\n', length(data_in));

  global PACKET_LENGTH RS_PARITY_BYTES;
  global OI_I OI_M;
  global SEND_OI_STATE;
  global SEND_OI_POINTER;

  [num_bytes should_be_one] = size(data_in);
  data_out=zeros(num_bytes,1);
  for i = 1:num_bytes
    byte = data_in(i);

    k = SEND_OI_POINTER;
    q = k*OI_M;
    SEND_OI_STATE(1+k,1:q+1) = [byte SEND_OI_STATE(1+k,1:q)];
    data_out(i) = SEND_OI_STATE(1+k,q+1);
    
    SEND_OI_POINTER = rem(SEND_OI_POINTER+1,OI_I);
  end
  
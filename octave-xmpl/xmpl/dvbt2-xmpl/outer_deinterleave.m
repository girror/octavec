function data_out = outer_deinterleave (data_in)

  fprintf ('    outer_deinterleave (%d)\n', length(data_in));

  global PACKET_LENGTH RS_PARITY_BYTES;
  global OI_I OI_M;
  global RECEIVE_OI_STATE;
  global RECEIVE_OI_POINTER;

  [num_bytes should_be_one] = size(data_in);
  data_out=zeros(num_bytes,1);
  for i = 1:num_bytes
    byte = data_in(i);

    k = RECEIVE_OI_POINTER;
    q = (OI_I-k-1)*OI_M;
    RECEIVE_OI_STATE(1+k,1:q+1) = [byte RECEIVE_OI_STATE(1+k,1:q)];
    data_out(i) = RECEIVE_OI_STATE(1+k,q+1);
    
    RECEIVE_OI_POINTER = rem(RECEIVE_OI_POINTER+1,OI_I);
  end
  
function data_out = outer_deinterleave (data_in)

  fprintf ('    outer_deinterleave (%d)\n', length(data_in));

  global PACKET_LENGTH RS_PARITY_BYTES;
  global OI_I OI_M;

  data=reshape(data_in, OI_M, OI_I);
  data_out=reshape(data.', PACKET_LENGTH+RS_PARITY_BYTES, 1);


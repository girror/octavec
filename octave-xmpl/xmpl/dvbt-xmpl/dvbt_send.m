function data_channel_in = dvbt_send (data_in)

  fprintf('  dvbt_send (%d)\n', length(data_in));

  global PACKETS_PER_PRBS_PERIOD;
  
  global dvbt_send_current_packet;
  global dvbt_send_prbs_register;
  global dvbt_send_conv_regigster;

  dvbt_send_current_packet=0;

  data=data_in;
  
  data = sync_and_scramble (data);
  data = rs_encode (data);
  data = outer_interleave (data);
  data = bit_from_byte_vector (data);
  [x, y] = convolutional_encode (data);
  data = puncturing (x, y);

  data_channel_in = data;

  dvbt_send_current_packet=rem(dvbt_send_current_packet+1,...
			       PACKETS_PER_PRBS_PERIOD);

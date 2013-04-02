function data_out = dvbt_receive (data_channel_out)

  fprintf('  dvbt_receive (%d)\n', length(data_channel_out));

  global PACKETS_PER_PRBS_PERIOD;
  
  global dvbt_receive_current_packet;
  global dvbt_receive_prbs_register;
  global dvbt_receive_conv_regigster;

  dvbt_receive_current_packet=0;

  data=data_channel_out;

  [x, y] = depuncturing (data);
  data = convolutional_decode (x, y);
  data = byte_from_bit_vector (data);
  data = outer_deinterleave (data);
  data = rs_decode (data);
  data = remove_sync_and_unscramble (data);
  
  data_out=data;

  dvbt_receive_current_packet=rem(dvbt_receive_current_packet+1,...
				  PACKETS_PER_PRBS_PERIOD);

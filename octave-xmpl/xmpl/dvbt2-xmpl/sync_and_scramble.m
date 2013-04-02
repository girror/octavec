function data_out = sync_and_scramble (data_in)

  fprintf ('    sync_and_scramble (%d)\n', length(data_in));

  global PACKET_LENGTH NET_PACKET_LENGTH;
  global PACKETS_PER_PRBS_PERIOD;
  global SYNC_BYTE_VALUE INV_SYNC_BYTE_VALUE;
  global INIT_PRBS_REGISTER;

  global dvbt_send_current_packet;
  global dvbt_send_prbs_register;
  global dvbt_send_convolution_state;

  if dvbt_send_current_packet == 0
    dvbt_send_prbs_register=INIT_PRBS_REGISTER;
    sync_byte=INV_SYNC_BYTE_VALUE;
  else
    dvbt_send_current_packet(1);
    sync_byte=SYNC_BYTE_VALUE;
  end
    
  [prbs, dvbt_send_prbs_register] = prbs_sequence...
      (NET_PACKET_LENGTH, dvbt_send_prbs_register);
  
  data_out=[sync_byte ; byte_xor(data_in,prbs)];
  
  dvbt_send_current_packet=rem(dvbt_send_current_packet+1,...
			       PACKETS_PER_PRBS_PERIOD);
  
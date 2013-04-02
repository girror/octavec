function data_out = remove_sync_and_unscramble (data_in)

  fprintf ('    remove_sync_and_unscramble (%d)\n', length(data_in));

  global PACKET_LENGTH NET_PACKET_LENGTH;
  global PACKETS_PER_PRBS_PERIOD;
  global SYNC_BYTE_VALUE INV_SYNC_BYTE_VALUE;
  global INIT_PRBS_REGISTER;

  global dvbt_receive_current_packet;
  global dvbt_receive_prbs_register;

  if dvbt_receive_current_packet < 0
    %% we are still trashing packets

    data_out = zeros(NET_PACKET_LENGTH,1);
    
    dvbt_receive_current_packet = dvbt_receive_current_packet+1;
  else
    if dvbt_receive_current_packet == 0
      dvbt_receive_prbs_register=INIT_PRBS_REGISTER;
      sync_byte=INV_SYNC_BYTE_VALUE;
    else
      sync_byte=SYNC_BYTE_VALUE;
    end
    
    if sync_byte ~= data_in(1)
      fprintf('warning: actual sync byte (%2.2x) does not match\n', data_in(1));
      fprintf('warning: expected sync byte (%2.2x).\n', sync_byte);
      fprintf('warning: (current_packet=%d)\n', dvbt_receive_current_packet);
    end
    
    [prbs, dvbt_receive_prbs_register] = prbs_sequence...
	(NET_PACKET_LENGTH, dvbt_receive_prbs_register);
    
    data_out=byte_xor(data_in(2:PACKET_LENGTH),prbs);
    
    dvbt_receive_current_packet=rem(dvbt_receive_current_packet+1,...
				    PACKETS_PER_PRBS_PERIOD);
  end
function data_out = dvbt_receive (data_channel_out)

  fprintf('  dvbt_receive (%d)\n', length(data_channel_out));

  global PACKETS_PER_PRBS_PERIOD;
  global PACKET_LENGTH;
  global RS_PARITY_BYTES;
  global NET_PACKET_LENGTH;
  global PUNCTURING_MODE;
  
  global dvbt_receive_current_packet;
  global dvbt_receive_prbs_register;
  global dvbt_receive_conv_regigster;
  global byte_stream;

  % Process OFDM symbols
  [should_be_carrier_count, num_symbols] = size (data_channel_out);
  for i = 1:num_symbols
    data=data_channel_out(:,i);

    data = ofdm_decode (data);
    data = remove_reference_signals (data);
    [symbols] = demap (data);
    data = inner_deinterleave (symbols);
    
    [x, y] = depuncturing (data);
    data = convolutional_decode (x, y);
    
    data = byte_from_bit_vector (data);
    if isempty(byte_stream)
      byte_stream = data;
    else
      byte_stream = [ byte_stream ; data ];
    end
  end

  [num_bytes, should_be_one] = size (byte_stream);
  p=PACKET_LENGTH+RS_PARITY_BYTES;
  num_packets=floor (num_bytes/p);
  packets=zeros(p,num_packets);
  for i = 1:num_packets
    packets(:,i) = byte_stream(1+(i-1)*p:i*p);
  end
  if ~isempty(byte_stream)
    byte_stream = byte_stream...
	(1+num_packets*p:num_bytes);
  end
  
  % Process MPEG transport MUX packets
  data_out=zeros(NET_PACKET_LENGTH,num_packets);
  for i = 1:num_packets
    data = packets(:,i);
    
    data = outer_deinterleave (data);
    data = rs_decode (data);
    data = remove_sync_and_unscramble (data);
  
    data_out(:,i)=data;
  end


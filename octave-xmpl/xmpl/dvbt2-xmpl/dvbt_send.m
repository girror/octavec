function data_channel_in = dvbt_send (data_in)

  fprintf('  dvbt_send (%d)\n', length(data_in));

  global PACKETS_PER_PRBS_PERIOD;
  global OFDM_SYMBOL_LENGTH;
  global OFDM_SYMBOL_NET_LENGTH;
  global OFDM_SYMBOL_SIZE;
  global CARRIER_COUNT;
  global GUARD_INTERVAL_DURATION;
  global OFDM_MODE;
  
  global dvbt_send_current_packet;
  global dvbt_send_prbs_register;
  global dvbt_send_conv_regigster;
  global bit_stream;
    
  % Process MPEG transport MUX packets
  [should_be_packet_size, num_packets] = size (data_in);
  for i = 1:num_packets
    data=data_in(:,i);
  
    data = sync_and_scramble (data);
    data = rs_encode (data);
    data = outer_interleave (data);

    data = bit_from_byte_vector (data);
    if isempty(bit_stream)
      bit_stream = data;
    else
      bit_stream = [ bit_stream ; data ];
    end
  end

  % convert MUX packets into OFDM symbols
  [num_bits, should_be_one] = size (bit_stream);
  num_symbols = floor (num_bits/OFDM_SYMBOL_NET_LENGTH);
  ofdm_symbols = zeros (OFDM_SYMBOL_NET_LENGTH, num_symbols);
  for i = 1:num_symbols
    ofdm_symbols(:,i) = bit_stream...
	(1+(i-1)*OFDM_SYMBOL_NET_LENGTH:i*OFDM_SYMBOL_NET_LENGTH);
  end
  if ~isempty(bit_stream)
    bit_stream = bit_stream...
	(1+num_symbols*OFDM_SYMBOL_NET_LENGTH:num_bits);
  end

  % Process OFDM symbols
  guard_length=ceil (OFDM_MODE * GUARD_INTERVAL_DURATION);
  data_channel_in = zeros(OFDM_MODE + guard_length, ...
			  num_symbols);
  for i = 1:num_symbols
    data = ofdm_symbols(:,i);
    
    [x, y] = convolutional_encode (data);
    data = puncturing (x, y);
    [symbols] = inner_interleave (data);
    data = map (symbols);
    data = insert_reference_signals (data);
    data = ofdm_encode(data);
    
    data_channel_in(:,i) = data;
  end
  
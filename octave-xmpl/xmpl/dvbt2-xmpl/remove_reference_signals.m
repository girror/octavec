function data_out = remove_reference_signals (data_in)

  fprintf ('    remove_reference_signals (%d)\n', length(data_in));

  global RECEIVE_FRAME_INDEX;
  global CARRIER_COUNT;
  global FRAMES_PER_SUPERFRAME;
  global CCP_TABLE;
  global REF_SEQUENCE;
  global TPS_TABLE;
  global ALPHA;
  global OFDM_SYMBOL_SIZE;

  data_out = zeros (OFDM_SYMBOL_SIZE, 1);
  
  % create a set of pilots
  l=RECEIVE_FRAME_INDEX;
  Kmin=0;
  Kmax=CARRIER_COUNT;
  pilot_set = union (CCP_TABLE, ...
		     Kmin + 3*rem(l,4) + 12*(0:(CARRIER_COUNT-12)/12));

  % Insert TPS symbols
  tps_set=TPS_TABLE;

  % merge data and pilots
  v=1;
  pilot=1;
  tps=1;
  for u = 1:CARRIER_COUNT
    p = 1+pilot_set(pilot);
    if tps <= length(tps_set)
      t = 1+tps_set(tps);
    else
      t = 0;
    end
    
    if u == p
      %% pilot
      %% data_in(u) == 4/3 * 2 * (0.5 - REF_SEQUENCE(p))
      pilot = pilot + 1;
    elseif u == t;
      %% TPS
      %% data_in(u) = .795 + tps * 0.01i;
      tps = tps + 1;
    else
      data_out(v) = data_in(u) / ALPHA;
      v = v + 1;
    end
  end
  
  RECEIVE_FRAME_INDEX = rem(RECEIVE_FRAME_INDEX+1, FRAMES_PER_SUPERFRAME);
    
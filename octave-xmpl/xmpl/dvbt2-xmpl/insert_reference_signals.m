function data_out = insert_reference_signals (data_in)

  fprintf ('    insert_reference_signals (%d)\n', length(data_in));

  global SEND_FRAME_INDEX;
  global CARRIER_COUNT;
  global FRAMES_PER_SUPERFRAME;
  global CCP_TABLE;
  global REF_SEQUENCE;
  global TPS_TABLE;
  global ALPHA;
  
  data_out = zeros (CARRIER_COUNT, 1);
  
  % create a set of pilots
  l=SEND_FRAME_INDEX;
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
      data_out(u) = 4/3 * 2 * (0.5 - REF_SEQUENCE(p));
      pilot = pilot + 1;
    elseif u == t;
      data_out(u) = 2 * (0.5 - REF_SEQUENCE(p));
      tps = tps + 1;
    else
      data_out(u) = ALPHA * data_in(v);
      v = v + 1;
    end
  end
  
  SEND_FRAME_INDEX = rem(SEND_FRAME_INDEX+1, FRAMES_PER_SUPERFRAME);
  
function data_out = ofdm_decode (data_in)

  fprintf ('    ofdm_decode (%d)\n', length(data_in));

  global GUARD_INTERVAL_DURATION;
  global OFDM_MODE;
  global CARRIER_COUNT;

  guard_length=ceil (OFDM_MODE * GUARD_INTERVAL_DURATION);

  time_domain = data_in(guard_length+1:guard_length+OFDM_MODE);

  frequency_domain = fft (time_domain);

  data_out = frequency_domain;

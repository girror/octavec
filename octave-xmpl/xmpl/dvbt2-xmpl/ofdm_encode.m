function data_out = ofdm_encode (data_in)

  fprintf ('    ofdm_encode (%d)\n', length(data_in));

  global GUARD_INTERVAL_DURATION;
  global OFDM_MODE;
  global CARRIER_COUNT;

  frequency_domain=zeros(OFDM_MODE,1);
  frequency_domain(1:CARRIER_COUNT) = data_in;

  time_domain = ifft (frequency_domain);

  guard_length=ceil (OFDM_MODE * GUARD_INTERVAL_DURATION);
  
  data_out = [time_domain(1+OFDM_MODE-guard_length:OFDM_MODE) ; time_domain];
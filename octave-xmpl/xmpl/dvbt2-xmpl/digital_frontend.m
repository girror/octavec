%% input: xxx sample values from A/D converter
%% output: yyy sample values representation a OFDM packet

function output = digital_frontend (input)
  
  input = gain_control (input);
  synchronization (input);

  output = sample_rate_conversion (input);

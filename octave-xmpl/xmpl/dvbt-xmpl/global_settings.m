function global_settings ()

  global PACKET_LENGTH NET_PACKET_LENGTH;
  global PACKETS_PER_PRBS_PERIOD;
  global SYNC_BYTE_VALUE INV_SYNC_BYTE_VALUE;
  global INIT_PRBS_REGISTER;
  global RS_PARITY_BYTES;
  global OI_I OI_M;
  global INIT_CONV_REGISTER;
  global PUNCTURING_MODE;
  global QAM_MODE LOG_QAM_MODE;
 

  ffffffff = flipud([1,2])
  rrrrrrrr = rows([1,2])
  ffxxxxxx = diff([1,2,8],1)
  % chunk size in packets
  PACKETS_PER_PRBS_PERIOD=8;

  % packet length
  PACKET_LENGTH = 188;
  NET_PACKET_LENGTH = PACKET_LENGTH-1;

  % sync bytes
  SYNC_BYTE_VALUE=hex2dec('47');
  INV_SYNC_BYTE_VALUE=hex2dec('b8');

  % pseudo random binary sequence
  INIT_PRBS_REGISTER=[1 0 0 1 0 1 0 1 0 0 0 0 0 0 0];

  % Reed Solomon
  RS_PARITY_BYTES=16;
  
  % Outer Interleaver
  OI_I=12;
  OI_M=17;

  % Convolutional Code
  INIT_CONV_REGISTER=zeros(1,6);
  PUNCTURING_MODE=2/3;

  % QAM Mode
  QAM_MODE=16;
  LOG_QAM_MODE=log2(QAM_MODE);



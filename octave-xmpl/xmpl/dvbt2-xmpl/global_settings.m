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

  global OFDM_SYMBOL_SIZE;
  global OFDM_SYMBOL_LENGTH;
  global OFDM_SYMBOL_NET_LENGTH;

  global FFT_SIZE;

  #Flowwing lines are added to get all intrinsic octave functions
  ffffffff = flipud([1,2])
  sssssss  = sqrt(3.4) 
  rrrrrrrr = rows([1,2])
  ffxxxxxx = diff([1,2,8],1)

  # -----------------------

  % chunk size in packets
  PACKETS_PER_PRBS_PERIOD=8;

  % packet length
  PACKET_LENGTH=188;
  NET_PACKET_LENGTH=PACKET_LENGTH-1;

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
  global SEND_OI_STATE;
  SEND_OI_STATE=zeros(OI_I,OI_I*OI_M+1);
  global SEND_OI_POINTER;
  SEND_OI_POINTER=0;
  global RECEIVE_OI_STATE;
  RECEIVE_OI_STATE=zeros(OI_I,OI_I*OI_M+1);
  global RECEIVE_OI_POINTER;
  RECEIVE_OI_POINTER=0;
  global OI_PACKETS_TO_TRASH;
  OI_PACKETS_TO_TRASH=11;

  % Convolutional Code
  INIT_CONV_REGISTER=zeros(1,6);
  PUNCTURING_MODE=2/3;

  % QAM Mode
  QAM_MODE=16;
  LOG_QAM_MODE=log2(QAM_MODE);

  OFDM_SYMBOL_SIZE = 1512;
  OFDM_SYMBOL_LENGTH = 1512*4;
  OFDM_SYMBOL_NET_LENGTH = OFDM_SYMBOL_LENGTH * PUNCTURING_MODE;

  FFT_SIZE = 2048;

  global dvbt_send_current_packet;
  global bit_stream;
  global dvbt_receive_current_packet;
  dvbt_send_current_packet=0;
  bit_stream = [];
  dvbt_receive_current_packet=-OI_PACKETS_TO_TRASH;
  global byte_stream;
  byte_stream = [];

  global dvbt_send_conv_register;
  dvbt_send_conv_register=INIT_CONV_REGISTER;
  global dvbt_receive_conv_register;
  dvbt_receive_conv_register=INIT_CONV_REGISTER;

  % Inner Interleave
  global II_BLOCK_SIZE;
  II_BLOCK_SIZE=126;

  Nmax=1512;
  Mmax=2048;
  global Hq;
  Hq = zeros(Nmax,1);
  q=0;
  Nr=11;

  for i = 0:Mmax-1
    % compute Ri
    switch i
      case 0
	r1 = zeros (1, Nr-1);
      case 1
	r1 = zeros (1, Nr-1);
      case 2
	r1 = zeros (1, Nr-1);
	r1(1) = 1;
      otherwise
	r1 = [r1(2:Nr-1) , xor(r1(1+0), r1(1+3))];
    end
    perm_table=[4 3 9 6 2 8 1 5 7 0];
    r = zeros(1, Nr-1);
    for k = 0:Nr-2
      r(1+perm_table(1+k)) = r1(1+k);
    end
    
    % compute H(q)
    Hq(1+q) = rem(i,2) * 2^(Nr-1);
    for j = 0:Nr-2
      Hq(1+q) = Hq(1+q) + r(1+j) * 2^j;
    end
    if Hq(1+q) < Nmax
      q = q + 1;
    end
  end

  global SEND_EVEN_SYMBOL;
  SEND_EVEN_SYMBOL=1;
  global RECEIVE_EVEN_SYMBOL;
  RECEIVE_EVEN_SYMBOL=1;

  % mapper
  global QAM_TABLE;
  QAM_TABLE = [1000, 1010, 0010, 0000;
	       1001, 1011, 0011, 0001;
	       1101, 1111, 0111, 0101;
	       1100, 1110, 0110, 0100];
  global QAM_ROW;
  QAM_ROW = [3i 1i -1i -3i];
  global QAM_COL;
  QAM_COL = [-3 -1 1 3];

  global CARRIER_COUNT;
  CARRIER_COUNT=1705;
  
  % pilot carriers and TPS
  % continual carriers
  global CCP_TABLE;
  CCP_TABLE = [ 0 48 54 87 141 156 192 201 255 279 282 333 432 450 ...
	       483 525 531 618 636 714 759 765 780 804 873 888 918 ...
	       939 942 969 984 1050 1101 1107 1110 1137 1140 1146 ...
	       1206 1269 1323 1377 1491 1683 1704];
  % wk
  global REF_SEQUENCE;
  REF_SEQUENCE=zeros(1,CARRIER_COUNT);
  reg=ones(1,11);
  for i = 1:CARRIER_COUNT
    REF_SEQUENCE(i) = reg(11);
    new_bit = xor(reg(9), reg(11));
    reg = [ new_bit reg(1:10) ];
  end
  % TPS
  global TPS_TABLE;
  TPS_TABLE = [34 50 209 346 413 569 595 688 790 901 ...
	       1073 1219 1262 1286 1469 1594 1687];

  global SEND_FRAME_INDEX;
  SEND_FRAME_INDEX = 0;
  global RECEIVE_FRAME_INDEX;
  RECEIVE_FRAME_INDEX = 0;
  global FRAMES_PER_SUPERFRAME;
  FRAMES_PER_SUPERFRAME = 68;

  global ALPHA;
  ALPHA=1/sqrt(10);

  global GUARD_INTERVAL_DURATION;
  GUARD_INTERVAL_DURATION=1/4;

  global OFDM_MODE;
  OFDM_MODE=2048;

  gf_init ([8 4 3 2 0]);
  rs_init (hex2dec('02'), 8);
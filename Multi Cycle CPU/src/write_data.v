module WriteData (
  input [1:0] StoreType,
  input [31:0] Addr,
  input [31:0] rd2,
  input [31:0] ReadData,
  output [31:0] WriteDataOut
);

  wire [7:0] RDByte0 = ReadData[7:0];
  wire [7:0] RDByte1 = ReadData[15:8];
  wire [7:0] RDByte2 = ReadData[23:16];
  wire [7:0] RDByte3 = ReadData[31:24];

  wire [7:0] rd2Byte0 = rd2[7:0];
  wire [7:0] rd2Byte1 = rd2[15:8];

  wire [31:0] byte0 = {RDByte3, RDByte2, RDByte1, rd2Byte0};
  wire [31:0] byte1 = {RDByte3, RDByte2, rd2Byte0, RDByte0};
  wire [31:0] byte2 = {RDByte3, rd2Byte0, RDByte1, RDByte0};
  wire [31:0] byte3 = {rd2Byte0, RDByte2, RDByte1, RDByte0};

  wire [31:0] byteMuxOut;

  mux4 #(.WIDTH(32)) byte_mux (
    .d0(byte0), 
    .d1(byte1), 
    .d2(byte2), 
    .d3(byte3), 
    .sel(Addr[1:0]), 
    .y(byteMuxOut)
  );

  wire [31:0] byteOrWord;

  mux2 #(.WIDTH(32)) byte_or_word_mux (
    .d0(rd2), 
    .d1(byteMuxOut), 
    .sel(StoreType[0]), 
    .y(byteOrWord)
  );

  wire [31:0] halfWord0 = {RDByte3, RDByte2, rd2Byte1, rd2Byte0};
  wire [31:0] halfWord1 = {rd2Byte1, rd2Byte0, RDByte1, RDByte0};

  wire [31:0] halfWordMuxOut;

  mux2 #(.WIDTH(32)) half_word_mux (
    .d0(halfWord0), 
    .d1(halfWord1), 
    .sel(Addr[1]), 
    .y(halfWordMuxOut)
  );

  mux2 #(.WIDTH(32)) half_or_byte_mux (
    .d0(byteOrWord), 
    .d1(halfWordMuxOut), 
    .sel(StoreType[1]), 
    .y(WriteDataOut)
  );

endmodule
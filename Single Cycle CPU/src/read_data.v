module ReadData (
  input [2:0] LoadType,
  input [31:0] Addr,
  input [31:0] ReadData,
  output [31:0] ReadDataOut
);

  wire [7:0] byte_mux_out;

  mux4 #(.WIDTH(8)) byte_mux (
    .d0(ReadData[7:0]),
    .d1(ReadData[15:8]),
    .d2(ReadData[23:16]),
    .d3(ReadData[31:24]),
    .sel(Addr[1:0]),
    .y(byte_mux_out)
  );
  
  wire [15:0] half_mux_out;

  mux2 #(.WIDTH(16)) half_mux (
    .d0(ReadData[15:0]), 
    .d1(ReadData[31:16]), 
    .sel(Addr[1]), 
    .y(half_mux_out)
  );

  wire [31:0] zero_byte;
  wire [31:0] sign_byte;
  wire [31:0] zero_half;
  wire [31:0] sign_half;

  ZeroExtendByte zero_byte_ext (
    .in(byte_mux_out), 
    .out(zero_byte)
  );

  SignExtendByte sign_byte_ext (
    .in(byte_mux_out), 
    .out(sign_byte)
  );

  ZeroExtendHalf zero_half_ext (
    .in(half_mux_out), 
    .out(zero_half)
  );

  SignExtendHalf sign_half_ext (
    .in(half_mux_out), 
    .out(sign_half)
  );

  wire [31:0] read_or_zero_byte;
  wire [31:0] or_sign_byte;
  wire [31:0] zero_or_sign_half;

  mux2 #(.WIDTH(32)) read_or_zero_byte_mux (
    .d0(ReadData), 
    .d1(zero_byte), 
    .sel(LoadType[0]), 
    .y(read_or_zero_byte)
  );

  mux2 #(.WIDTH(32)) or_sign_byte_mux (
    .d0(read_or_zero_byte), 
    .d1(sign_byte), 
    .sel(LoadType[1]), 
    .y(or_sign_byte)
  );

  mux2 #(.WIDTH(32)) zero_or_sign_half_mux (
    .d0(zero_half), 
    .d1(sign_half), 
    .sel(LoadType[0]), 
    .y(zero_or_sign_half)
  );

  mux2 #(.WIDTH(32)) final_mux (
    .d0(or_sign_byte), 
    .d1(zero_or_sign_half), 
    .sel(LoadType[2]), 
    .y(ReadDataOut)
  );

endmodule
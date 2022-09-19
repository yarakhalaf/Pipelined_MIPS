module DecodeStage (
input  wire [31:0]   InstrD,
input  wire [31:0]   PCPlus4D,
input  wire [31:0]   ALUOutM,
input  wire [4:0]    WriteRegW,
input  wire          RegWriteW,
input  wire [31:0]   ResultW,
input  wire          RST,
input  wire          CLK,
input  wire          ForwardAD,
input  wire          ForwardBD,
output wire [31:0]   RD1_D,
output wire [31:0]   RD2_D,
output wire [31:0]   SignImmD,
output wire [31:0]   PCBranchD,
output wire [31:0]   ShifterOut_26,
output wire [4:0]    RsD,
output wire [4:0]    RtD,
output wire [4:0]    RdD,
output wire          EqualD
);
//internal Connections
wire [31:0]   MUX_RD1_out1;
wire [31:0]   MUX_RD2_out2;
wire [31:0]   ShifterOut_32;
wire [27:0]   ShifterOut_28;

//assign output statments
assign ShifterOut_26 = {InstrD[31:28],ShifterOut_28}; 
assign RsD = InstrD[25:21];
assign RtD = InstrD[20:16];
assign RdD = InstrD[15:11];
//instantiation of Register File
register_file U_register_file(
 .clk(CLK),
 .rst(RST),
 .WE3(RegWriteW),
 .A1(InstrD[25:21]),
 .A2(InstrD[20:16]),
 .A3(WriteRegW),
 .WD3(ResultW),
 .RD1(RD1_D),
 .RD2(RD2_D)
);
//instantiation of Multiplexers
Mux U_MUX_RD1 (
.D0(RD1_D), 
.D1(ALUOutM),
.S(ForwardAD),   
.Y(MUX_RD1_out1)      
);

Mux U_MUX_RD2 (
.D0(RD2_D), 
.D1(ALUOutM),
.S(ForwardBD),   
.Y(MUX_RD2_out2)   
);
//instantiation of Comparator
Comparator U_Comparator(
.IN1(MUX_RD1_out1),
.IN2(MUX_RD2_out2),
.OUT(EqualD) 
);
//instantiation of Sign Extend
Sign_Extend U_Sign_Extend(
.instr(InstrD[15:0]), 
.SignImm(SignImmD)
);
//instantiation of first Shifter
shift_left U_shift_left_32 (
.in_shift(SignImmD),
.out_shift(ShifterOut_32)
);
//instantiation of Second Shifter
shift_left  #(.in_width(26), .out_width(28)) U_shift_left_26
( 
.in_shift(InstrD[25:0]),
.out_shift(ShifterOut_28)
);
//instantiation of Adder
Adder U_Adder(
.A(ShifterOut_32),
.B(PCPlus4D),
.C(PCBranchD) 
);

endmodule

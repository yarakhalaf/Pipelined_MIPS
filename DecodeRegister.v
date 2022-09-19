module DecodeRegister (
input  wire         RegWriteD,
input  wire         MemtoRegD,
input  wire         MemWriteD,
input  wire  [2:0]  ALUControlD,
input  wire         ALUSrcD,
input  wire         RegDstD,
input  wire  [31:0] RD1_D,
input  wire  [31:0] RD2_D,
input  wire  [4:0]  RsD,
input  wire  [4:0]  RtD,
input  wire  [4:0]  RdD,
input  wire         CLR,
input  wire         CLK,
input  wire         RST,
input  wire   [31:0] SignImmD,
output reg          RegWriteE,
output reg          MemtoRegE,
output reg          MemWriteE,
output reg   [2:0]  ALUControlE,
output reg          ALUSrcE,
output reg          RegDstE,
output reg   [31:0] RD1_E,
output reg   [31:0] RD2_E,
output reg   [4:0]  RsE,
output reg   [4:0]  RtE,
output reg   [4:0]  RdE,
output reg   [31:0] SignImmE
);

always @(posedge CLK or negedge RST)
begin
  if(~RST)
  begin
    RegWriteE<=1'b0;
    MemtoRegE<=1'b0;
    MemWriteE<=1'b0;
    ALUControlE<=3'b0;
    ALUSrcE<=1'b0;
    RegDstE<=1'b0;
    RD1_E<=32'b0;
    RD2_E<=32'b0;
    RsE<=5'b0;
    RtE<=5'b0;
    RdE<=5'b0;
    SignImmE<=32'b0;
  end

  else if(CLR)
    begin
      RegWriteE<=1'b0;
      MemtoRegE<=1'b0;
      MemWriteE<=1'b0;
      ALUControlE<=3'b0;
      ALUSrcE<=1'b0;
      RegDstE<=1'b0;
      RD1_E<=32'b0;
      RD2_E<=32'b0;
      RsE<=5'b0;
      RtE<=5'b0;
      RdE<=5'b0;
      SignImmE<=32'b0;
    end
  else
    begin
      RegWriteE<=RegWriteD;
      MemtoRegE<=MemtoRegD;
      MemWriteE<=MemWriteD;
      ALUControlE<=ALUControlD;
      ALUSrcE<=ALUSrcD;
      RegDstE<=RegDstD;
      RD1_E<=RD1_D;
      RD2_E<=RD2_D;
      RsE<=RsD;
      RtE<=RtD;
      RdE<=RdD;
      SignImmE<=SignImmD;
    end
end
endmodule

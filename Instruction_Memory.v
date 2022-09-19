module Instruction_Memory 
(
    input   wire  [31:0]    A,
    output  reg   [31:0]    RD
);

reg   [31:0]  MEM   [0:256];


initial
begin
  $readmemh("Program 3_Machine Code.txt",MEM);     // Adjust the Name of excuted program
end

always @(*)
begin
  RD = MEM [A >> 2] ;
end

endmodule


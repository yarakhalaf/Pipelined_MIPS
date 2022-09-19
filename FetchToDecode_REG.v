module FetchToDecode_REG
(
    input       wire                CLK,
    input       wire                RST,
    input       wire   [31:0]       PCPlus4F,
    input       wire   [31:0]       InstrF,
    input       wire                StallD,
    input       wire                CLR,
    output      reg   [31:0]        PCPlus4D,
    output      reg   [31:0]        InstrD
);

always @(posedge CLK or negedge RST) 
begin
    if(!RST)
        begin
            PCPlus4D <= 0;
            InstrD   <= 0;
        end
    else if (CLR && !StallD)
        begin
            PCPlus4D <= 0;
            InstrD   <= 0;
        end
    else  if (!StallD)
        begin
            PCPlus4D <= PCPlus4F;
            InstrD   <= InstrF;
        end    
end

endmodule

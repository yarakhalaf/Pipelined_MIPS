module PCunit
(
    input   wire                CLK, 
    input   wire                RST, 
    input   wire                StallF, 
    input   wire    [31:0]      PCin,
    output  reg     [31:0]      PCF
);

always @(posedge CLK, negedge RST) 
begin
    if (!RST) 
    begin
        PCF <= 0;
    end
    else if (!StallF)
    begin
        PCF <= PCin;
    end
end

endmodule
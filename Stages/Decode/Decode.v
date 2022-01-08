module decode(
    clk,
    rst,
    opcode,
    regWrite,
    Rsrc1,
    Rsrc2,
    Rdst,
    writeData,
    inPort,
    signals,
    readData1,
    readData2,
);
    input clk;
    input rst;
    input regWrite;
    input [2:0] Rsrc1;
    input [2:0] Rsrc2;
    input [2:0] Rdst;
    input [6:0] opcode;
    input [15:0] writeData;
    input [15:0] inPort;
    output [34:0] signals;
    output reg [15:0] readData1;
    output [15:0] readData2;
        
    wire [15:0] regFileOut;
    CTRL_UNIT u0(.clk(clk),.opcode(opcode),.reset(rst),.signals(signals));
    reg_file  u1(.clk(clk),.regWrite(regWrite),.writeData(writeData),.Rsrc1(Rsrc1),.Rsrc2(Rsrc2),.Rdst(Rdst),.readData1(regFileOut),.readData2(readData2));

    always @(*) 
    begin: decode_unit_op
        if(signals[18]) //  detect if output is from in Register or register file
            readData1 = inPort;
        else
            readData1 = regFileOut;
    end// decode_unit_op
endmodule
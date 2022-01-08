module memStage(
    input  clk , 
    input  i_isStack, i_reset, i_isPushPc,
    input  i_memRead, i_memWrite, i_en32,
    input  [1:0]  i_wb, 
    input  [15:0] i_aluData,
    input  [31:0] i_pc,  
    input  [31:0] i_instruction,   // refers to instruction come from buffer (name as x in pdf)
    input  [31:0] prev_SP,
    input  [2:0] SP_select,
    input  is_Prev_SP,

    output reg [1 :0] o_wb,
    output [15:0] o_aluData,
    output [31:0] o_memData,
    output [31:0] new_SP
    // output  reg [19:0] o_hazardUnit
);
    reg  [31:0]  address;
    reg  [31:0]  writeData;
    wire  [31:0]  SP_out;

    assign new_SP = SP_out;
    // always @(posedge clk) begin
    STACK_POINTER SP (.clk(clk) , .Control_Mux(SP_select) , .Rst(i_reset),.Output_Signal(SP_out));

    always @(*) begin
        if(i_isStack) begin
            address = (is_Prev_SP) ? prev_SP : SP_out;
        end
        else begin
            address ={16'b0,i_aluData};
        end
        // o_hazardUnit = address;
        if(i_isPushPc) begin
          writeData = i_pc + 1;
        end
        else begin
          writeData = i_instruction;
        end        
        if(i_reset) begin
            o_wb = 0;
        end 
        else begin
            o_wb = i_wb;    
        end
    end
    DATA_MEM mem1(
        .clk(clk),
        .i_memRead(i_memRead),
        .i_memWrite(i_memWrite),
        .i_en32(i_en32),
        .i_address(address),
        .i_data_in(writeData),
        .o_data_out(o_memData)
    );
    assign o_aluData = i_aluData ; 
endmodule
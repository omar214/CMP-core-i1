module alu_mem_buff     
    #( parameter    
        WbSize  = 4,
        MemSize = 6, 
        flagSize =4
    )(
    // input rst,
    input clk,enable,
    input [MemSize-1:0] i_Mem,
    input [WbSize-1 :0] i_WB, 
    input [31:0] i_pc  ,
    input [2: 0] i_Rdst,
    input [15:0] i_alu , i_read_data1 ,
    input [flagSize-1:0] i_flag ; 

    output [MemSize-1:0] o_Mem,
    output [WbSize-1 :0] o_WB, 
    output [31:0] o_pc  ,
    output [2:0 ] o_Rdst,
    output [15:0] o_alu , o_read_data1,
    output [flagSize-1:0] o_flag  
);
    always @(posedge clk) begin
        // if(rst == 1'b1) begin
        //     o_WB <=        0;
        //     o_Mem <=       0;
        //     o_pc<=         0;
        //     o_read_data1<= 0;
        //     o_Rdst<=       0;
        //     o_alu<=        0;
        // end
        else if(enable == 1'b1) begin
            o_WB <=        i_WB;
            o_Mem <=       i_Mem;
            o_pc<=         i_pc;
            o_read_data1<= i_read_data1;
            o_Rdst<=       i_Rdst;
            o_alu<=        i_alu;
            o_flag<=       i_flag;
        end
    end
endmodule

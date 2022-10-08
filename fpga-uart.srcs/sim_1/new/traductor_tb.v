`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2022 20:45:09
// Design Name: 
// Module Name: traductor_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module traductor_tb;
    localparam BUS_OP_SIZE = 6;
    localparam BUS_SIZE = 8;   
    localparam BUS_BIT_ENABLE = 3;
    localparam I_CLK = 1'b0;
    localparam I_EN = 3'b000;
    localparam I_DATA_A = 8'hFF; // 255 representado en hexa de N bits    
    localparam I_DATA_B = 8'h02; // 2 representado en hexa de N bits    
    localparam I_OPERATION = 6'h0; // operaci?n 0 representada en un hexa de M bits
    localparam OP_ADD = 6'b100000;
    localparam OP_SUB = 6'b100010;
    localparam OP_AND = 6'b100100;
    localparam OP_OR = 6'b100101;
    localparam OP_XOR = 6'b100110;
    localparam OP_SRA = 6'b000011;
    localparam OP_SRL = 6'b000010;
    localparam OP_NOR = 6'b100111;
        //Inputs
    reg i_clk;
    reg i_reset;
    reg[BUS_SIZE - 1 :0] i_data;
    
    //Outputs
    wire[BUS_SIZE - 1 : 0] o_led;

    // Verilog code for ALU
    top_alu_w_trasl test_unit(
            .i_clk(i_clk), 
            .i_reset(i_reset),        
            .i_data(i_data),  // ALU N-bit Inputs                 
            .o_led(o_led) // ALU 8-bit Output
        );

    initial begin
        i_clk = 0;
        i_reset = 1'b1;
        #3
        i_reset = 1'b0;
        #10
        i_data = "A";
        #20
        i_data = I_DATA_A; // 255 representado en hexa de N bits
        #20
        i_data = "B";
        #20
        i_data = I_DATA_B; // 2 representado en hexa de N bits
        #20
        i_data = "O";
        #20
        i_data = I_OPERATION; // operaci?n 0 representada en un hexa de M bits
        #10
        i_data = OP_ADD; // Addition
        #10;
        i_data = OP_SUB; // Subtraction
        #10;
        i_data = OP_AND; //  Logical and 
        #10;
        i_data = OP_OR; //  Logical or
        #10;
        i_data = OP_XOR; //  Logical xor 
        #10;
        i_data = OP_SRA; // SRA 
        #10;
        i_data = OP_SRL; // SRL
        #10;
        i_data = OP_NOR; // Logical nor
        #10
        $finish;
    end
    
    always begin
        #1
        i_clk = ~i_clk;
    end
endmodule

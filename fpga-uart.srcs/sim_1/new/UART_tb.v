`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.10.2022 18:51:47
// Design Name: 
// Module Name: UART_tb
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


module UART_tb;
    parameter TICKS      = 16 ;
    parameter MOD_COUNT  = 651;
    parameter CLK_PERIOD = 20; //ns
    parameter DATA_TIME  = TICKS * MOD_COUNT * CLK_PERIOD*10;

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
    reg i_wr;
    
    //Outputs
    reg[BUS_SIZE - 1 : 0] in;
    wire[BUS_SIZE - 1 : 0] out;

    // Verilog code for ALU
    top_tb test_unit(
            .i_clk(i_clk),
            .i_reset(i_reset),
            .i_wr(i_wr),
            .Tx_data(in),
            .Rx_data(out)
        );
    initial begin
        i_clk = I_CLK;
        i_reset = 1;
        #DATA_TIME
        i_reset = 0;
        i_wr=1;
        in = "A";
        #2
        i_wr=0;
        #DATA_TIME
        i_wr=1;
        in = I_DATA_A; // 255 representado en hexa de N bits
        #2
        i_wr=0;
        #DATA_TIME 
        i_wr=1;   
        in = "B";
        #2
        i_wr=0;
        #DATA_TIME
        i_wr=1;
        in = I_DATA_B; // 2 representado en hexa de N bits;
        #2
        i_wr=0;
        #DATA_TIME
        i_wr=1;
        in = "O";
        #2
        i_wr=0;
        #DATA_TIME
        i_wr=1;
        in = I_OPERATION; // operaci?n 0 representada en un hexa de M bits
        #2
        i_wr=0;
        #DATA_TIME
        i_wr=1;
        in = OP_ADD; // Addition
        #2
        i_wr=0;
        #DATA_TIME
        i_wr=1;
        in = OP_SUB; // Subtraction
        #2
        i_wr=0;
        #DATA_TIME
        i_wr=1;
        in = OP_AND; //  Logical and 
        #2
        i_wr=0;
        #DATA_TIME
        i_wr=1;
        in = OP_OR; //  Logical or
        #2
        i_wr=0;
        #DATA_TIME
        i_wr=1;
        in = OP_XOR; //  Logical xor
        #2
        i_wr=0;  
        #DATA_TIME
        i_wr=1;
        in = OP_SRA; // SRA 
        #2
        i_wr=0;
        #DATA_TIME
        i_wr=1;
        in = OP_SRL; // SRL
        #2
        i_wr=0;
        #DATA_TIME
        i_wr=1;
        in = OP_NOR; // Logical nor
        #2
        i_wr=0;
        #DATA_TIME
        #DATA_TIME
        #DATA_TIME
        #DATA_TIME
        #DATA_TIME
        #DATA_TIME
        $finish;
    end
    
    always begin
        #1
        i_clk = ~i_clk;
    end
endmodule

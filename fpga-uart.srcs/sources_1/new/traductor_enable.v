`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2022 20:33:53
// Design Name: 
// Module Name: traductor_enable
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


module traductor_enable
      #(
    parameter BUS_ENABLE=2, // number of bits in counter
              BUS_DATA=8 // mod-BUS_DATA
   )
   (
    input wire clk, reset,i_empty,
    input wire [BUS_DATA-1:0] i_data,
    output wire [BUS_ENABLE-1:0] o_en,
    output wire [BUS_DATA-1:0] o_data,
    output wire o_rd
   );
    localparam OP_ADD = 6'b100000;
    localparam OP_SUB = 6'b100010;
    localparam OP_AND = 6'b100100;
    localparam OP_OR = 6'b100101;
    localparam OP_XOR = 6'b100110;
    localparam OP_SRA = 6'b000011;
    localparam OP_SRL = 6'b000010;
    localparam OP_NOR = 6'b100111;
   //signal declaration
   reg [BUS_ENABLE-1:0] r_enable;
   reg [BUS_DATA-1:0] r_data;
   reg [BUS_ENABLE-1:0] r_enable_next;
   reg [BUS_DATA-1:0] r_data_next;
   
   reg rd_reg;

   // body
   // register
   always @(posedge clk)
      if (reset)
      begin
         r_enable <= 2'b11;
         r_data <= 8'd0;
         rd_reg <= 1'd0;
      end
      else
        if(~i_empty)
        begin
             rd_reg <= 1'd1;
             r_enable <= r_enable_next;
             r_data <= r_data_next;
        end
        else
             rd_reg <= 1'd0;

   // next-state logic
   always @(*)  
    begin    
        //keep old value
        r_enable_next = r_enable;
        
        if(i_data=="A")     
            r_enable_next = #(BUS_ENABLE)'d0;       
        else if(i_data=="B")
            r_enable_next = #(BUS_ENABLE)'d1;
        else if(i_data=="O")      
            r_enable_next = #(BUS_ENABLE)'d2;
            
//        r_data_next = i_data; 
    end
   always @(*)
   begin
        r_data_next = r_data;
        if(r_enable == 2'd2)
            case(i_data)
                8'b00110001:
                    r_data_next = OP_ADD;
                8'b00110010:
                    r_data_next = OP_SUB;
                8'b00110011:
                    r_data_next = OP_AND;
                8'b00110100:
                    r_data_next = OP_OR;
                8'b00110101:
                    r_data_next = OP_XOR;
                8'b00110110:
                    r_data_next = OP_SRA;
                8'b00110111:
                    r_data_next = OP_SRL;
                8'b00111000:
                    r_data_next = OP_NOR;
                endcase
        else
            case(i_data)
                8'b00110001:
                    r_data_next = 8'd1;
                8'b00110010:
                    r_data_next = 8'd2;
                8'b00110011:
                    r_data_next = 8'd3;
                8'b00110100:
                    r_data_next = 8'd4;
                8'b00110101:
                    r_data_next = 8'd5;
                8'b00110110:
                    r_data_next = 8'd6;
                8'b00110111:
                    r_data_next = 8'd7;
                8'b00111000:
                    r_data_next = 8'd8;
                8'b00111001:
                    r_data_next = 8'd9;
                8'b00110000:
                    r_data_next = 8'd0;
                endcase    
   end     


   assign o_data = r_data;
   assign o_en = r_enable;
   assign o_rd = rd_reg;
endmodule

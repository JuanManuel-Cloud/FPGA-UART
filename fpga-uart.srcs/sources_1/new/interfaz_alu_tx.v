`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.10.2022 17:31:48
// Design Name: 
// Module Name: interfaz_alu_tx
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


module interfaz_alu_tx#(
 BITS=8
 )
(
    input wire i_clk, i_reset,i_full,
    input wire [BITS-1:0] i_data,
    input wire flag_carry, flag_zero,
    output wire [BITS-1:0] o_data,
    output wire o_wr
   );
   
   reg [BITS-1:0] flag_reg;
   reg [BITS-1:0] data_reg;
   reg count,wr_reg;
   
   always@(posedge i_clk)
   begin
      if(wr_reg)
                wr_reg <= 0;
       if(i_reset)
       begin
            flag_reg <= 8'b0;
            data_reg <= 8'b0;
            count <= 1'b0;
            wr_reg <= 0;
       end
       else
           if(~i_full)
           begin  
                wr_reg <= 1;    
                if(~count)
                begin
                    data_reg <= i_data;
//                    count <= count+1;
                end
//                else
//                begin
//                    data_reg <= flag_reg;
//                    count <= count+1;
//                end
           end     
   end
   
   always@(*)
   begin
        flag_reg[0] = flag_carry;
        flag_reg[1] = flag_zero;          
   end
   
   assign o_data = data_reg;
   assign o_wr = wr_reg;
endmodule

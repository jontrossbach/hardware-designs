`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2020 04:30:38 PM
// Design Name: 
// Module Name: quotient_calculator
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


module quotient_calculator(
    //clk,
    R_in,
    R_out,
    D,
    Q_in,
    Q_out
    );
    
    
    input wire [31:0] R_in, D, Q_in;
    output wire [31:0] R_out, Q_out;
    
    
   //always @(posedge clk)
     assign Q_out = R_in >= D ? {Q_in[30:0],1'b1}
                    :{Q_in[30:0],1'b0};
   
     assign R_out = R_in >= D ? {R_in-D}
                    :{R_in};
endmodule

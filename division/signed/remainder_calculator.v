`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: New York University
// Engineer: Jon Trossbach
// 
// Create Date: 09/26/2020 03:22:59 PM
// Module Name: remainder 
// Description: 
//////////////////////////////////////////////////////////////////////////////////


module remainder_calculator( 
    R_in,
    N,
    i,
    R_out
    );
    input [31:0]  N;
    input [30:0] R_in;
    input [4:0] i;
    output [30:0] R_out;

    
    assign R_out[30:1] = R_in[29:0];
    
    assign R_out[0] = 0==N[31] ? N[30-i]:
                      !N[30-i];
    
endmodule

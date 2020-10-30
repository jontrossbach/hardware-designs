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


module remainder_long_division_top(
    VALID,
    READY,
    clk,
    reset,
    N,
    D,
    Q,
    R,
    div_zero_err
    );
    
    input wire VALID, clk, reset;
    input wire [31:0] N, D;
    
    output reg READY, div_zero_err;
    
    output reg [31:0] Q=0, R=0;
    
    reg [4:0] i;
    //reg [31:0] R;
    
    wire [4:0] i2i;
    wire [31:0] R_temp1, R_temp2, Q_temp;
    
    counter cou(.clk(clk), .reset(reset), .i(i2i));
    remainder_calculator rem ( .R_in(R), .N(N), .i(i2i), .R_out(R_temp1) );
    
    quotient_calculator quo( .R_in(R_temp1), .R_out(R_temp2), .D(D), .Q_in(Q), .Q_out(Q_temp));
     
    
        
    always @(posedge clk or reset)
      
      if (reset) begin
        i <= 0;
        //R_temp <= 0;
        Q <= 0;
        R <= 0;
        READY <= 0;
        div_zero_err <= 0;
      
      end else if (VALID) begin
        if (!D) begin
          div_zero_err <= 1;
          Q <= 0;
          R <= 0;
          READY <= 1;
        end else if (N >= D) begin
          
          if (i2i==31) begin
            READY <= 1;
          end else begin
            READY <= 0;
          end 
        end else if (N < D) begin
          Q <= 0;
          R <= N;
          READY <= 1;  
        end //else begin
          
        //end
        
        R <= R_temp2;
        Q <= Q_temp;
      end    
    
endmodule

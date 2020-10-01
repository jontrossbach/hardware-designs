`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: New York University
// Engineer: Jon Trossbach
// 
// Create Date: 09/26/2020 03:22:59 PM
// Module Name: up_down_counter_tb
// Description: Test bench for 16-bit counter ith "clk", "enable", "reset", and
// "reverse" inputs:
//   - When the enable signal is high and the reverse input is low, the counter 
//  value should increment by 1with each rising edge of the clock
//   - When the enable signal is high and the reverse input is high, the counter
//  should decrement by 1 witheach rising edge of the clock
//   - When the reset signal is high (at any point in time), the counter value
//  should be reset to 0 immediately
//////////////////////////////////////////////////////////////////////////////////


module up_down_counter_tb(
  );
  
  wire [15:0] t_out;
  reg t_clk = 0, t_reverse = 0, t_reset = 0, t_enable = 0;
  
  integer i;
  
  up_down_counter dut(
    .out(t_out),
    .clk(t_clk),
    .reverse(t_reverse),
    .reset(t_reset),
    .enable(t_enable)
  );
  
  initial begin: CLOCKBLOCK
    forever begin
      #10 t_clk <= ~t_clk;
    end
  end
    
  initial begin: TESTBLOCK
    
    //test functionality aligned with specifications
    t_enable <= 0;
    t_reverse <= 0;
    t_reset <= 0;
    i=0;  
    #15 
  
    t_reset <= 1;
    #10;
  
    t_enable <= 1;
    t_reset <= 0;
    #20;
    if (t_out[15:0]!=16'b1) $fatal("initial clock test case failed");
       
    t_reset <= 1;
    #10; 
    if (t_out[15:0]!=16'b0) $fatal("zero reset test case failed");
    
    t_reset <= 0;    
    for(i=1; i<=65536; i=i+1) begin
      #20;
      if (t_out[15:0]!=i[15:0]) $fatal("enable up test case failed");
      
      t_enable <= 0;
      #20;
      if (t_out[15:0]!=i[15:0]) $fatal("disable up test case failed");
      
      t_enable <= 1;  
    end
  
    t_reverse <= 1;
    for(i=65535; i>=0; i=i-1) begin
      #20;
      if (t_out[15:0]!=i[15:0]) $fatal("enable down test case failed");
      
      t_enable <= 0;
      #20;
      if (t_out[15:0]!=i[15:0]) $fatal("disable down test case failed");
      
      t_enable <= 1;  
    end
    
    //test functionality not aligned with specifications
    
    //reset left on
    t_reset <= 1;
    #20;
    if (t_out[15:0]!=16'b0) $fatal("reset left on test case failed");
      
    t_enable <= 0;
    #20;
    if (t_out[15:0]!=16'b0) $fatal("reset left on test case failed");
      
    t_enable <= 1;  
    t_reverse <= 1;
    #20; 
    if (t_out[15:0]!=16'b0) $fatal("reset left on test case failed");
     
    t_enable <= 0;
    #20;
    if (t_out[15:0]!=16'b0) $fatal("reset left on test case failed");
      
    t_enable <= 1;
  
    $display("All tests passed");
    $finish;

  end
endmodule

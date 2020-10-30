`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2020 10:32:16 PM
// Design Name: 
// Module Name: remainder_long_division_tb
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


module remainder_long_division_tb(

    );
    
  reg [31:0] t_N, t_D;
  wire [31:0] t_Q;
  wire [30:0] t_R;
  reg t_clk = 0, t_reset = 0, t_VALID=0;
  
  remainder_long_division_top dut(
    .Q(t_Q),
    .R(t_R),
    .N(t_N),
    .D(t_D),
    .clk(t_clk),
    .VALID(t_VALID),
    .reset(t_reset),
    .READY(t_READY),
    .div_zero_err(t_div_zero_err)
  );
  
  initial begin: CLOCKBLOCK
    forever begin
      #10 t_clk <= ~t_clk;
    end
  end
      
  initial begin: TESTBLOCK
    
    //test functionality aligned with specifications

    t_reset <= 0;  
    #15 
  
    t_reset <= 1;
    #10;
    
    t_reset <= 0;
    #10;
    
    
    // divide 50 by 2 just to make sure things are going smoothly for an easily verifiable testcase
    t_VALID <= 1;
    t_N <= 32'b110010;
    t_D <= 32'b10;
    #610;
    if (t_Q[31:0]!=32'd25) $fatal("50/2 failed for Q #div1");
    if (t_R[31:0]!=32'd0) $fatal("50/2 failed for R #div1");
    
    t_reset <= 1;
    t_VALID <= 0;
    #20;
    
    // divide 51 by 2 just to make sure things are going smoothly for an easily verifiable testcase
    t_reset <= 0;
    t_VALID <= 1;
    t_N <= 32'b110011;
    t_D <= 32'b10;
    #610;
    if (t_Q[31:0]!=32'd25) $fatal("51/2 failed for Q #div2");
    if (t_R[31:0]!=32'd1) $fatal("51/2 failed for R #div2");
    
    t_reset <= 1;
    t_VALID = 0;
    #20;
    
    // divide 0xFFFFFFFF by itself just to make sure things are going smoothly the largest possible division
   /*
    t_reset <= 0;
    t_VALID <= 1;
    t_N <= 32'hFFFFFFFF;
    t_D <= 32'hFFFFFFFF;
    #630;
    if (t_Q[31:0]!=32'd1) $fatal("0xFFFFFFFF/0xFFFFFFFF failed for Q #div3");
    if (t_R[31:0]!=32'd0) $fatal("0xFFFFFFFF/0xFFFFFFFF failed for R #div3");
   */
    t_reset <= 1;
    t_VALID = 0;
    #20;
    
    // divide 0xAAAAAAAA by 1 to make sure the remainder function alternates smoothly between 0 and 1 for each bit
    t_reset <= 0;
    t_VALID <= 1;
    t_N <= 32'hAAAAAAAA;
    t_D <= 32'h1;
    #650;
    if (t_Q[31:0]!=32'hAAAAAAAA) $fatal("0xAAAAAAAA/1 failed for Q #div4");
    if (t_R[31:0]!=32'd0) $fatal("0xAAAAAAAA/1 failed for R #div4");
    
    t_reset <= 1;
    t_VALID = 0;
    #20;
    
    // divide 0x55555555 by 1 to make sure the remainder function alternates smoothly between 1 and 0 for each bit
   /* 
    t_reset <= 0;
    t_VALID <= 1;
    t_N <= 32'h55555555;
    t_D <= 32'h1;
    #650;
    if (t_Q[31:0]!=32'h55555555) $fatal("0x55555555/1 failed for Q #div5");
    if (t_R[31:0]!=32'd0) $fatal("0x55555555/1 failed for R #div5");
   
    t_reset <= 1;
    t_VALID = 0;
    #20;
    
    // divide 0x55555555 by 0xFFFFFFFF to make sure the remainder functionality work when N < D
    t_reset <= 0;
    t_VALID <= 1;
    t_N <= 32'h55555555;
    t_D <= 32'hFFFFFFFF;
    #630;
    if (t_Q[31:0]!=32'h0) $fatal("0x55555555/0xFFFFFFFF failed for Q #div6");
    if (t_R[31:0]!=32'h55555555) $fatal("0x55555555/0xFFFFFFFF failed for R #div6");
   */
    
    t_reset <= 1;
    t_VALID = 0;
    #30;
    
    // divide 0 by 1 to make sure 0 div anything is 0
    t_N <= 32'h0;
    t_D <= 32'h1;
    #20;
    t_N <= 32'h0;
    t_D <= 32'h1;
    t_reset <= 0;
    t_VALID <= 1;
    #610;
    if (t_Q[31:0]!=32'h0) $fatal("0/1 failed for Q #div7");
    if (t_R[31:0]!=32'h0) $fatal("0/1 failed for R #div7");
    
    t_reset <= 1;
    t_VALID = 0;
    #20;
    
    // divide 0 by 0 to make sure div 0 error works
    t_reset <= 0;
    t_VALID <= 1;
    t_N <= 32'h0;
    t_D <= 32'h0;
    #610;
    if (t_div_zero_err !=32'h1) $fatal("0/0 failed for #div8");
    
    t_reset <= 1;
    t_VALID = 0;
    #20;
    
    
    // the most meaningful testcases have been done. The rest are mostly random
    
    t_reset <= 0;
    t_VALID <= 1;
    t_N <= 32'h11111111;
    t_D <= 32'hFF;
    #630;
    if (t_Q[31:0] != 32'h112233) $fatal("Q #div9");
    if (t_R[31:0]!= 32'h44) $fatal("R #div9");
    
    t_reset <= 1;
    t_VALID = 0;
    #20;
    
    t_reset <= 0;
    t_VALID <= 1;
    t_N <= 32'h11111111;
    t_D <= 32'hEFF;
    #610;
    if (t_Q[31:0] != 32'h12358) $fatal("Q #div10");
    if (t_R[31:0]!= 32'hC69) $fatal("R #div10");
    
    t_reset <= 1;
    t_VALID = 0;
    #20;
    
    /*
    t_reset <= 0;
    t_VALID <= 1;
    t_N <= 32'hFFCF1F11;
    t_D <= 32'hEFF;
    #650;
    if (t_Q[31:0] != 32'h110EF2) $fatal("Q #div11");
    if (t_R[31:0]!= 32'h3) $fatal("R #div11");
    
    t_reset <= 1;
    t_VALID = 0;
    #20;
    
    t_reset <= 0;
    t_VALID <= 1;
    //t_N <= 32'hBFCF1F0;
    //t_D <= 32'hEFF;
    t_N <= 32'hBCF1F0;
    t_D <= 32'hFF;
    #630;
    if (t_Q[31:0] != 32'hBDAF) $fatal("Q #div12");
    if (t_R[31:0]!= 32'h9F) $fatal("R #div12");
    
    t_reset <= 1;
    t_VALID = 0;
    #20;
    
    t_reset <= 0;
    t_VALID <= 1;
    t_N <= 32'hFBFCF1F0;
    t_D <= 32'hFF;
    #650;
    if (t_Q[31:0] != 32'hFCF9EB) $fatal("Q #div13");
    if (t_R[31:0]!= 32'hDB) $fatal("R #div13");
    */
    t_reset <= 1;
    t_VALID = 0;
    #20;
    
    t_reset <= 0;
    t_VALID <= 1;
    //t_N <= 32'hFBFCF1F0;
    //t_D <= 32'hBEEF;
    t_N <= 32'd27;
    t_D <= 32'd5;
    #610;
    if (t_Q[31:0] != 32'd5) $fatal("Q #div14");
    if (t_R[31:0]!= 32'd2) $fatal("R #div14");
    
    t_reset <= 1;
    t_VALID = 0;
    #20;
    
    t_reset <= 0;
    t_VALID <= 1;
    //t_N <= 32'hFBFCF1F0;
    //t_D <= 32'hBEEF;
    t_N <= 32'hFFFFFFE5; // -27
    t_D <= 32'd5;
    #610;
    if (t_Q[31:0] != 32'hFFFFFFFA) $fatal("Q #div15"); // -6
    if (t_R[31:0]!= 32'd3) $fatal("R #div15");
    
    t_reset <= 1;
    t_VALID = 0;
    #20;
    
    t_reset <= 0;
    t_VALID <= 1;
    //t_N <= 32'hFBFCF1F0;
    //t_D <= 32'hBEEF;
    t_N <= 32'd27; 
    t_D <= 32'hFFFFFFFB; // -5
    #610;
    if (t_Q[31:0] != 32'hFFFFFFFB) $fatal("Q #div16"); // -5
    if (t_R[31:0]!= 32'd2) $fatal("R #div16");
    
    t_reset <= 1;
    t_VALID = 0;
    #20;
    
    t_reset <= 0;
    t_VALID <= 1;
    //t_N <= 32'hFBFCF1F0;
    //t_D <= 32'hBEEF;
    t_N <= 32'hFFFFFFE5; // -27
    t_D <= 32'hFFFFFFFB; // -5
    #610;
    if (t_Q[31:0] != 32'd6) $fatal("Q #div17");
    if (t_R[31:0]!= 32'd3) $fatal("R #div17");
    
    t_reset <= 1;
    t_VALID = 0;
    #20;
    
    
    /*
    t_reset <= 0;
    t_VALID <= 1;
    t_N <= 32'hFFFFFFFF;
    t_D <= 32'hBEEF;
    #630;
    if (t_Q[31:0] != 32'h1573D) $fatal("Q #div15");
    if (t_R[31:0]!= 32'h480C) $fatal("R #div15");
    
    t_reset <= 1;
    t_VALID = 0;
    #20;
    
    t_reset <= 0;
    t_VALID <= 1;
    t_N <= 32'hFFFFFFFF;
    t_D <= 32'hBEEFBEEF;
    #610;
    if (t_Q[31:0] != 32'h1) $fatal("Q #div16");
    if (t_R[31:0]!= 32'h41104110) $fatal("R #div16");
    
    t_reset <= 1;
    t_VALID = 0;
    #20;
    
    t_reset <= 0;
    t_VALID <= 1;
    t_N <= 32'hFFFFFFFF;
    t_D <= 32'h55555555;
    #630;
    if (t_Q[31:0] != 32'h3) $fatal("Q #div17");
    if (t_R[31:0]!= 32'h0) $fatal("R #div17");
    */
    t_reset <= 1;
    t_VALID = 0;
    #20;
    
    
    
    
    // divide 1316389 by 3 to make sure div 0 error works
    t_reset <= 0;
    t_VALID <= 1;
    t_N <= 32'h1316389;
    t_D <= 32'h3;
    #630;
    if (t_Q[31:0] != 32'h65CBD8) $fatal("1316389/3 failed for Q #div18");
    if (t_R[31:0]!= 32'h1) $fatal("1316389/3 failed for R #div18");
    
    t_reset <= 1;
    t_VALID = 0;
    #20;
    
    // divide 131638 by 93 to make sure div 0 error works
    t_reset <= 0;
    t_VALID <= 1;
    t_N <= 32'h131638;
    t_D <= 32'h93;
    #650;
    if (t_Q[31:0] != 32'h213D) $fatal("131638/93 failed for Q #div19");
    if (t_R[31:0]!= 32'h31) $fatal("131638/93 failed for R #div19");
    
    t_reset <= 1;
    t_VALID = 0;
    #20;
    
    // divide 13163 by 893 to make sure div 0 error works
    t_reset <= 0;
    t_VALID <= 1;
    t_N <= 32'h13163;
    t_D <= 32'h893;
    #630;
    if (t_Q[31:0] != 32'h23) $fatal("13163/893 failed for Q #div20");
    if (t_R[31:0]!= 31'h54A) $fatal("13163/893 failed for R #div20");
    
    t_reset <= 1;
    t_VALID = 0;
    #20;
    
    $display("All tests passed!!!!!");
    $finish;
  
  end
    
endmodule

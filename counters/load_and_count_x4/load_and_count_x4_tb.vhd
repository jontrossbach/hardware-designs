----------------------------------------------------------------------------------
-- University: New York University
-- Engineer: Jon Trossbach
-- 
-- Create Date: 09/26/2020 03:22:59 PM
-- Module Name: load_and_count_x4 
-- Description: Test bench for a 32-bit counter that adds 4 at each clock edge. Upon reset, the 
-- counter drops to zero. When the load input is on during a clock edge a new
-- 32-bit value, D, is loaded into the counter.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use std.env.finish;

entity load_and_count_x4_tb is
--  Port ( );
end load_and_count_x4_tb;

architecture Behavioral of load_and_count_x4_tb is
  signal t_clk : std_logic := '0';
  signal t_reset : std_logic := '0';
  signal t_load : std_logic := '0';
  signal t_output : unsigned(31 downto 0);
  signal t_D : unsigned(31 downto 0);
  
  constant CLK_PERIOD : TIME := 20ns; 
   
begin

  TestCounter : entity work.load_and_count_x4 port map (
    output => t_output,
    clk => t_clk,
    reset => t_reset,
    load => t_load,
    D => t_D
  );

  gen_clock : process
  begin

    wait for (CLK_PERIOD/2);
    t_clk <= not t_clk;

  end process;
  
    test_behaviour : process
    begin
  
    t_reset <= '0'; 
    wait for CLK_PERIOD/4; 
    wait for CLK_PERIOD/2;
    
    t_reset <= '1';
    wait for CLK_PERIOD/2;
  
    t_reset <= '0';
    wait for CLK_PERIOD;
    assert(t_output=to_unsigned(1,32)) report "initial clock test case failed" severity error; 
   
    t_reset <= '1';
    wait for CLK_PERIOD/2; 
    assert(t_output=to_unsigned(0,32)) report "zero reset test case failed 1" severity error;
    
    t_reset <= '0';    
    for i in 1 to 65535 loop
      wait for CLK_PERIOD/2;
      assert(t_output=to_unsigned(i,32)*4) report "enable up test case failed" severity error; 
    end loop;
    
    t_D <= to_unsigned(1,32);
    t_load <= '1';
    wait for CLK_PERIOD/2;
    t_load <= '0';    
    for i in 1 to 65535 loop
      wait for CLK_PERIOD/2;
      assert(t_output=to_unsigned(i,32)*4+1) report "enable up test case failed" severity error; 
    end loop;
    
    t_D <= to_unsigned(2,32);
    t_load <= '1';
    wait for CLK_PERIOD/2;
    t_load <= '0';    
    for i in 1 to 65535 loop
      wait for CLK_PERIOD/2;
      assert(t_output=to_unsigned(i,32)*4+2) report "enable up test case failed" severity error; 
    end loop;
    
    t_D <= to_unsigned(3,32);
    t_load <= '1';
    wait for CLK_PERIOD/2;
    t_load <= '0';    
    for i in 1 to 65535 loop
      wait for CLK_PERIOD/2;
      assert(t_output=to_unsigned(i,32)*4+3) report "enable up test case failed" severity error; 
    end loop;
    
    --test functionality not aligned with specifications
    
    --reset left on
    t_reset <= '1';
    wait for CLK_PERIOD;
    assert(t_output=to_unsigned(0,32)) report "zero reset test case failed 2" severity error;
    

    wait for CLK_PERIOD;
    assert(t_output=to_unsigned(0,32)) report "reset left on test case failed 1" severity error;   

    wait for CLK_PERIOD; 
    assert(t_output=to_unsigned(0,32)) report "reset left on test case failed 2" severity error;
   
    wait for CLK_PERIOD;
    assert(t_output=to_unsigned(0,32)) report "reset left on test case failed 3" severity error;
    
    --load left on
    t_reset <= '0';
    t_load <= '1';
    wait for 2*CLK_PERIOD;
    assert(t_output=to_unsigned(3,32)) report "load left on test case failed" severity error;
    
    report "all tests passed";
    finish;
  
  end process;
end Behavioral;

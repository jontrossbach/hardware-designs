----------------------------------------------------------------------------------
-- University: New York University
-- Engineer: Jon Trossbach
-- 
-- Create Date: 09/26/2020 03:22:59 PM
-- Module Name: up_down_counter 
-- Description: Test bench for 16-bit counter ith "clk", "enable", "reset", and
-- "reverse" inputs:
--   - When the enable signal is high and the reverse input is low, the counter 
--  value should increment by 1with each rising edge of the clock
--   - When the enable signal is high and the reverse input is high, the counter
--  should decrement by 1 witheach rising edge of the clock
--   - When the reset signal is high (at any point in time), the counter value
--  should be reset to 0 immediately
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use std.env.finish;

entity up_down_counter_tb is
--  Port ( );
end up_down_counter_tb;

architecture Behavioral of up_down_counter_tb is
  signal t_clk : std_logic := '0';
  signal t_reverse : std_logic := '0';
  signal t_reset : std_logic := '0';
  signal t_enable : std_logic := '0';
  signal t_output : unsigned(15 downto 0);
  
  constant CLK_PERIOD : TIME := 20ns; 
   
begin

  TestCounter : entity work.up_down_counter port map (
    output => t_output,
    clk => t_clk,
    reverse => t_reverse,
    reset => t_reset,
    enable => t_enable
  );

  gen_clock : process
  begin

    wait for (CLK_PERIOD/2);
    t_clk <= not t_clk;

  end process;
  
    test_behaviour : process
    begin
  
    t_enable <= '0';
    t_reverse <= '0';
    t_reset <= '0'; 
    wait for CLK_PERIOD/4; 
    wait for CLK_PERIOD/2;
    
    t_reset <= '1';
    wait for CLK_PERIOD/2;
  
    t_enable <= '1';
    t_reset <= '0';
    wait for CLK_PERIOD/2;
    assert(t_output=to_unsigned(1,16)) report "initial clock test case failed" severity error; 
   
    t_reset <= '1';
    wait for CLK_PERIOD/2;
    assert(t_output=to_unsigned(0,16)) report "zero reset test case failed 1" severity error;
    
    t_reset <= '0';    
    for i in 1 to 65535 loop
      wait for CLK_PERIOD/2;
      assert(t_output=to_unsigned(i,16)) report "enable up test case failed" severity error;
      
      t_enable <= '0';
      wait for CLK_PERIOD/2;
      assert(t_output=to_unsigned(i,16)) report "disable up test case failed" severity error;
      
      t_enable <= '1';  
    end loop;
    
    t_reverse <= '1';
    for j in 0 to 65535 loop
      
      wait for CLK_PERIOD/2;
      assert(t_output=to_unsigned(65534-j,16)) report "enable down test case failed" severity error;
    
      t_enable <= '0';
      wait for CLK_PERIOD/2;
      assert(t_output=to_unsigned(65534-j,16)) report "disable down test case failed" severity error;
    
      t_enable <= '1';  
    end loop;
    
    --test functionality not aligned with specifications
    
    --reset left on
    t_reverse <= '0';
    t_reset <= '1';
    wait for CLK_PERIOD;
    assert(t_output=to_unsigned(0,16)) report "zero reset test case failed 2" severity error;
    
    t_enable <= '0';
    wait for CLK_PERIOD;
    assert(t_output=to_unsigned(0,16)) report "reset left on test case failed 1" severity error;
    
    t_enable <= '1';  
    t_reverse <= '1';
    wait for CLK_PERIOD; 
    assert(t_output=to_unsigned(0,16)) report "reset left on test case failed 2" severity error;
   
    t_enable <= '0';
    wait for CLK_PERIOD;
    assert(t_output=to_unsigned(0,16)) report "reset left on test case failed 3" severity error;

    finish;
  
  end process;
end Behavioral;

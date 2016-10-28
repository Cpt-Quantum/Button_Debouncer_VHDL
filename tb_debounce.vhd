----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.10.2016 11:47:00
-- Design Name: 
-- Module Name: tb_debounce - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library work;
use work.Package_debounce.all;
use work.Package_btns_leds.all;

entity tb_debounce is
--  Port ( );
end tb_debounce;

architecture Behavioral of tb_debounce is
    signal tb_clk : STD_LOGIC := '0';
    signal tb_reset : STD_LOGIC := '0';
    
    signal tb_btn_raw_input : STD_LOGIC_VECTOR(3 downto 0);
    signal tb_led_state : STD_LOGIC_VECTOR(3 downto 0);    
begin
    --Clock block: Setup a clock at 100 MHz
    tb_clk <= not(tb_clk) after 5 ns;
    --End of clock block
    
    --Instantiate the top module
    tb_btns_leds : btns_leds
        Port map(
            CLK100MHZ => tb_clk, 
            reset => tb_reset,
            btn => tb_btn_raw_input,
            led => tb_led_state       
        );
    --End of instantiation of top module
    
    
    --Simulation block
    Simulation : block begin
        Simulation_proc : process
        begin
            --if rising_edge(tb_clk) then
                tb_reset <= '1';
                
                wait for 1 us;
                
                tb_reset <= '0';
                
                tb_btn_raw_input(0) <= '1';
                tb_btn_raw_input(1) <= '1';
                tb_btn_raw_input(2) <= '0';
                tb_btn_raw_input(3) <= '1';
                
                wait for 10 ns;
                
                tb_btn_raw_input(0) <= '0';
                tb_btn_raw_input(2) <= '1';
                
                wait for 70 ns;
                
                tb_btn_raw_input(0) <= '0';
                tb_btn_raw_input(1) <= '0';
                tb_btn_raw_input(2) <= '1';
                wait for 12000000 ns;
                                
            --end if;
        end process Simulation_proc;    
    end block Simulation;
    
end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.10.2016 10:29:49
-- Design Name: 
-- Module Name: debounce - Behavioral
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
use work.Package_Counter.all;

entity debounce is
    Generic(
            Number_of_samples   : integer
            );
    Port(
        clk             : in STD_LOGIC;
        reset           : in STD_LOGIC;
        clk_enable      : in STD_LOGIC;
        btn_raw_input   : in STD_LOGIC;
        btn_state       : out STD_LOGIC
        );
end debounce;

architecture Behavioral of debounce is
signal btn_state_reg : STD_LOGIC_VECTOR(Number_of_samples downto 0);
signal on_compare_reg : STD_LOGIC_VECTOR(Number_of_samples downto 0);
signal off_compare_reg : STD_LOGIC_VECTOR(Number_of_samples downto 0);
begin
    
    --Setup compate registers
    on_compare_reg <= (others=>'1');
    off_compare_reg <= (others=>'0');
    
    --Read btn raw input into register
    raw_input_proc : process(clk)
    begin
        if rising_edge(clk) then
            if clk_enable = '1' then
                btn_state_reg(0) <= btn_raw_input;
                --Now shift bits left
                btn_state_reg(Number_of_samples downto 1) <= btn_state_reg((Number_of_samples-1) downto 0);
            end if;        
        end if; --Clock edge if
    end process raw_input_proc;
    
    --Compare raw register to desired value
    compare_proc : process(clk)
    begin
        if rising_edge(clk) then
            if btn_state_reg = on_compare_reg then
                btn_state <= '1';
            elsif btn_state_reg = off_compare_reg then
                btn_state <= '0';
            end if;
        end if; --Clock edge if
    end process compare_proc;
    
end Behavioral;

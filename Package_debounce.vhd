----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.10.2016 11:48:39
-- Design Name: 
-- Module Name: Package_debounce - Behavioral
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
package Package_debounce is 

component debounce is
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
end component;

end package Package_debounce;

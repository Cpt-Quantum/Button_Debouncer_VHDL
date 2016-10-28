----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.10.2016 14:49:35
-- Design Name: 
-- Module Name: Package_btns_leds - Behavioral
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

--Component declaration for tb, comment if this is the top module
package package_btns_leds is
component btns_leds is
    Port(
        CLK100MHZ : in STD_LOGIC;
        reset : in STD_LOGIC;
        btn : in STD_LOGIC_VECTOR(3 downto 0);
        led : out STD_LOGIC_VECTOR(3 downto 0)       
    );
end component btns_leds;
end package package_btns_leds;

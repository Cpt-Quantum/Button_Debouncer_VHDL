----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.10.2016 15:06:52
-- Design Name: 
-- Module Name: btn_leds - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library work;
use work.Package_debounce.all;
use work.Package_Counter.all;

entity btns_leds is
    Port(
        CLK100MHZ : in STD_LOGIC;
        reset : in STD_LOGIC; 
        btn : in STD_LOGIC_VECTOR(3 downto 0);
        led : out STD_LOGIC_VECTOR(3 downto 0)       
    );
end btns_leds;

architecture Behavioral of btns_leds is
--A buffer to hold the output of the debouncer, to pass to the LEDs
signal btn_buffer : STD_LOGIC_VECTOR(3 downto 0);
--Counter variables, note that debounce clear is used 
signal debounce_clk_clear : STD_LOGIC;
signal debounce_clk_inc : STD_LOGIC;
signal debounce_clk_count : STD_LOGIC_VECTOR(17 downto 0);
begin
    
    --Generate a counter which clears every 1kHz
    debounce_clk : Counter
        Generic map(Counter_size => 17)
        Port map(
            reset => reset,
            clk  => CLK100MHZ,
            clear => debounce_clk_clear,
            inc => debounce_clk_inc,
            count => debounce_clk_count
            );
            
    --Use count to generate clear signal which is fed to the clk_enable signal
    debounce_clk_proc : process(CLK100MHZ)
    begin
        if rising_edge(CLK100MHZ) then
            debounce_clk_inc <= '1';
            if debounce_clk_count = STD_LOGIC_VECTOR(to_unsigned(100,18)) then
                debounce_clk_clear <= '1';
            else 
                debounce_clk_clear <= '0';
            end if;            
        end if; --Clock edge if
    end process debounce_clk_proc;
    
    --Assign buttons to a corresponding debouncer
    generate_btns:
    for btn_num in 0 to 3 generate
        debounce_btn : debounce 
            Generic map(
                        Number_of_samples => 9
                        )
            Port map(
                    clk => CLK100MHZ,
                    reset => '0',
                    clk_enable => debounce_clk_clear,
                    btn_raw_input => btn(btn_num),
                    btn_state => btn_buffer(btn_num)
                    );
    end generate generate_btns;
    
    --Assign LED states to debounced buttons
    led <= btn_buffer;

end Behavioral;

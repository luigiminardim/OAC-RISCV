LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

USE std.textio.ALL;
ENTITY rom_rvTestbench IS
END rom_rvTestbench;

ARCHITECTURE testbench OF rom_rvTestbench IS
  COMPONENT rom_rv IS
    PORT (
      address : IN std_logic_vector;
      dataout : OUT std_logic_vector
    );
  END COMPONENT rom_rv;
  SIGNAL address : std_logic_vector(7 DOWNTO 0);
  SIGNAL dataout : std_logic_vector(31 DOWNTO 0);
BEGIN
  data_mem : rom_rv PORT MAP(
    address => address,
    dataout => dataout
  );

  test_data_mem_process : PROCESS BEGIN
    FOR i IN 0 TO 255 LOOP
      address <= std_logic_vector(to_unsigned(i, 8));

      -- Test read
      WAIT FOR 10 ns;
      ASSERT dataout = std_logic_vector(to_unsigned(i, 32)) REPORT "Error in read. dataout =" & to_hstring(dataout) & "; expected = " & to_hstring(std_logic_vector(to_unsigned(i, 32))) SEVERITY error;
    END LOOP;
    REPORT "Test finished";
    WAIT;
  END PROCESS;
END testbench;
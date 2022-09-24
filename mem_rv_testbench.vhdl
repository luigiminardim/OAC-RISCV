LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY mem_rvTestbench IS
END mem_rvTestbench;

ARCHITECTURE testbench OF mem_rvTestbench IS
  COMPONENT mem_rv IS
    PORT (
      clock : IN std_logic;
      we : IN std_logic;
      address : IN std_logic_vector;
      datain : IN std_logic_vector;
      dataout : OUT std_logic_vector
    );
  END COMPONENT mem_rv;
  SIGNAL clock : std_logic;
  SIGNAL we : std_logic;
  SIGNAL address : std_logic_vector(7 DOWNTO 0);
  SIGNAL datain : std_logic_vector(31 DOWNTO 0);
  SIGNAL dataout : std_logic_vector(31 DOWNTO 0);
BEGIN
  DUT : mem_rv PORT MAP(
    clock => clock,
    we => we,
    address => address,
    datain => datain,
    dataout => dataout
  );
  PROCESS BEGIN
    FOR i IN 0 TO 254 LOOP
      -- Test write
      clock <= '0';
      we <= '1';
      address <= std_logic_vector(to_unsigned(i, 8));
      datain <= std_logic_vector(to_unsigned(i, 30)) & "00";
      WAIT FOR 10 ns;
      clock <= '1';
      WAIT FOR 10 ns;
      ASSERT dataout = datain REPORT "Error in write. dataout =" & to_hstring(dataout) SEVERITY error;

      -- Test no write
      datain <= std_logic_vector(to_unsigned(i + 1, 30)) & "00";
      clock <= '0';
      WAIT FOR 10 ns;
      ASSERT dataout /= datain REPORT "Error in clock down. dataout =" & to_hstring(dataout) SEVERITY error;

      -- Test !we
      we <= '0';
      clock <= '1';
      datain <= std_logic_vector(to_unsigned(i + 2, 30)) & "00";
      WAIT FOR 10 ns;
      ASSERT dataout /= datain REPORT "Error in !we. dataout =" & to_hstring(dataout) SEVERITY error;
    END LOOP;
    WAIT;
  END PROCESS;
END testbench;
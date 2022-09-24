LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

USE std.textio.ALL;
ENTITY mem_rvTestbench IS
END mem_rvTestbench;

ARCHITECTURE testbench OF mem_rvTestbench IS
  TYPE instructions_mem_type IS ARRAY (255 DOWNTO 0) OF std_logic_vector(32 DOWNTO 0);

  IMPURE FUNCTION get_instructions RETURN instructions_mem_type IS
    FILE text_file : text OPEN read_mode IS "instructions.txt";
    VARIABLE text_line : line;
    VARIABLE instruction : std_logic_vector(32 DOWNTO 0);
    VARIABLE instrucions : instructions_mem_type;
  BEGIN
    FOR i IN 0 TO 256 - 1 LOOP
      readline(text_file, text_line);
      hread(text_line, instruction);
      REPORT to_hstring(instruction);
    END LOOP;
    RETURN instrucions;
  END FUNCTION;
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
  SIGNAL instructions : instructions_mem_type := get_instructions;
BEGIN
  data_mem : mem_rv PORT MAP(
    clock => clock,
    we => we,
    address => address,
    datain => datain,
    dataout => dataout
  );

  test_data_mem_process : PROCESS BEGIN
    FOR i IN 0 TO 254 LOOP
      address <= std_logic_vector(to_unsigned(i, 8));
      datain <= std_logic_vector(to_unsigned(i, 30)) & "00";

      -- Test write
      clock <= '0';
      we <= '1';
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

      -- Test instructions
      -- ASSERT (instructions(i) = std_logic_vector(to_unsigned(i, 32))) REPORT "Error in reading instructions. instructions(i) = " & to_hstring(instructions(i)) SEVERITY error;
    END LOOP;
    WAIT;
  END PROCESS;
END testbench;
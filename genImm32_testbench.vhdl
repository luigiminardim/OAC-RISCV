LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL; -- Imports the standard textio package.

ENTITY genImm32Testbench IS
END genImm32Testbench;

ARCHITECTURE genImm32Testbench OF genImm32Testbench IS
  COMPONENT genImm32 IS
    PORT (
      instr : IN std_logic_vector(31 DOWNTO 0);
      imm32 : OUT signed(31 DOWNTO 0)
    );
  END COMPONENT;
  SIGNAL instr : std_logic_vector(31 DOWNTO 0);
  SIGNAL imm32 : signed(31 DOWNTO 0);
BEGIN
  dut : genImm32 PORT MAP(
    instr => instr,
    imm32 => imm32);
  PROCESS
  BEGIN
    -- R-type
    instr <= X"000002b3";
    WAIT FOR 10 ps;
    ASSERT (imm32 = X"00000000") REPORT "Erro formato R-type" SEVERITY error;
    -- I-type0
    instr <= X"01002283";
    WAIT FOR 10 ps;
    ASSERT (imm32 = X"00000010") REPORT "Erro formato I-type0" SEVERITY error;
    -- I-type1
    instr <= X"f9c00313";
    WAIT FOR 10 ps;
    ASSERT (imm32 = X"FFFFFF9C") REPORT "Erro formato I-type1 1" SEVERITY error;
    instr <= x"fff2c293";
    WAIT FOR 10 ps;
    ASSERT (imm32 = X"FFFFFFFF") REPORT "Erro formato I-type1 2" SEVERITY error;
    instr <= x"16200313";
    WAIT FOR 10 ps;
    ASSERT (imm32 = X"00000162") REPORT "Erro formato I-type1 3" SEVERITY error;
    -- I-type2
    instr <= x"01800067";
    WAIT FOR 10 ps;
    ASSERT (imm32 = X"00000018") REPORT "Erro formato I-type2" SEVERITY error;
    -- S-type
    instr <= x"02542e23";
    WAIT FOR 10 ps;
    ASSERT (imm32 = X"0000003C") REPORT "Erro formato S-type" SEVERITY error;
    -- SB-type
    instr <= x"fe5290e3";
    WAIT FOR 10 ps;
    ASSERT (imm32 = X"FFFFFFE0") REPORT "Erro formato SB-type" SEVERITY error;
    -- U-type
    instr <= x"00002437";
    WAIT FOR 10 ps;
    ASSERT (imm32 = X"00002000") REPORT "Erro formato U-type" SEVERITY error;
    -- UJ-type
    instr <= x"00c000ef";
    WAIT FOR 10 ps;
    ASSERT (imm32 = X"0000000C") REPORT "Erro formato UJ-type" SEVERITY error;
    -- End
    REPORT "Final dos testes";
    WAIT;
  END PROCESS;
END genImm32Testbench;
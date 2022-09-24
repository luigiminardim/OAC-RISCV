LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL; -- Imports the standard textio package.

ENTITY ulaRVTestBench IS
END ulaRVTestBench;

ARCHITECTURE ulaRVTestBench OF ulaRVTestBench IS
  COMPONENT ulaRV IS
    PORT (
      opcode : IN std_logic_vector(3 DOWNTO 0);
      a, b : IN std_logic_vector(31 DOWNTO 0);
      z : OUT std_logic_vector(31 DOWNTO 0)
    );
  END COMPONENT;
  SIGNAL opcode : std_logic_vector(3 DOWNTO 0);
  SIGNAL a, b, z : std_logic_vector(31 DOWNTO 0);
BEGIN
  dut : ulaRV PORT MAP(
    opcode => opcode,
    a => a,
    b => b,
    z => z);
  PROCESS
  BEGIN
    -- ADD
    opcode <= "0000";
    a <= X"00000001";
    b <= X"00000002";
    WAIT FOR 10 ps;
    ASSERT (z = X"00000003") REPORT "Erro ADD" SEVERITY error;
    -- SUB
    opcode <= "0001";
    a <= X"00000001";
    b <= X"00000002";
    WAIT FOR 10 ps;
    ASSERT (z = X"FFFFFFFF") REPORT "Erro SUB" SEVERITY error;
    -- AND
    opcode <= "0010";
    a <= X"FFFF0000";
    b <= X"FF00FF00";
    WAIT FOR 10 ps;
    ASSERT (z = X"FF000000") REPORT "Erro AND" SEVERITY error;
    -- OR
    opcode <= "0011";
    a <= X"FFFF0000";
    b <= X"FF00FF00";
    WAIT FOR 10 ps;
    ASSERT (z = X"FFFFFF00") REPORT "Erro OR" SEVERITY error;
    -- XOR
    opcode <= "0100";
    a <= X"FFFF0000";
    b <= X"FF00FF00";
    WAIT FOR 10 ps;
    ASSERT (z = X"00FFFF00") REPORT "Erro XOR" SEVERITY error;
    -- SLL
    opcode <= "0101";
    a <= X"00000001";
    b <= X"00000002";
    WAIT FOR 10 ps;
    ASSERT (z = X"00000004") REPORT "Erro SLL" SEVERITY error;
    -- SRL
    opcode <= "0110";
    a <= X"00000004";
    b <= X"00000002";
    WAIT FOR 10 ps;
    ASSERT (z = X"00000001") REPORT "Erro SRL" SEVERITY error;
    -- SRA
    opcode <= "0111";
    a <= X"80000004";
    b <= X"00000002";
    WAIT FOR 10 ps;
    ASSERT (z = X"E0000001") REPORT "Erro SRA" SEVERITY error;
    -- SLT 0
    opcode <= "1000";
    a <= X"00000001";
    b <= X"FFFFFFFF";
    WAIT FOR 10 ps;
    ASSERT (z = X"00000000") REPORT "Erro SLT 0" SEVERITY error;
    -- SLT 1
    opcode <= "1000";
    a <= X"FFFFFFFF";
    b <= X"00000001";
    WAIT FOR 10 ps;
    ASSERT (z = X"00000001") REPORT "Erro SLT 1" SEVERITY error;
    --- SLTU 1
    opcode <= "1001";
    a <= X"00000001";
    b <= X"FFFFFFFF";
    WAIT FOR 10 ps;
    ASSERT (z = X"00000001") REPORT "Erro SLTU 0" SEVERITY error;
    -- SLTU 0
    opcode <= "1001";
    a <= X"FFFFFFFF";
    b <= X"00000001";
    WAIT FOR 10 ps;
    ASSERT (z = X"00000000") REPORT "Erro SLTU 1" SEVERITY error;
    -- SGE 0
    opcode <= "1010";
    a <= X"FFFFFFFF";
    b <= X"00000001";
    WAIT FOR 10 ps;
    ASSERT (z = X"00000000") REPORT "Erro SGE 0" SEVERITY error;
    -- SGE 1
    opcode <= "1010";
    a <= X"00000001";
    b <= X"FFFFFFFF";
    WAIT FOR 10 ps;
    ASSERT (z = X"00000001") REPORT "Erro SGE 1" SEVERITY error;
    -- SGEU 0
    opcode <= "1011";
    a <= X"00000001";
    b <= X"FFFFFFFF";
    WAIT FOR 10 ps;
    ASSERT (z = X"00000000") REPORT "Erro SGEU 0" SEVERITY error;
    -- SGEU 1
    opcode <= "1011";
    a <= X"FFFFFFFF";
    b <= X"00000001";
    WAIT FOR 10 ps;
    ASSERT (z = X"00000001") REPORT "Erro SGEU 1" SEVERITY error;
    -- SEQ 0
    opcode <= "1100";
    a <= X"00000001";
    b <= X"00000002";
    WAIT FOR 10 ps;
    ASSERT (z = X"00000000") REPORT "Erro SEQ 0" SEVERITY error;
    -- SEQ 1
    opcode <= "1100";
    a <= X"00000001";
    b <= X"00000001";
    WAIT FOR 10 ps;
    ASSERT (z = X"00000001") REPORT "Erro SEQ 1" SEVERITY error;
    -- SNE 0
    opcode <= "1101";
    a <= X"00000001";
    b <= X"00000001";
    WAIT FOR 10 ps;
    ASSERT (z = X"00000000") REPORT "Erro SNE 0" SEVERITY error;
    -- SNE 1
    opcode <= "1101";
    a <= X"00000001";
    b <= X"00000002";
    WAIT FOR 10 ps;
    ASSERT (z = X"00000001") REPORT "Erro SNE 1" SEVERITY error;
    -- End
    REPORT "Final dos testes";
    WAIT;
  END PROCESS;
END ARCHITECTURE;
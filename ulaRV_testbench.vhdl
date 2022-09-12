library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all; -- Imports the standard textio package.

entity ulaRVTestBench is
end ulaRVTestBench;

architecture ulaRVTestBench of ulaRVTestBench is
  component ulaRV is
    port (
      opcode : in std_logic_vector(3 downto 0);
      a, b : in std_logic_vector(31 downto 0);
      z : out std_logic_vector(31 downto 0)
    );
  end component;
  signal opcode : std_logic_vector(3 downto 0);
  signal a, b, z : std_logic_vector(31 downto 0);
begin
  dut : ulaRV port map(
    opcode => opcode,
    a => a, 
    b => b,
    z => z);
  process
  begin
    -- ADD
    opcode <= "0000";
    a <= X"00000001";
    b <= X"00000002";
    wait for 10 ps;
    assert (z = X"00000003") report "Erro ADD" severity error;
    -- SUB
    opcode <= "0001";
    a <= X"00000001";
    b <= X"00000002";
    wait for 10 ps;
    assert (z = X"FFFFFFFF") report "Erro SUB" severity error;
    -- AND
    opcode <= "0010";
    a <= X"FFFF0000";
    b <= X"FF00FF00";
    wait for 10 ps;
    assert (z = X"FF000000") report "Erro AND" severity error;
    -- OR
    opcode <= "0011";
    a <= X"FFFF0000";
    b <= X"FF00FF00";
    wait for 10 ps;
    assert (z = X"FFFFFF00") report "Erro OR" severity error;
    -- XOR
    opcode <= "0100";
    a <= X"FFFF0000";
    b <= X"FF00FF00";
    wait for 10 ps;
    assert (z = X"00FFFF00") report "Erro XOR" severity error;
    -- SLL
    opcode <= "0101";
    a <= X"00000001";
    b <= X"00000002";
    wait for 10 ps;
    assert (z = X"00000004") report "Erro SLL" severity error;
    -- SRL
    opcode <= "0110";
    a <= X"00000004";
    b <= X"00000002";
    wait for 10 ps;
    assert (z = X"00000001") report "Erro SRL" severity error;
    -- SRA
    opcode <= "0111";
    a <= X"80000004";
    b <= X"00000002";
    wait for 10 ps;
    assert (z = X"E0000001") report "Erro SRA" severity error;
    -- SLT 0
    opcode <= "1000";
    a <= X"00000001";
    b <= X"FFFFFFFF";
    wait for 10 ps;
    assert (z = X"00000000") report "Erro SLT 0" severity error;
    -- SLT 1
    opcode <= "1000";
    a <= X"FFFFFFFF";
    b <= X"00000001";
    wait for 10 ps;
    assert (z = X"00000001") report "Erro SLT 1" severity error;
    --- SLTU 1
    opcode <= "1001";
    a <= X"00000001";
    b <= X"FFFFFFFF";
    wait for 10 ps;
    assert (z = X"00000001") report "Erro SLTU 0" severity error;
    -- SLTU 0
    opcode <= "1001";
    a <= X"FFFFFFFF";
    b <= X"00000001";
    wait for 10 ps;
    assert (z = X"00000000") report "Erro SLTU 1" severity error;
    -- SGE 0
    opcode <= "1010";
    a <= X"FFFFFFFF";
    b <= X"00000001";
    wait for 10 ps;
    assert (z = X"00000000") report "Erro SGE 0" severity error;
    -- SGE 1
    opcode <= "1010";
    a <= X"00000001";
    b <= X"FFFFFFFF";
    wait for 10 ps;
    assert (z = X"00000001") report "Erro SGE 1" severity error;
    -- SGEU 0
    opcode <= "1011";
    a <= X"00000001";
    b <= X"FFFFFFFF";
    wait for 10 ps;
    assert (z = X"00000000") report "Erro SGEU 0" severity error;
    -- SGEU 1
    opcode <= "1011";
    a <= X"FFFFFFFF";
    b <= X"00000001";
    wait for 10 ps;
    assert (z = X"00000001") report "Erro SGEU 1" severity error;
    -- SEQ 0
    opcode <= "1100";
    a <= X"00000001";
    b <= X"00000002";
    wait for 10 ps;
    assert (z = X"00000000") report "Erro SEQ 0" severity error;
    -- SEQ 1
    opcode <= "1100";
    a <= X"00000001";
    b <= X"00000001";
    wait for 10 ps;
    assert (z = X"00000001") report "Erro SEQ 1" severity error;
    -- SNE 0
    opcode <= "1101";
    a <= X"00000001";
    b <= X"00000001";
    wait for 10 ps;
    assert (z = X"00000000") report "Erro SNE 0" severity error;
    -- SNE 1
    opcode <= "1101";
    a <= X"00000001";
    b <= X"00000002";
    wait for 10 ps;
    assert (z = X"00000001") report "Erro SNE 1" severity error;
    -- End
    report "Final dos testes";
    wait;
  end process;
end architecture;
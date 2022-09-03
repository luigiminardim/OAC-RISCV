library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all; -- Imports the standard textio package.

entity genImm32Testbench is
end genImm32Testbench;

architecture genImm32Testbench of genImm32Testbench is
  component genImm32 is
    port (
      instr : in std_logic_vector(31 downto 0);
      imm32 : out signed(31 downto 0)
    );
  end component;
  signal instr : std_logic_vector(31 downto 0);
  signal imm32 : signed(31 downto 0);
begin
  dut : genImm32 port map(
    instr => instr,
    imm32 => imm32);
  process
  begin
    -- R-type
    instr <= X"000002b3";
    wait for 10 ps;
    assert (imm32 = X"00000000") report "Erro formato R-type" severity error;
    -- I-type0
    instr <= X"01002283";
    wait for 10 ps;
    assert (imm32 = X"00000010") report "Erro formato I-type0" severity error;
    -- I-type1
    instr <= X"f9c00313";
    wait for 10 ps;
    assert (imm32 = X"FFFFFF9C") report "Erro formato I-type1 1" severity error;
    instr <= x"fff2c293";
    wait for 10 ps;
    assert (imm32 = X"FFFFFFFF") report "Erro formato I-type1 2" severity error;
    instr <= x"16200313";
    wait for 10 ps;
    assert (imm32 = X"00000162") report "Erro formato I-type1 3" severity error;
    -- I-type2
    instr <= x"01800067";
    wait for 10 ps;
    assert (imm32 = X"00000018") report "Erro formato I-type2" severity error;
    -- S-type
    instr <= x"02542e23";
    wait for 10 ps;
    assert (imm32 = X"0000003C") report "Erro formato S-type" severity error;
    -- SB-type
    instr <= x"fe5290e3";
    wait for 10 ps;
    assert (imm32 = X"FFFFFFE0") report "Erro formato SB-type" severity error;
    -- U-type
    instr <= x"00002437";
    wait for 10 ps;
    assert (imm32 = X"00002000") report "Erro formato U-type" severity error;
    -- UJ-type
    instr <= x"00c000ef";
    wait for 10 ps;
    assert (imm32 = X"0000000C") report "Erro formato UJ-type" severity error;
    -- End
    report "Final dos testes";
    wait;
  end process;
end genImm32Testbench;
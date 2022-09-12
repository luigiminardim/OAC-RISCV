library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ulaRV is
  generic (WSIZE : natural := 32);
  port (
    opcode : in std_logic_vector(3 downto 0);
    a, b : in std_logic_vector(WSIZE - 1 downto 0);
    z : out std_logic_vector(WSIZE - 1 downto 0)
  );
end entity ulaRV;

architecture arch of ulaRV is
begin
  z <=
    std_logic_vector(signed(a) + signed(b)) when opcode = "0000" else
    std_logic_vector(signed(a) - signed(b)) when opcode = "0001" else
    std_logic_vector(signed(a) and signed(b)) when opcode = "0010" else
    std_logic_vector(signed(a) or signed(b)) when opcode = "0011" else
    std_logic_vector(signed(a) xor signed(b)) when opcode = "0100" else
    std_logic_vector(signed(a) sll to_integer(signed(b))) when opcode = "0101" else
    std_logic_vector(signed(a) srl to_integer(signed(b))) when opcode = "0110" else
    std_logic_vector(signed(a) sra to_integer(signed(b))) when opcode = "0111" else
    std_logic_vector(resize(unsigned(x"1"), WSIZE)) when opcode = "1000" and signed(a) < signed(b) else
    std_logic_vector(resize(unsigned(x"0"), WSIZE)) when opcode = "1000" else
    std_logic_vector(resize(unsigned(x"1"), WSIZE)) when opcode = "1001" and unsigned(a) < unsigned(b) else
    std_logic_vector(resize(unsigned(x"0"), WSIZE)) when opcode = "1001" else
    std_logic_vector(resize(unsigned(x"1"), WSIZE)) when opcode = "1010" and signed(a) >= signed(b) else
    std_logic_vector(resize(unsigned(x"0"), WSIZE)) when opcode = "1010" else
    std_logic_vector(resize(unsigned(x"1"), WSIZE)) when opcode = "1011" and unsigned(a) >= unsigned(b) else
    std_logic_vector(resize(unsigned(x"0"), WSIZE)) when opcode = "1011" else
    std_logic_vector(resize(unsigned(x"1"), WSIZE)) when opcode = "1100" and signed(a) = signed(b) else
    std_logic_vector(resize(unsigned(x"0"), WSIZE)) when opcode = "1100" else
    std_logic_vector(resize(unsigned(x"1"), WSIZE)) when opcode = "1101" and signed(a) /= signed(b) else
    std_logic_vector(resize(unsigned(x"0"), WSIZE)) when opcode = "1101";
end architecture arch;
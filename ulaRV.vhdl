LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ulaRV IS
  GENERIC (WSIZE : natural := 32);
  PORT (
    opcode : IN std_logic_vector(3 DOWNTO 0);
    a, b : IN std_logic_vector(WSIZE - 1 DOWNTO 0);
    z : OUT std_logic_vector(WSIZE - 1 DOWNTO 0)
  );
END ENTITY ulaRV;

ARCHITECTURE arch OF ulaRV IS
BEGIN
  z <=
    std_logic_vector(signed(a) + signed(b)) WHEN opcode = "0000" ELSE
    std_logic_vector(signed(a) - signed(b)) WHEN opcode = "0001" ELSE
    std_logic_vector(signed(a) AND signed(b)) WHEN opcode = "0010" ELSE
    std_logic_vector(signed(a) OR signed(b)) WHEN opcode = "0011" ELSE
    std_logic_vector(signed(a) XOR signed(b)) WHEN opcode = "0100" ELSE
    std_logic_vector(signed(a) SLL to_integer(signed(b))) WHEN opcode = "0101" ELSE
    std_logic_vector(signed(a) SRL to_integer(signed(b))) WHEN opcode = "0110" ELSE
    std_logic_vector(signed(a) SRA to_integer(signed(b))) WHEN opcode = "0111" ELSE
    std_logic_vector(resize(unsigned(x"1"), WSIZE)) WHEN opcode = "1000" AND signed(a) < signed(b) ELSE
    std_logic_vector(resize(unsigned(x"0"), WSIZE)) WHEN opcode = "1000" ELSE
    std_logic_vector(resize(unsigned(x"1"), WSIZE)) WHEN opcode = "1001" AND unsigned(a) < unsigned(b) ELSE
    std_logic_vector(resize(unsigned(x"0"), WSIZE)) WHEN opcode = "1001" ELSE
    std_logic_vector(resize(unsigned(x"1"), WSIZE)) WHEN opcode = "1010" AND signed(a) >= signed(b) ELSE
    std_logic_vector(resize(unsigned(x"0"), WSIZE)) WHEN opcode = "1010" ELSE
    std_logic_vector(resize(unsigned(x"1"), WSIZE)) WHEN opcode = "1011" AND unsigned(a) >= unsigned(b) ELSE
    std_logic_vector(resize(unsigned(x"0"), WSIZE)) WHEN opcode = "1011" ELSE
    std_logic_vector(resize(unsigned(x"1"), WSIZE)) WHEN opcode = "1100" AND signed(a) = signed(b) ELSE
    std_logic_vector(resize(unsigned(x"0"), WSIZE)) WHEN opcode = "1100" ELSE
    std_logic_vector(resize(unsigned(x"1"), WSIZE)) WHEN opcode = "1101" AND signed(a) /= signed(b) ELSE
    std_logic_vector(resize(unsigned(x"0"), WSIZE)) WHEN opcode = "1101";
END ARCHITECTURE arch;
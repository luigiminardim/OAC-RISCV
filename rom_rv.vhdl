LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE std.textio.ALL;

ENTITY rom_rv IS
  PORT (
    address : IN std_logic_vector;
    dataout : OUT std_logic_vector);
END ENTITY rom_rv;

ARCHITECTURE RTL OF rom_rv IS

  TYPE rom_type IS ARRAY (0 TO (2 ** address'length) - 1) OF std_logic_vector(dataout'RANGE);

  IMPURE FUNCTION init_rom_hex RETURN rom_type IS
    FILE text_file : text OPEN read_mode IS "instructions.txt";
    VARIABLE text_line : line;
    VARIABLE rom_content : rom_type;
  BEGIN
    FOR i IN 0 TO (2 ** address'length) - 1 LOOP
      readline(text_file, text_line);
      hread(text_line, rom_content(i));
    END LOOP;
    RETURN rom_content;
  END FUNCTION;

  SIGNAL rom : rom_type := init_rom_hex;

BEGIN
    dataout <= rom(to_integer(unsigned(address)));
END ARCHITECTURE RTL;
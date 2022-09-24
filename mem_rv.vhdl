LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY mem_rv IS
  PORT (
    clock : IN std_logic;
    we : IN std_logic;
    address : IN std_logic_vector;
    datain : IN std_logic_vector;
    dataout : OUT std_logic_vector
  );
END ENTITY mem_rv;

ARCHITECTURE arch OF mem_rv IS
  TYPE mem_type IS ARRAY (0 TO (2 ** address'length) - 1) OF std_logic_vector(datain'RANGE);
  SIGNAL mem : mem_type;
  SIGNAL read_address : std_logic_vector(address'RANGE);
BEGIN
  PROCESS (clock) BEGIN
    IF we = '1' AND clock = '1' THEN
      mem(to_integer(unsigned(address))) <= datain;
    END IF;
    read_address <= address;
  END PROCESS;
  dataout <= mem(to_integer(unsigned(read_address)));
END ARCHITECTURE;
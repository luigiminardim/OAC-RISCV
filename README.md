# Trabalho: Projeto e Simulação de uma ULA em VHDL

**Aluno:** Luigi Minardi Ferreira Maia
**Matrícula:** 17/0017141

## Relatório

Este trabalho consiste na descrição em [VHDL](https://pt.wikipedia.org/wiki/VHDL) de uma unidade
lógica aritimética (ULA) de um processador RISC-V e do seu respectivo teste.
A descrição da ULA pode ser encontrada no arquivo [ulaRV.vhdl](/ulaRV.vhdl) e o respectivo testbench
pode ser encontrado no arquivo [ulaRV_testbench.vhdl](/ulaRV_testbench.vhdl).

Explique em suas palavras a diferença entre as comparações com e
sem sinal.
> As comparações com sinal são feitas de modo que o primeiro bit da palavra é considerado como um
> digito de valor negativo seguindo a regra de complemento a dois. De outro modo, nas comparações
> sem sinal, todos os bits são considerados como digitos de valor positivo.

### Formas de onda

![Formas de onda](/formasDeOnda.png)

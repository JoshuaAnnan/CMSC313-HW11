# CMSC 313 - Homework 11

## Desc
Program reads 8 raw byte values, converts each into 2 ASCII characters representing the hexadecimal value, and prints the result to std output, with each hex pair separated by a space with a newline after it.

### Example:
Input: `0x83, 0x6A, 0x88, 0xDE, 0x9A, 0xC3, 0x54, 0x9A`  
Output: 83 6A 88 DE 9A C3 54 9A

## How to Compile and Run:
nasm -f elf32 -g -F dwarf -o hw11.o hw11.asm
ld -m elf_i386 -o hw11 hw11.o
./hw11

SECTION .data
; Input buffer, actual data to be translated into ASCII hex characters
inputBuf: db 0x83, 0x6A, 0x88, 0xDE, 0x9A, 0xC3, 0x54, 0x9A

; Number of bytes to process
bytesToProcess: equ 8

; ASCII characters for lookup
hexTable: db "0123456789ABCDEF"

SECTION .bss
; Output buffer to hold final string
outputBuf: resb 80

SECTION .text
global _start

_start:
    ; Set input and output start index to 0
    xor esi, esi
    xor edi, edi

loop:
    ; Load single byte from input buffer
    mov al, [inputBuf + esi]

    ; Isolate and translate high 4 bits of byte
    mov ah, al
    shr ah, 4
    and ah, 0x0F
    xor ebx, ebx
    mov bl, ah
    mov bl, [hexTable + ebx]
    mov [outputBuf + edi], bl
    inc edi

    ; Isolate and translate low 4 bits of byte
    and al, 0x0F
    xor ebx, ebx
    mov bl, al
    mov bl, [hexTable + ebx]
    mov [outputBuf + edi], bl
    inc edi

    ; Move to next input byte
    inc esi

    ; If at the last byte, skip adding space
    cmp esi, bytesToProcess
    je newline

    ; If not then just insert space after the current byte’s hex pair
    mov byte [outputBuf + edi], ' '
    inc edi
    jmp loop

newline:
    ; Add newline char after last hex byte
    mov byte [outputBuf + edi], 0x0A
    inc edi

    ; Write result to std output
    mov eax, 4          ; sys_write
    mov ebx, 1          ; file descriptor 1 = stdout
    mov ecx, outputBuf  ; address of string to print
    mov edx, edi        ; number of bytes to print
    int 0x80

    ; Exit program
    mov eax, 1
    xor ebx, ebx
    int 0x80
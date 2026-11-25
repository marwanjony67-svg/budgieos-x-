; BudgieOS X minimal VGA text-mode kernel
BITS 32

section .text
global kernel_main

kernel_main:
    cld
    mov edi, 0xB8000
    mov esi, boot_message
    mov ah, 0x1F               ; bright white on blue
.next_char:
    lodsb
    test al, al
    jz .done
    stosw
    jmp .next_char
.done:
    ret

section .rodata
boot_message db 'BUDGIEOS X - ASM KERNEL STARTED', 0

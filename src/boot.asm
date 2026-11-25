; BudgieOS X - NASM 32-bit Multiboot2 entry point
BITS 32

section .multiboot
align 8
mb2_header:
    dd 0xE85250D6              ; Multiboot2 header magic
    dd 0                       ; i386 protected-mode architecture
    dd mb2_header_end - mb2_header
    dd -(0xE85250D6 + 0 + (mb2_header_end - mb2_header))
    dw 0                       ; end tag type
    dw 0                       ; end tag flags
    dd 8                       ; end tag size
mb2_header_end:

section .text
global _start
extern kernel_main

_start:
    cli
    mov esp, stack_top
    xor ebp, ebp
    call kernel_main

.hang:
    cli
    hlt
    jmp .hang

section .bss
align 16
stack_bottom:
    resb 16384
stack_top:

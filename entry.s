; Thanks to https://github.com/unixpickle/learnos/blob/dcbf8dc629e5deae757fcc1785fd2b59a70f9b02/src/startup/entry.s

bits 32

section .multiboot
align 4
global multiboot_header
multiboot_header:
    MAGIC equ 0x1BADB002
    FLAGS equ 1 << 16
    CHECKSUM equ -(MAGIC + FLAGS)

    dd MAGIC
    dd FLAGS
    dd CHECKSUM
    dd multiboot_header
    dd 0x200000
    dd 0
    dd 0
    dd start

SCREEN_BUFFER equ 0xb8000

section .text
start:
    mov byte [SCREEN_BUFFER], 'h'
    mov byte [SCREEN_BUFFER+2], 'i'
loop:
    hlt
    jmp loop
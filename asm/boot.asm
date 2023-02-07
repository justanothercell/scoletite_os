[bits 16]

extern SECOND_STAGE_LENGTH
global _boot

_boot:
    mov bp, 0x9000			; setup the stack
    mov sp, bp

    mov bx, MSG_RM
    call print_string

    hlt
    cli
    xor ax, ax
    mov ds, ax
    mov ss, ax
    mov ax, 0x9000
    mov sp, ax
    sti

	call load_second_stage

    mov bx, MSG_SECOND_STAGE_LOADED
    call print_string

	jmp enter_protected


[bits 32]
boot_pm:
    jmp enter_long
[bits 64]
boot_lm:
    extern _start
    jmp _start
loop_end:
    jmp loop_end

%include "print.asm"
%include "gdt.asm"
%include "load_second_stage.asm"
%include "enter_protected.asm"
%include "enter_long_mode.asm"

MSG_RM db "hello 16 bit real mode!", 13, 10, 0
MSG_SECOND_STAGE_LOADED db "loaded second stage", 13, 10, 0
MSG_PM db "32 bit private mode", 0

times 510 - ($-$$) db 0
dw 0xaa55  ; 0x55AA, its little endian
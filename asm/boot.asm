[bits 16]

extern _start
extern SECOND_STAGE_LENGTH
global _boot

_boot:
    mov bp, 0x9000			; setup the stack
    mov sp, bp

    ; print
    mov bx, MSG_REAL_MODE
    call print_string

    cli
    xor ax, ax
    mov ds, ax
    mov ss, ax
    mov ax, 0x9000
    mov sp, ax
    sti

	call load_second_stage

	; print
    mov bx, MSG_SECOND_STAGE_LOADED
    call print_string

	jmp enter_protected


[bits 32]
boot_pm:
    mov bx, MSG_START_KERNEL
    call print_string_pm
    jmp _start
loop_end:
    jmp loop_end

%include "print.asm"
%include "gdt.asm"
%include "enter_protected.asm"
%include "load_second_stage.asm"

MSG_REAL_MODE db "16 bit real mode", 13, 10, 0
MSG_SECOND_STAGE_LOADED db "second stage loaded", 13, 10, 0
MSG_PM db "32 bit private mode", 0
MSG_START_KERNEL db "starting kernel...", 0

times 510 - ($-$$) db 0
dw 0xaa55  ; 0x55AA, its little endian
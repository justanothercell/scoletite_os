[bits 16]

extern _start
extern SECOND_STAGE_LENGTH
global _boot

_boot:
    mov [BOOT_DRIVE], dl    ; store boot drive for later

    mov bp, 0x9000			; setup the stack
    mov sp, bp

    ; print messages
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
	jmp enter_protected


[bits 32]
boot_pm:
    call check_cpuid
    jmp enter_long


[bits 64]

boot_lm:
    jmp _start
loop_end:
    jmp loop_end

%include "print.asm"
%include "gdt.asm"
%include "cpuid.asm"
%include "debug.asm"
%include "enter_protected.asm"
%include "load_second_stage.asm"
%include "enter_long.asm"

BOOT_DRIVE db 0 ; gets set at very beginning
MSG_REAL_MODE db "16", 0
MSG_PM db "32", 0
MSG_64 db "64", 0

times 510 - ($-$$) db 0
dw 0xaa55  ; 0x55AA, its little endian
[bits 16]
; GDT - Global Descriptor Table
; We define a basic flat model in which the sectors overlap and cover all 4GB of addressable memory

; === 32 BIT PRIVATE MODE GDT ===
gdt_start:

gdt_null: ; The mandatory null descriptor
	dd 0x0
	dd 0x0

gdt_code: ; The code segment descriptor
	; Base = 0x0, Limit = 0xfffff
	; 1st flag = (present)1 (privilege)00 (descriptor type)1 -> 1001b
	; type flag = (code)1 (conforming)0 (readable)1 (accessed)0 -> 1010b
	; 2rd flag = (granularity)1 (32bit)1 (64bit)0 (avl)0 -> 1100b
	dw 0xffff		; Limit (bits 0-15)
	dw 0x0			; Base (bits 0-15)
	db 0x0			; Base (bits 16-23)
	db 10011010b 	; 1st flag, type flags
	db 11001111b	; Second flag, Limit (bits 16-19)
	db 0x0			; Base (bits 24-31)

gdt_data: ; The data segment descriptor
	; Same as the code segment except for the type flags
	; type flags = (code)0 (expand down)0 (writeable)1 (accessed)0 -> 0010b
	dw 0xffff		; Limit (bits 0-15)
	dw 0x0			; Base (bits 0-15)
	db 0x0			; Base(bits 16-23)
	db 10010010b	; 1st flag, type flags(for data)
	db 11001111b	; Second flag, Limit(bits 16-19)
	db 0x0			; Base (bits 24-31)

gdt_end: ; This is to let the assembler calculate the size of the gdt for the gdt descriptor

gdt_desc:
	dw gdt_end - gdt_start - 1		; Size of our GDT, one less than the true size
	dd gdt_start 					; Start address of our GDT


; Useful constants to put in the segment registers so that the CPU knows what segment we want to use
; 0x0 for null segment
; 0x8 for code segment
; 0x10 for data segment
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

; === 64 BIT LONG MODE GDT ===
; Access bits
PRESENT        equ 1 << 7
NOT_SYS        equ 1 << 4
EXEC           equ 1 << 3
DC             equ 1 << 2
RW             equ 1 << 1
ACCESSED       equ 1 << 0

; Flags bits
GRAN_4K       equ 1 << 7
SZ_32         equ 1 << 6
LONG_MODE     equ 1 << 5

GDT64:
    .Null: equ $ - GDT64
        dq 0
    .Code: equ $ - GDT64
        dd 0xFFFF                                   ; Limit & Base (low, bits 0-15)
        db 0                                        ; Base (mid, bits 16-23)
        db PRESENT | NOT_SYS | EXEC | RW            ; Access
        db GRAN_4K | LONG_MODE | 0xF                ; Flags & Limit (high, bits 16-19)
        db 0                                        ; Base (high, bits 24-31)
    .Data: equ $ - GDT64
        dd 0xFFFF                                   ; Limit & Base (low, bits 0-15)
        db 0                                        ; Base (mid, bits 16-23)
        db PRESENT | NOT_SYS | RW                   ; Access
        db GRAN_4K | SZ_32 | 0xF                    ; Flags & Limit (high, bits 16-19)
        db 0                                        ; Base (high, bits 24-31)
    .TSS: equ $ - GDT64
        dd 0x00000068
        dd 0x00CF8900
    .Pointer:
        dw $ - GDT64 - 1
        dq GDT64
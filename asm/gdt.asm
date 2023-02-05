[bits 16]
; GDT - Global Descriptor Table
; We define a basic flat model in which the sectors overlap and cover all 4GB of addressable memory
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

[bits 16]
enter_protected:
    cli 					; Switch off interrupts until we set up the protected mode interrupt vector
    lgdt [gdt_desc] 	    ; Load the global descriptor table which defines the protected mode segments

    mov eax, cr0 	; Get the value currently in cr0
    or eax, 0x1 	; Set the first bit
    mov cr0, eax	; Make the actual switch to protected mode

    jmp CODE_SEG:init_protected ; Make a far jump to our 32 bit code. This forces the CPU to flush its cache of prefetched
    							; and real mode decoded instructions. This also sets cs to be the CODE_SEG which is what
    							; we will do for all the data segment registers(far jmp is cs:ip so this is like mov cs, CODE_SEG)

[bits 32]
init_protected:
    mov ax, DATA_SEG 	; Now that we are in pm, old segments are meaningless and we must
    					; point our segment registers to the data segment we defined in the GDT
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    ; update the stack right at the top of the free space
    mov ebp, 0x90000

    jmp boot_pm

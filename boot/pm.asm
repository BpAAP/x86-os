[bits 32]
BEGIN_PM:	
	mov ebx, msg_prot_mode
	call print_string_pm
	call KERNEL_OFFSET
	jmp $
	
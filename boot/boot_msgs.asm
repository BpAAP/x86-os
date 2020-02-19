;================================
;Contains all messages printed during bootloader process
msg_bootloader_start:
	db 'Start',0

msg_disk_error:
	db 'Error when reading disk',0

msg_sectors_error:
	db 'Incorrect number of sectors read',0

msg_gdt_set:
	db 'GDT set',0
	
msg_load_kernel:
	db 'Loaded kernel',0
	
msg_gdt_loaded:
	db 'GDT set',0
	
[bits 32]	
msg_prot_mode:
	db 'entered protected',0
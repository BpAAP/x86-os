;================================
;Contains all messages printed during bootloader process
msg_bootloader_start:
	db 'Executing Bootloader',0
	
msg_realmode_start:
	db 'Started in 16-bit Real Mode',0
	
msg_disk_error:
	db 'Error when reading disk',0

msg_sectors_error:
	db 'Incorrect number of sectors read',0

msg_load_kernel:
	db 'Loading Kernel',0
	
msg_kernel_read:
	db 'Kernel Loaded',0
	
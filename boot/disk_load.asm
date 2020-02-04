;================================
;Loads from disk, starting at some address and loading a number of sectors
;(IN) ==> start position : bx
;		  num to load    : dh
;         boot drive     : dl
;(OUT) => Void
disk_load:
	pusha
	push dx
	
	mov ah, 0x02 ;will use interrupt 0x13, register 0x02 --> 'read'
	mov al, dh ;number of sectors to read
	mov cl, 0x02 ;start reading at the sector after the boot sector
	
	mov ch, 0x00 ;cylinder 0
	mov dh,0x00 ;head 0
	
	int 0x13
	jc disk_error ;if error 
	
	
	pop dx
	cmp al, dh ;check that the correct number of sectors was read
	jne sectors_error
	popa
	ret
	
disk_error:
	mov bx,msg_disk_error
	call print_string
	call print_nl
	jmp error_halt
	
sectors_error:
	mov bx, msg_sectors_error
	call print_string
	call print_nl
	
error_halt:
	jmp $
	

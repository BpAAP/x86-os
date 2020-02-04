[org 0x7c00] ;Place BIOS loads us into, this is an offset

mov bx, msg_bootloader_start ;Move bootloader start message to bx register
call print_string ;call string printing subroutine
call print_nl;print a new line

KERNEL_OFFSET equ 0x1000 ;specify where kernel is stored

mov [BOOT_DRIVE], dl ;Save the boot drive for later use

;Set up stack
mov bp, 0x9000
mov sp, bp

mov bx, msg_realmode_start ;Move realmode start message to bx register
call print_string ;call string printing subroutine
call print_nl;print a new line

call load_kernel ;load kernel from disk

mov bx, msg_kernel_read ;Move realmode start message to bx register
call print_string ;call string printing subroutine
call print_nl;print a new line

jmp $  ;Jump here i.e. HALT

;================================
;Function sets register values for disk_load
;(IN) ==> Void
;(OUT) => Void
load_kernel:
	pusha
	mov bx, msg_load_kernel
	call print_string
	call print_nl
	
	mov bx, KERNEL_OFFSET ;Start reading from this position
	mov dh, 15 ;Read for 15 sectors
	mov dl,[BOOT_DRIVE] ;Read from this drive
	call disk_load
	popa
	ret


%include "print_funcs.asm"
%include "boot_msgs.asm"
%include "disk_load.asm"

BOOT_DRIVE: db 0 ;Allocate space to store BOOT_DRIVE


times 510-($-$$) db 0
dw 0xaa55
times 20*512 db 0 ;REMOVE, Added for testing reading
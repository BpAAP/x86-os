[org 0x7c00] ;Place BIOS loads us into, this is an offset

mov bx, msg_bootloader_start ;Move bootloader start message to bx register
call print_string ;call string printing subroutine
call print_nl;print a new line

KERNEL_OFFSET equ 0x1000 ;specify where kernel is stored

mov [BOOT_DRIVE], dl ;Save the boot drive for later use

;Set up stack
mov bp, 0x9000
mov sp, bp



call load_kernel ;load kernel from disk

mov bx, msg_load_kernel;show kernel loaded messade
call print_string
call print_nl
	
call gdt_start ;Define and set GDT

mov bx,msg_gdt_loaded ;Show GDT set message
call print_string
call print_nl

;Make the switch to 32 bit
mov eax, cr0
or eax, 0x1
mov cr0,eax
;make far jump to flush pipeline
jmp CODE_SEG:init_pm
jmp $  ;Jump here i.e. HALT

;================================
;Function sets register values for disk_load
;(IN) ==> Void
;(OUT) => Void
load_kernel:
	pusha
	
	mov bx, KERNEL_OFFSET ;Start reading from this position
	mov dh, 16 ;Read for 15 sectors
	mov dl,[BOOT_DRIVE] ;Read from this drive
	call disk_load
	popa
	ret

;============32bit==============
[bits 32]
init_pm:
	
	mov ax, DATA_SEG
	mov ds,ax
	mov ss,ax
	mov es,ax
	mov fs,ax
	mov gs,ax

	mov ebp, 0x90000
	mov esp,ebp
	call BEGIN_PM
	jmp $
	
[bits 16]
%include "print_funcs.asm"
%include "print_funcs32.asm"
%include "boot_msgs.asm"
%include "disk_load.asm"
%include "gdt.asm"
%include "pm.asm"



BOOT_DRIVE: db 0 ;Allocate space to store BOOT_DRIVE


times 510-($-$$) db 0
dw 0xaa55
;times 20*512 db 0 ;REMOVE, Added for testing reading
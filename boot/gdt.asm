gdt_start:
pusha
gdt_null: ;mandatory null descriptor
	dd 0x0
	dd 0x0
	
gdt_code: ;code segment descriptor
	;base=0x0, limit = 0xfffff
	;1st flags: (present)1, (privilige)00, (descriptor type)1 ->1001b
	; type flags: (code)1, (conforming)0, (readable)1, (accessed)0 ->1010b
	;2nd flags: (granularity)1, (32-bit default)1, (64-bit seg)0 (AVL)0 ->1100b
	dw 0xfff
	dw 0x0
	db 0x0
	db 10011010b
	db 11001111b
	db 0x0

gdt_data:;data segment descriptor
	;different type flags to before: (code)0, (expand down)0, (writable)1, (accessed)0 ->0010b
	dw 0xfff
	dw 0x0
	db 0x0
	db 10010010b
	db 11001111b
	db 0x0
	
gdt_end:

gdt_descriptor:
	dw gdt_end - gdt_start -1 ;Size of GDT minus 1
	dd gdt_start ;Start address of GDT
	
	CODE_SEG equ gdt_code - gdt_start
	DATA_SEG equ gdt_data - gdt_start

	cli
	lgdt [gdt_descriptor]
popa
ret

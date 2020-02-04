;================================
;Function prints a zero terminated string using BIOS
;(IN) ==> Expects pointer to string in register bx
;(OUT) => Void
print_string:
	pusha ;Push registers to stack
	loop:	
		mov al,[bx] ;move value at bx to al
		cmp al, 0 ;check if value is 0, since strings are 0 terminated
		je done ;if end of string (value is 0), jump to done
		mov ah, 0x0e ;set teletype mode
		int 0x10 ;monitor interrupt
		add bx,1 ;increment pointer to next character
		jmp loop ;repeat
	done:	
		popa ;restore registers
		ret ; return to parent
		
;================================
;Function prints a newline and carriage-return characters using BIOS
;(IN) ==> Void
;(OUT) => Void
print_nl:
	pusha
	mov ah,0x0e
	mov al,0x0a
	int 0x10
	mov al, 0x0d
	int 0x10	
	popa
	ret
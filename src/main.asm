org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A


start:
	jmp main


; Prints a string to the screen
puts:
	; Save regieters to use
	push si
	push ax
	push bx

.loop:
	lodsb		; load next character into al
	or al, al	; check next character is null
	jz .done

	mov ah, 0x0E	; call bios interrupt
	mov bh, 0		; set page number to 0
	int 0x10

	jmp .loop 

.done: 
	pop bx
	pop ax
	pop si
	ret

main:
	; Set up segment registers
	mov ax, 0	; set up data segment
	mov ds, ax	
	mov es, ax	

	mov ss, ax
	mov sp, 0x7C00	; set stack pointer to 0x7C00

	mov si, msg_hello 	; set si to point to msg_hello
	call puts 			; call puts to print msg_hello
	
	hlt



.halt:
	jmp .halt


msg_hello: db 'Hello World!', ENDL, 0

times 510-($-$$) db 0
dw 0AA55h
extern printf

section .data
	msg	db	"Result : %i", 0x0a, 0x00	; creates a variable with a message, integer holder, new line and a null terminator 
	result	dd	0				; creates a variable in memory that will contain result of multiplication	

section .text

global main
main:
	mov	eax, 5			; value 1 : uses general registir eax to contain value 5 
	mov	ebx, 4			; value 2 : uses general registir ebx to contain value 4
multiply:	
	add	[result], dword eax	; add value of eax to 'result'
	dec	ebx			; decrements ebx to avoid infinite loop
	cmp	ebx, 0			; compare ebx to 0, to make conditional jump
	jg	multiply		; jumps back to label 'multiply' if greater than 0
	push 	ebp			; prologue : preserve the old base pointer in case any other code was using it
	mov 	ebp, esp		; prologue : preserve the current top of the stack
	push 	dword [result]		; %i value : 'result' is pushed first on to stack, due to LIFO
	push 	msg			; then msg is pushed secondly to stack
	call 	printf			; calls external function (printf) to print stack
	mov 	eax, 0			; return code for return instruction
	mov 	esp, ebp		; epilogue : restoring the stack pointer from EBP 
	pop 	ebp			; epilogue : remove value of EBP that was stored in prologue
	ret				; epilogue : return instruction, pops off return address then jumps to address

extern printf

section .data
	msg	db	"Result : %i", 0x0a, 0x00

section .text

global main
main:
	mov	eax, 5		; uses general registery eax to contain value 5 
	mov	ebx, 4		; uses general registery ebx to contain value 4
	mov	ecx, 0		; uses general registery ecx to store result, gives initial value
mult:	
	add	ecx, eax	; add value of eax to ecx
	dec	ebx		; decrements ebx to avoid infinite loop
	cmp	ebx, 0		; compare ebx to 0
	jg	mult		; jumps back to label mult if greater than 0
	push 	ebp		; prologue
	mov 	ebp, esp	; prologue
	push 	ecx		; result is pushed first on to stack, due to LIFO
	push 	msg		; then msg is pushed secondly to stack
	call 	printf		; calls external function (printf) to print stack
	mov 	eax, 0		; exit code for program
	mov 	esp, ebp	; epilogue
	pop 	ebp		; epilogue
	ret			; epilogue

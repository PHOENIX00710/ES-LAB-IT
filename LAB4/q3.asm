	AREA RESET,DATA,READONLY
	EXPORT __Vectors
__Vectors
	DCD 0x10004000
	DCD Reset_Handler
	ALIGN
	AREA mycode,CODE,READONLY
	ENTRY
	EXPORT Reset_Handler
Reset_Handler
	ldr r0,=num
	ldr r1,=ans
	ldr r2,[r0]
	mov r3,#1; to store the final answer
	ldr r13,=0x10001000; Initialize Stack Pointer
	bl fact
	str r3,[r1]
stop b stop

fact push {r14}; push link register
	push {r2}
	sub r2,#1
	cmp r2,#1
	beq done
	bl fact
done pop {r2}
	pop {r14}
	mul r3,r2; Pop and multiply the ans recursively
	bx lr
	
num dcd 0x07
	AREA dataseg,DATA,READWRITE
ans dcd 0x0
	end
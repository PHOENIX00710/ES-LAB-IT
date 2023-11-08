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
	ldr r9,=src
	ldr r4,=dst
	ldr r1,[r9]
	mov r2,#1
	bl fact
	str r2,[r4]
stop b stop	

fact
	push {r14}
	push {r1}
	sub r1,#1
	cmp r1,#1
	blhi fact
	pop {r1}
	mul r2,r1
	pop{r14}
	bx lr
	
src dcd 0x05
	AREA DATASEG,DATA,READWRITE
dst dcd 0x0
	end
	AREA RESET,CODE,READONLY
	EXPORT __Vectors
__Vectors
	DCD 0x40001000
	DCD Reset_Handler
	ALIGN
	AREA mycode,CODE,READONLY
	ENTRY
	EXPORT Reset_Handler
Reset_Handler
	ldr r0,=num
	ldr r1,=num2
	ldr r2,=ans
	ldr r3,[r0]
	ldr r4,[r1]
up	cmp r3,r4
	beq exit
	bhi next
	sub r4,r3
	b up
next sub r3,r4
	b up
exit str r3,[r2]
stop b stop
num dcd 0x05
num2 dcd 0x03
	AREA DATASEG,DATA,READWRITE
ans dcd 0x0
	end
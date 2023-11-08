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
	ldr r1,=ans
	ldr r2,[r0]
	mla r3,r2,r2,r2
	lsr r3,#1
	str r3,[r1]
stop b stop
num dcd 0x10
	AREA DATASEG,DATA,READWRITE
ans dcd 0x0
	end
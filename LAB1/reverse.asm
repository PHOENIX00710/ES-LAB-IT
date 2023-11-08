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
	LDR r0,=(src+(4*10-4))
	LDR r1,=src
	MOV r2,#5
up  LDR r3,[r0]
	LDR r4,[r1]
	STR r3,[r1]
	STR r4,[r0]
	SUB r0,#4
	ADD r1,#04
	SUBS r2,#01
	BNE up
stop b stop
	AREA dataseg,DATA,READWRITE
src DCD 0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	END

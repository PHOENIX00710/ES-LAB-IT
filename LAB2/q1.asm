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
	ldr r0,=SRC
	mov r1,#10
up	ldr r5,[r0],#4
	adds r2,r5
	adc r3,#0
	subs r1,#1
	bne up
	ldr r4,=DST
	str r3,[r4],#4
	str r2,[r4]
stop b stop
SRC DCD 0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x12345678
	AREA mydata,DATA,READWRITE
DST DCD 0x0,0x0
	end
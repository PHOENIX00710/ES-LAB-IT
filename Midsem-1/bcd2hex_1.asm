	AREA RESET,DATA,READONLY
	EXPORT __Vectors
__Vectors
	DCD 0X10004000
	DCD Reset_Handler
	ALIGN
	AREA mycode,CODE,READONLY
	ENTRY
	EXPORT Reset_Handler
Reset_Handler
	ldr r0,=num
	ldr r1,=dst
	ldr r2,[r0]
	mov r7,#0x0a; While Packing we will keep multiplying by 0a
	mov r3,#1;to multiply each digit with powers of A,r4 will store the ans
	mov r5,#4; No. Of Digits
up  and r6,r2,#0x0f; To extract each digit
	mla r4,r6,r3,r4
	mul r3,r7
	lsr r2,#4
	subs r5,#1
	bne up
	str r4,[r1]
stop b stop
num dcd 0x1234
	AREA DATASEG,DATA,READWRITE
dst dcd 0x0
	end
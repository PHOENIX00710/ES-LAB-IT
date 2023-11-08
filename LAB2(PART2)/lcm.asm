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
	mov r9,#1
up	mul r10,r9,r3
	bl div
	teq r10,#0
	beq done
	add r9,#1
	b up
done mul r5,r9,r3
	str r5,[r2]
stop b stop
div	cmp r10,r4
	bcc exit
	sub r10,r4
	b div
exit bx lr
num dcd 0x03
num2 dcd 0x06
	AREA DATASEG,DATA,READWRITE
ans dcd 0x0
	end
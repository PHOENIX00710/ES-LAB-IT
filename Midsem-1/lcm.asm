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
	ldr r0,=num1;
	ldr r1,=num2
	ldr r2,=ans
	ldr r3,[r0]
	ldr r4,[r1]
	bl gcd
	str r3,[r2],#4
	ldr r5,[r0]
	ldr r6,[r1]
	mul r5,r6
	bl div
	str r7,[r2]
	
stop b stop

gcd cmp r3,r4
	beq done
	blo next
	sub r3,r3,r4
	b gcd
next rsb r4,r3,r4
	b gcd
done bx lr

div cmp r5,r3
	blo exit
	sub r5,r3
	add r7,#1
	b div
exit bx lr
	
num1 dcd 0x05
num2 dcd 0x03
	AREA dataseg,DATA,READWRITE
ans dcd 0x0
	end
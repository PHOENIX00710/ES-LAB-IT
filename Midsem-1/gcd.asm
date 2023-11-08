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
	str r3,[r2]
stop b stop

gcd cmp r3,r4
	beq done
	blo next
	sub r3,r3,r4
	b gcd
next rsb r4,r3,r4
	b gcd
done bx lr
	
num1 dcd 0x12
num2 dcd 0x18
	AREA dataseg,DATA,READWRITE
ans dcd 0x0
	end
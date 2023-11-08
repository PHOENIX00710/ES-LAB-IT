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
	ldr r10,[r0]
	mov r2,#0; To be right shifted by
	bl hex2bcd
	str r6,[r1]

stop b stop

hex2bcd	cmp r10,#0
	beq done
	bl div
	lsl r10,r2
	add r6,r10; r6 stores the final output
	add r2,#4
	mov r10,r3; Quotient becomes the new dividend
	mov r3,#0; Reset quotienr
	b hex2bcd
done bx lr

div cmp r10,#0x0a; r10 will have the final remainder
	blo exit
	sub r10,#0x0a
	add r3,#1 ; r3 will have the quotient
	b div
exit bx lr

num dcd 0x123
	AREA DATASEG,DATA,READWRITE
dst dcd 0x0
	end
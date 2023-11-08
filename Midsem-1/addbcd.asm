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
	ldr r0,=src
	ldr r12,=dst
	mov r7,#10; Size of array
up4	ldr r1,[r0],#4
	bl bcd2hex
	add r5,r2
	subs r7,#1
	bne up4
	bl hex2bcd
	str r10,[r12]
stop b stop	

bcd2hex
	push{r14}
	mov r2,#0
	mov r3,#1
	mov r6,#0x0a
up3	cmp r1,#0
	beq done2
	and r8,r1,#0x0f
	mla r2,r8,r3,r2
	lsr r1,#4
	mul r3,r6
	b up3
done2
	pop{r14}
	bx lr
	
hex2bcd
	push {r14}
	mov r6,#0
	mov r3,#0
up1	cmp r5,#0
	beq done
	bl div
	lsl r5,r6
	add r10,r5; Final answer is stored in r10
	add r6,#4
	mov r5,r3; New dividend
	mov r3,#0; Divisor Reset
	b up1
done pop{r14}
	bx lr
	
div push {r14}
up2	cmp r5,#0x0a
	blo exit
	sub r5,#0x0a
	add r3,#1
	b up2
exit pop {r14} 
	bx lr
	
src dcd 0x9,0x9,0x9,0x9,0x9,0x9,0x9,0x9,0x9,0x9
	AREA DATASEG,DATA,READWRITE
dst dcd 0x0
	end
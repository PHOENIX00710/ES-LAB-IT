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
	ldr r0,=arr
	mov r1,#10
	mov r5,#-1
	ldr r2,=res
	mov r7,#0x09; Element to be searched for
up  ldr r3,[r0],#4
	cmp r3,r7
	beq done
	subs r1,#1
	bne up
	str r5,[r2]
	b stop
done mov r5,#10
	sub r5,r1
	str r5,[r2]
stop b stop
arr dcd 0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0a
	AREA dataseg,DATA,READWRITE
res dcd 0x0
	end
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
	ldr r9,=src
	ldr r0,=arr
	mov r12,#10
up  ldr r1,[r9,r2]
	str	r1,[r0,r2]
	add r2,#4
	subs r12,#1
	bne up
	
	mov r1,#0;Declare i
outer_loop 
	mov r2,0; j=0
	mov r10,36; loop times =n-1;
	sub r10,r2; n-1-i;
inner_loop
	mov r9,r2
	add r9,#4;j+1;
	ldr r5,[r0,r2]; arr[j]
	ldr r6,[r0,r9]; arr[j+1]
	cmp r5,r6
	bls skip1
	str r5,[r0,r9]; arr[j+1]=arr[j]
	str r6,[r0,r2]; arr[j]=arr[j+1]
skip1 add r2,#4;
	cmp r2,r10
	bne inner_loop
	add r1,#4
	cmp r1,#36
	bne outer_loop
	
stop b stop	
src dcd 0x0a,0x08,0x09,0x07,0x06,0x03,0x010,0x02,0x01,0x0
	AREA DATASEG,DATA,READWRITE
arr dcd 0x0
	end
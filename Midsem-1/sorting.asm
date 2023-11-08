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
	mov r2,r1; j=i
	add r2,#4; j=i+1;
	mov r10,r1; minInd=i
	ldr r11,[r0,r1]; min=arr[i];
inner_loop
	ldr r5,[r0,r2]; arr[j]
	cmp r5,r11
	bhs skip1
	ldr r11,[r0,r2]; update min
	mov r10,r2; update minInd
skip1 add r2,#4;
	cmp r2,#40
	bne inner_loop
	ldr r7,[r0,r1]; swap start
	str r7,[r0,r10]
	str r11,[r0,r1]; swap complete
	add r1,#4
	cmp r1,#36
	bne outer_loop
	
stop b stop	
src dcd 0x0a,0x08,0x09,0x07,0x06,0x03,0x010,0x02,0x01,0x0
	AREA DATASEG,DATA,READWRITE
arr dcd 0x0
	end
	AREA RESET,DATA,READONLY
	EXPORT __Vectors
__Vectors
	DCD 0X40001000
	DCD Reset_Handler
	ALIGN
	AREA mycode,CODE,READONLY
	ENTRY
	EXPORT Reset_Handler
Reset_Handler
		mov r0,#23
		mov r1,#0x23
		mov r2,#2_101010
stop b stop
	end
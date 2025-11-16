print	START	0
		LDX		#0
first	LDCH	string,X
		COMP	#0
		JEQ		halt
wait	TD		device
		JEQ		wait
		WD		device
		LDA		#1
		ADDR	A,X
		J		first
halt	J      	halt
. data
string	BYTE	C'SIC/XE'
		BYTE	0x0D
		BYTE	0
device	BYTE	0xAA
		END    	first
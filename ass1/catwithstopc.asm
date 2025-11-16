cat		START	0
waitin	TD		stdin
		JEQ		waitin
		LDCH	stopc
		LDT		#0
		ADDR	A,T
		RD		stdin
		LDB		#0
		ADDR	A,B
		COMPR	B,T
		JEQ		halt
		COMP	0x00
		JEQ		halt
waitout	TD		stdout
		JEQ		waitout
		WD		stdout
		LDA		#1
		J		waitin
halt	J      	halt
. data
stdin	BYTE	0x00
stdout	BYTE	0x01
stopc	BYTE	0x61
		END    	waitin
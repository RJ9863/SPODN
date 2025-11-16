cat		START	0
waitin	TD		stdin
		JEQ		waitin
		RD		stdin
waitout	TD		stdout
		JEQ		waitout
		WD		stdout
		J		waitin
halt	J      	halt
. data
stdin	BYTE	0x00
stdout	BYTE	0x01
		END    	waitin
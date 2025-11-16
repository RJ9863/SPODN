rec		START	0
init	LDX		#0
startn	JSUB	readc
		COMP	zero
		JEQ		halt
		STA		sum
starti	JSUB	readc
		COMP	null
		JEQ		fact
		LDS		sum
		LDT		#10
		MULR	T,S
		ADDR	S,A
		STA		sum
		
fact	LDA		sum
		JSUB	factl
waitout	TD		stdout
		JEQ		waitout
		WD		stdout
		J		startn
		
factl	COMP	#1
		JEQ		fret1
		COMP	#0
		JEQ		fret1
		LDX		STI
		STA		STACK,X
		LDB		#3
		ADDR	B,X
		STX		STI		
		JSUB	factl
		MULR	B,A
		RSUB
fret1	LDA		#1
		RSUB
		
halt	J      	halt
retlbl	RSUB
readc	TD		devin
		JEQ		readc
		RD		devin
		RSUB
. data
STACK	RESW	100
sum		WORD	0
devin	BYTE	0xFA
stdout	BYTE	0x01
zero	WORD	0x31
null	WORD	0x00
		END    	waitin
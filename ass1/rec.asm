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
		J		starti
		
fact	LDA		sum
		JSUB	factl
		JSUB	print
		J		startn
		
waitout	TD		stdout
		JEQ		waitout
		WD		stdout
		J		startn
		
factl	COMP	#1
		JEQ		fret1
		COMP	#0
		JEQ		fret1
		JSUB	push
		LDB		#1
		SUBR	B,A
		JSUB	factl
		LDB		#0
		ADDR	A,B
		JSUB	pop
		MULR	B,A
		RSUB
fret1	LDA		#1
		RSUB
		
push	STA		STACK,X
		STB		bsave
		LDB		#3
		ADDR	B,X
		LDB		bsave
		RSUB
		
pop		LDA	STACK,X
		STB		bsave
		LDB		#3
		SUBR	B,X
		LDB		bsave
		RSUB
		
halt	J      	halt
retlbl	RSUB
readc	TD		devin
		JEQ		readc
		RD		devin
		RSUB
print	JSUB	dmod10
		LDA		#0
		ADDR	S, A
		JSUB	push
		LDA		#0
		ADDR	T, A
		COMP	#0
		JEQ		retlbl
		JSUB 	pop
		LDB		#0x30
		ADDR	B, A
		JSUB	printc
		RSUB
		
dmod10	LDS		#0
		LDT		#0
		ADDR	A, S
		ADDR	A, T
		LDB		#10
		DIVR	B, S
		MULR	S, B
		SUBR	B, S
		RSUB
		
printc	TD		stdout
		JEQ		printc
		WD		stdout
. data
bsave	WORD	0
STACK	RESW	100
sum		WORD	0
devin	BYTE	0xFA
stdout	BYTE	0x01
zero	WORD	0x31
null	WORD	0x00
		END    	init
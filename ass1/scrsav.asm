scrsav  START   0
screen  EQU     0xB800

first   LDX     #0      ; count strlen
sloop   LDA     #0
        LDCH    str,X
        COMP    #0
        JEQ     sdone
        TIX     #0
        J       sloop
sdone   STX     len     ; set maxx
        LDA     #80
        SUB     len
        STA     maxx

loop    LDA     #32     ; clear string
        JSUB    draws

        LDA     x       ; check left bounce
        COMP    #0
        JEQ     flipx
        COMP    maxx    ; check right bounce
        JLT     movex
flipx   LDA     #0
        SUB     dx
        STA     dx
movex   LDA     x       ; compute new x coordinate
        ADD     dx
        STA     x

        LDA     y
        COMP    #0      ; check bounce up
        JEQ     flipy
        COMP    #24     ; check bounce down
        JLT     movey
flipy   LDA     #0
        SUB     dy
        STA     dy
movey   LDA     y
        ADD     dy
        STA     y

draw    LDA     #0
        JSUB    draws
        JSUB    wait
        J       loop

wait    LDA     delay
wloop   SUB     #1
        COMP    #0
        JGT     wloop
        RSUB

draws   STA     mode
        LDA     y       ; addr = y * 80 + x
        MUL     #80
        ADD     x
        STA     scroff
        LDX     #0
dloop   LDA     #0      ; read next char -> S
        LDCH    str,X
        COMP    #0      ; check end of str
        JEQ     ddone
        RMO     A,S
        LDA     mode    ; branch clear/write
        COMP    #0
        JEQ     dput
        RMO     A,S     ; clear -> replace char with space
dput    RMO     X,T
        LDA     scroff
        ADDR    T,A     ; target arrd = scroff + X
        RMO     A,X
        RMO     S,A
        +STCH   screen,X
        RMO     T,X
        TIX     #0
        J       dloop
ddone   RSUB

str     BYTE    C'SIC/XE'
        BYTE    0

x       WORD    1
y       WORD    1
dx      WORD    1
dy      WORD    1
len     WORD    0
maxx    WORD    79
mode    WORD    0
scroff  WORD    0
delay   WORD    1000
        END     first

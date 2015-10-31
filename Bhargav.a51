ORG 0000H
		SJMP 0040H ; Jump to main program
	
ORG 000BH
		AJMP TIMER0H ; Jump to TIMER0 ISR
	
ORG 001BH
		AJMP TIMER1H ; jump to TIMER1 ISR

ORG 0040H
		MOV P2,#00H ; Initialize Port2 to be output port
		MOV TMOD,#99H ; T1 &T0 IN mode 1
		MOV IE,#0FFH ; Enable Timer 0 and Timer 1 Interrupt
		MOV TH1,#00H ; Initialization of timer1 
		MOV TL1,#00H ; and timer 0 registers
		MOV TH0,#00H ; for maximum delay 
		MOV TL0,#00H
		SETB TR0 ; Run Timer0
		MOV ACC,P1 
		MOV P2,ACC ; move the value of Port1 to Port2
		CLR P3.0 ; since initially TF0 and
		CLR P3.1 ; TF1 are zeros
LOOP: 	
		SJMP LOOP ; dummy loop


TIMER0H:
		CLR TR0 ; stop timer0
		CLR TF1 ; Clear timer1 overflow flag
		CPL P3.1 ; update value of P3.1 by complementing 
		SETB TR1 ; Run Timer1
		RETI

TIMER1H:
		CLR TR1 ; stop Timer1
		CLR TF0 ; Clear Timer0 overflow flag
		CPL P3.0 ; Update value of P3.0 by complementing
		MOV ACC,P2
		INC ACC ; increment the value in P2
		MOV P2,ACC ; Move the incremented value to port 2
		SETB TR0 ; Run Timer0
		RETI	
END
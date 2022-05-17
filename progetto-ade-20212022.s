#Progetto Architetture degli Elaboratori 2021/2022 - Jonathan Colombo

.data
    sostK: .word 2	
    myplaintext: .string "AMO AssEMBLY"
    characterUnderLine: .byte 10       
    characterDiv: .word 0          	
	 mychyper: .string "A"
	 stringExit: .string "Programma terminato!"
	 stringCypherExit: .string "Caratteri terminati nella chiave!"


.text 
    main:
        la a0 myplaintext
		  li a7 4
        ecall 
        
        la a0 characterUnderLine
        la a1 11
        ecall

        la a0 myplaintext
		  li a7 4
        ecall 
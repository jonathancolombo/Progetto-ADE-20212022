#PROGETTO ADE - JONATHAN COLOMBO

.data
	sostK: .word -2	
	myplaintext: .string "myStr0ng P4ssW_ " 
	characterDiv: .word 0          	
	mychyper: .string "ABCD"    	
	blocKey: .string "OLE"    
	characterUnderLine: .byte 10       
	stringExit: .string "Programma terminato!"
	stringCypherExit: .string "Caratteri terminati nella chiave!"

	
.text
	main:
	
		la a1 myplaintext
		li a0 4
		ecall 

		la a1 characterUnderLine
		ecall

		
		la a1 mychyper 
		la a0 myplaintext
		li s1 65		
		li s2 66 		
		li s3 67		
		li s4 68		

		jal encryptString 
		jal decryptString 
		j endProgram 

	encryptString: 

		controlCharacter:
		lb t0 0(a1)	
		addi a1 a1 1 
		addi sp sp -4  
		sw a1 0(sp) 

		beq t0 zero endEncryptString
		beq t0 s1 cifrarioA 
		beq t0 s2 cifrarioB 
		beq t0 s3 cifrarioC 
		beq t0 s4 cifrarioD 
		
		j controlCharacter 


		cifrarioA:
		lw a1 sostK 
		addi sp sp -4 
		sw ra 0(sp) 
		jal substitution
		
		lw ra 0(sp) 	
		addi sp sp 4 

		add a1 a0 zero 
		add a2 a0 zero

		li a0 4 
		ecall	

		la a1 characterUnderLine
		ecall	

		addi a0 a2 0
		lw a1 0(sp) 
		addi sp sp 4
		j controlCharacter


		substitution:
		li t1 26 

		li t2 65 
		li t3 91

		li t4 97 
		li t5 123 
		
		add t6 a0 zero 

		blt a1 zero correctNegative 
		
		rem a1 a1 t1 
		
		j loopEncryptA 

		correctNegative:
		sub a1 zero a1 
		rem a1 a1 t1 
		sub a1 t1 a1 
		
		loopEncryptA:
		lb t0 0(t6) 

		beq t0 zero endEncryptA 
		blt t0 t2 increaseIndexCharacter  	
		bge t0 t5 increaseIndexCharacter 	
		blt t0 t3 characterMaiusc 
		blt t0 t4 increaseIndexCharacter 
		
		
		add a2 t0 a1 
		addi a2 a2 -97
		rem  a2 a2 t1 
		add a2 a2 t4 
   	sb a2 0(t6)  
		j increaseIndexCharacter

		characterMaiusc:
		add a2 t0 a1 
		addi a2 a2 -65 
		rem  a2 a2 t1 
		add a2 a2 t2
   	sb a2 0(t6)
		j increaseIndexCharacter

		increaseIndexCharacter:
		addi t6 t6 1
		j loopEncryptA
				 		
		endEncryptA: 
		
		li t0 0
		li t1 0
		li t2 0
		li t3 0
		li t4 0
		li t5 0
		li t6 0
		li a2 0
		lw a1 sostK
		jr ra 
			

		cifrarioB:
		la a1 blocKey 
		addi sp sp -4	 
		sw ra 0(sp)	
		jal encryptBlock 
		lw ra 0(sp) 
		addi sp sp 4 
	
		add a1 a0 zero  
		add a2 a0 zero

		li a0 4
		ecall

		la a1 characterUnderLine
		ecall

		addi a0 a2 0

		lw a1 0(sp) 
		addi sp sp 4 
		j controlCharacter 


		encryptBlock:
		li t0 0
		li t1 0
		li t2 0
		li t6 0 

		li a2 96       	
		add t4 t4 a1 
		add t3 t3 a1 
		addi t5 a0 0 
		

		calculateString:   
		lb t0 0(t4) 
		beq t0 zero block
		addi t1 t1 1
		addi t4 t4 1 
		j calculateString

		block:
		lb t0 0(a0)
		beq t0 zero endEnrcyptB
		addi t0 t0 -32 
		lb t2 0(t3) 
		addi t2 t2 -32
		add t0 t2 t0  

		rem t0 t0 a2 
		addi t0 t0 32 
		sb t0 0(a0) 
		addi t6 t6 1 
		rem t6 t6 t1 
		add t3 t6 a1 
		addi a0 a0 1  
		j block 
			
		endEnrcyptB:
		add a0 t5 zero 
		li t0 0
		li t1 0
		li t2 0
		li t3 0
		li t4 0
		li t5 0
		li t6 0		
		li a2 0
		jr ra 


		cifrarioC:
		addi sp sp -4	 
		sw ra 0(sp)	
		jal occurencies 
		lw ra 0(sp)
		addi sp sp 4 
			
		add a1 a0 zero 
		add a2 a0 zero

		li a0 4
		ecall

		la a1 characterUnderLine
		ecall

		addi a0 a2 0

		lw a1 0(sp) 
		addi sp sp 4 
		j controlCharacter 
	

		occurencies:
		li t2 4       
		li t6 45 
		div a3 a0 t2 
		add a7 a3 zero 
		li t2 32 
		li a5 -1 
		li a4 48
		li t0 0		

		pullCharacter:
		lb t5 0(a0)  
		beq t5 zero endOccurencies 
		addi t0 t0 1 
		bne t5 a5 avoidRepeat 
		addi a0 a0 1
		j pullCharacter 
	
		avoidRepeat:
		sb t5 0(a3)  
		addi a3 a3 1 
		sb t6 0(a3) 
		addi a3 a3 1 
		li a6 10 
		blt t0 a6 minTen 
		div t1 t0 a6 
		addi t1 t1 48 
		sb t1 0(a3) 
		addi a3 a3 1 
		rem t1 t0 a6
		addi t1 t1 48 
		sb t1 0(a3) 

		j continue 

		minTen:
		addi t0 t0 48 
		sb t0 0(a3) 
		addi t0 t0  -48 
			
		continue:
		addi sp sp -12 
		sw a0 0(sp) 
		sw ra 4(sp) 
		sw t0 8(sp)
		jal putPosition
		lw ra 4(sp) 
		lw a0 0(sp)
		lw t0 8(sp)	
		addi sp sp 12 	
		addi a0 a0 1
		addi a3 a3 1
		sb t2 0(a3)
		addi a3 a3 1
		j pullCharacter	

		endOccurencies:
		addi a1 a3 -1 
		sb zero 0(a3)   
		addi a0 a7 0 
		li t0 0
		li t1 0
		li t2 0
		li t3 0
		li t4 0
		li t5 0
		li t6 0
		li a3 0
		li a7 0
		li a6 0
		jr ra

		putPosition:
		addi a0 a0 1
		lb a6 0(a0) 
		beq a6 zero endPosition 
		addi t0 t0 1 
		beq a6 t5 addPosition 
		j putPosition

		endPosition: 
		jr ra
		
		addPosition:
		addi a3 a3 1
		sb t6 0(a3)
		addi a3 a3 1 
		li a6 10 
		blt t0 a6 minTenTwo 
		div t1 t0 a6 
		addi t1 t1 48 
		sb t1 0(a3) 
		addi a3 a3 1 
		rem t1 t0 a6  
		addi t1 t1 48 
		sb t1 0(a3) 
		
		j continueTwo


		minTenTwo:
		addi t0 t0 48  
		sb t0 0(a3)	
		addi t0 t0 -48

		continueTwo:
		sb a5 0(a0)
		j putPosition	



		cifrarioD: 
		addi sp sp -4	
		sw ra 0(sp)	
		jal dictionary 
		lw ra 0(sp) 
		addi sp sp 4 
			
		add a1 a0 zero 
		add a2 a0 zero

		li a0 4
		ecall

		la a1 characterUnderLine
		ecall

		addi a0 a2 0

		lw a1 0(sp) 
		addi sp sp 4 
		j controlCharacter 


		dictionary:
		add a1 a0 zero 
		li t1 48 
		li t2 58
		li t3 65 
		li t4 91 
		li t5 97
		li t6 123
		li a6 9
		li a7 26
		
		dictionaryLoop:
		lb t0 0(a1)
		beq t0 zero endLoop
		blt t0 t1 sym
		blt t0 t2 decNumbers
		blt t0 t3 sym
		blt t0 t4 decMaiusc
		blt t0 t5 sym
		blt t0 t6 decMinusc
		
		sym:
		addi a1 a1 1
		j dictionaryLoop

		decNumbers:
		addi t0 t0 -48
		sub t0 a6 t0 
		addi t0 t0 48	
		sb t0 0(a1)
		addi a1 a1 1
		j dictionaryLoop
			
		decMaiusc:
		addi t0 t0 -65
		sub t0 a7 t0
		addi t0 t0 96
		sb t0 0(a1)
		addi a1 a1 1
		j dictionaryLoop

		decMinusc:
		addi t0 t0 -97
		sub t0 a7 t0
		addi t0 t0 64
		sb t0 0(a1)
		addi a1 a1 1
		j dictionaryLoop
		
		
		endLoop:
		jr ra 


	
	
	decryptString:
	addi a1 a1 -1
		
		decryptLoop:
		addi a1 a1 -1 
		lb t0 0(a1)	
		addi sp sp -4 
		sw a1 0(sp)

		beq t0 zero endDecryptString 
		beq t0 s1 decifroA 
		beq t0 s2 decifroB 
		beq t0 s3 decifroC 
		beq t0 s4 decifroD 

		j decryptLoop
	

		decifroA:
		lw a1 sostK 
		addi sp sp -4 
		sw ra 0(sp) 
		jal decryptSubstitution
		lw ra 0(sp) 
		addi sp sp 4 
		lw a1 0(sp)
		addi sp sp 4
		j decryptLoop

		
		decryptSubstitution:
		li t1 -1
		mul a1 a1 t1 
		addi sp sp -4
		sw ra 0(sp)
		jal substitution
		lw ra 0(sp)
		addi sp sp 4
		jr ra
	

		decifroB:
		la a1 blocKey 
		addi sp sp -4 
		sw ra 0(sp)
		jal decryptBlock
		lw ra 0(sp) 
		addi sp sp 4 
		lw a1 0(sp)
		addi sp sp 4
		j decryptLoop
		
		
		decryptBlock:
		li t0 0
		li t1 0
		li t2 0
		li t6 0
		li a2 32
		li a3 0
		li a4 256
		li a5 96
		li a7 240
		addi t4 a1 0
		addi t3 a1 0
		addi t5 a0 0 

		decryptCalculateString:
		lb t0 0(t4) 
		beq t0 zero decryptBlock2 
		addi t1 t1 1 
		addi t4 t4 1
		j decryptCalculateString			
	

		decryptBlock2:
		lb t0 0(a0)
		beq t0 zero endDecryptB
		addi t0 t0 -32
		bge t0 a2 noSum
		addi t0 t0 96		

		noSum:
		lb t2 0(t3)
		addi t2 t2 -32 
		sub t0 t0 t2
		addi t0 t0 32
		blt a3 t0 okNum
		addi t0 t0 -160 

		okNum:
		bge t0 a2 numOk
		addi t0 t0 96
		
		numOk:
		blt a3 t0 okNum2
		addi t0 t0 -96
		
		okNum2:
		li t4 128
		blt t0 t4 okNum3
		addi t0 t0 -96
		
		okNum3:
		sb t0 0(a0)
		addi t6 t6 1
		rem t6 t6 t1
		add t3 t6 a1
		addi a0 a0 1
		j decryptBlock2

	
		endDecryptB:
		addi a0 t5 0 
		li t0 0
		li t1 0
		li t2 0
		li t3 0
		li t4 0
		li t5 0
		li t6 0
		li a2 0
		jr ra


		decifroC:
		addi sp sp -4
		sw ra 0(sp)
		jal decryptOccurencies
		lw ra 0(sp)
		addi sp sp 4
		lw a1 0(sp)
		addi sp sp 4
		j decryptLoop		


		decryptOccurencies:
		li t6 45
		li t5 32
		li t0 3
		li t1 0
		li t2 0
		li a3 0
		li a6 0
		li a7 0
		li t4 0
		li a6 0
		mul a3 a0 t0

		decryptOccurrenciesLoop:
		lb t0 0(a0) 
		beq t0 zero endDecryptC 
		
		posLoop:
		addi a0 a0 1
		lb t1 0(a0) 
		beq t1 t6 countLoop 
		addi a0 a0 1
		j decryptOccurrenciesLoop	

		countLoop:
		addi a0 a0 1
		lb t1 0(a0)
		beq t1 zero endDecryptC 
		add t2 a3 t1 
		addi t2 t2 -48
		addi t3 a0 1
		lb t4 0(t3)
		beq t4 t5 endLoopDecrypt
		beq t4 t6 endLoopDecrypt
		beq t4 zero endLoopDecrypt
		li a7 10
		addi t1 t1 -48
		mul a6 a7 t1
		addi t4 t4 -48
		add a6 a6 t4
		add a6 a3 a6
		sb t0 0(a6)
		addi a0 a0 1
		j posLoop		

		endLoopDecrypt:
		sb t0 0(t2)
		j posLoop		
				
		endDecryptC:
		addi a0 a3 1 
		li t0 0
		li t1 0
		li t2 0
		li t3 0
		li t4 0
		li t5 0
		li t6 0
		li a6 0
		li a7 0
		jr ra		

		decifroD:
		addi sp sp -4
		sw ra 0(sp)
		jal decryptDictionary
		lw ra 0(sp)
		addi sp sp 4
		lw a1 0(sp)
		addi sp sp 4
		j decryptLoop
		

		decryptDictionary:
		addi sp sp -4
		sw ra 0(sp)
		jal dictionary
		lw ra 0(sp)
		addi sp sp 4
		jr ra


	endEncryptString:
		addi sp sp 4
		jr ra 
		

	endDecryptString:
		addi sp sp 4
		jr ra

	endProgram:
		add a1 a0 zero 
		li a0 4
		ecall

		la a1 characterUnderLine
		ecall

		la a1 stringExit
		li a0 4
		ecall

	
	
	
	
	
	

	
isalvo le posizioni allocate
		lw a0 0(sp)
		lw t0 8(sp)	
		addi sp sp 12 #riequilibrio lo stack	
		addi a0 a0 1
		addi a3 a3 1
		sb t2 0(a3)
		addi a3 a3 1
		j pullCharacter	

		endOccurencies:
		addi a1 a3 -1 #cancello l'ultimo carattere della stringa perchè sennò il programma inserirebbe
					#un carattere in eccesso
		sb zero 0(a3) #azzerro  
		addi a0 a7 0 #qui carico la testa della stringa
		li t0 0
		li t1 0
		li t2 0
		li t3 0
		li t4 0
		li t5 0
		li t6 0
		li a3 0
		li a7 0
		li a6 0
		jr ra

		putPosition:
		addi a0 a0 1 #scorro di 1
		lb a6 0(a0) #carico la posizione in a6 
		beq a6 zero endPosition #se è uguale a 0 = fine stringa
		addi t0 t0 1 #scorro di 1 
		beq a6 t5 addPosition #se carattere uguale a quello che cerco aggiungo posizione
		j putPosition

		endPosition: #ritorno al chiamante
		jr ra
		
		addPosition:
		addi a3 a3 1 #scorro di 1
		sb t6 0(a3) #carico il byte in t6
		addi a3 a3 1 #scorro di 1
		li a6 10 #carico 10 in a6
		blt t0 a6 minTenTwo #controllo se il carattere è 		
		div t1 t0 a6 #se è maggiore devo scomporre il numero in decine ed unità ed inserirle separatamente 
		addi t1 t1 48 #sommo il numero di 48
		sb t1 0(a3) #carico le decine
		addi a3 a3 1 #scorro di 1
		rem t1 t0 a6  #faccio il modulo
		addi t1 t1 48 
		sb t1 0(a3) #carico le unità		
		
		j continueTwo


		minTenTwo:
		addi t0 t0 48 #sommo 48 
		sb t0 0(a3)	#carico il byte
		addi t0 t0 -48

		continueTwo:
		sb a5 0(a0)
		j putPosition	



		cifrarioD: 
		addi sp sp -4	 #alloco memoria
		sw ra 0(sp)	#salvo indirizzo di ritorno
		jal dictionary #salto a cifrare tramite dizionario 
		lw ra 0(sp) #recupero indirizzo di memoria
		addi sp sp 4 #recupero memoria
			
		add a1 a0 zero 
		add a2 a0 zero

		li a0 4
		ecall

		la a1 characterUnderLine
		ecall

		addi a0 a2 0

		lw a1 0(sp) #carico ultima indice ultima lettera analizzata
		addi sp sp 4 #recupero memoria
		j controlCharacter 


		dictionary:
		add a1 a0 zero #salvo tutti gli estremi dove sono presenti i vari caratteri
		li t1 48 
		li t2 58
		li t3 65 
		li t4 91 
		li t5 97
		li t6 123
		li a6 9
		li a7 26
		
		dictionaryLoop:
		lb t0 0(a1)
		beq t0 zero endLoop
		blt t0 t1 sym
		blt t0 t2 decNumbers
		blt t0 t3 sym
		blt t0 t4 decMaiusc
		blt t0 t5 sym
		blt t0 t6 decMinusc
		
		sym:
		addi a1 a1 1
		j dictionaryLoop

		decNumbers:
		addi t0 t0 -48
		sub t0 a6 t0 
		addi t0 t0 48	
		sb t0 0(a1)
		addi a1 a1 1
		j dictionaryLoop
			
		decMaiusc:
		addi t0 t0 -65
		sub t0 a7 t0
		addi t0 t0 96
		sb t0 0(a1)
		addi a1 a1 1
		j dictionaryLoop

		decMinusc:
		addi t0 t0 -97
		sub t0 a7 t0
		addi t0 t0 64
		sb t0 0(a1)
		addi a1 a1 1
		j dictionaryLoop
		
		
		endLoop:
		jr ra #ritorno al chiamante


	#DECIFRATURA STRINGA 
	
	decryptString:
	addi a1 a1 -1 #per non contare lo zero in fondo
		
		decryptLoop:
		addi a1 a1 -1 #per prendere il carattere corrente
		lb t0 0(a1)	#carico il carattere corrente in t0
		addi sp sp -4 #alloco la memoria 
		sw a1 0(sp) #salvo nello stack l'indice della lettera analizzata

		beq t0 zero endDecryptString #controllo di non essere arrivato alla fine della chiave
		beq t0 s1 decifroA #controllo se carattere A 
		beq t0 s2 decifroB #controllo se carattere B
		beq t0 s3 decifroC #controllo se carattere C
		beq t0 s4 decifroD #controllo se carattere D 

		j decryptLoop
	

		decifroA:
		lw a1 sostK #carico il valore dello shift
		addi sp sp -4 #alloco la memoria 
		sw ra 0(sp) #salvo l'indirizzo di ritorno
		jal decryptSubstitution
		lw ra 0(sp) #resetto ra
		addi sp sp 4 #riequilibrio lo stack
		lw a1 0(sp)
		addi sp sp 4
		j decryptLoop

		
		decryptSubstitution:
		li t1 -1
		mul a1 a1 t1 
		addi sp sp -4
		sw ra 0(sp)
		jal substitution
		lw ra 0(sp)
		addi sp sp 4
		jr ra
	

		decifroB:
		la a1 blocKey #carico il blocco
		addi sp sp -4 
		sw ra 0(sp)
		jal decryptBlock
		lw ra 0(sp) #resetto ra
		addi sp sp 4 #riequilibrio lo stack
		lw a1 0(sp)
		addi sp sp 4
		j decryptLoop
		
		
		decryptBlock:
		li t0 0
		li t1 0
		li t2 0
		li t6 0
		li a2 32
		li a3 0
		li a4 256
		li a5 96
		li a7 240
		addi t4 a1 0
		addi t3 a1 0
		addi t5 a0 0 

		decryptCalculateString:
		lb t0 0(t4) #carico il carattere corrente
		beq t0 zero decryptBlock2 #se trovo fine stringa salto a fine
		addi t1 t1 1 
		addi t4 t4 1
		j decryptCalculateString			
	

		decryptBlock2:
		lb t0 0(a0)
		beq t0 zero endDecryptB
		addi t0 t0 -32
		bge t0 a2 noSum
		addi t0 t0 96		

		noSum:
		lb t2 0(t3)
		addi t2 t2 -32 
		sub t0 t0 t2
		addi t0 t0 32
		blt a3 t0 okNum
		addi t0 t0 -160 

		okNum:
		bge t0 a2 numOk
		addi t0 t0 96
		
		numOk:
		blt a3 t0 okNum2
		addi t0 t0 -96
		
		okNum2:
		li t4 128
		blt t0 t4 okNum3
		addi t0 t0 -96
		
		okNum3:
		sb t0 0(a0)
		addi t6 t6 1
		rem t6 t6 t1
		add t3 t6 a1
		addi a0 a0 1
		j decryptBlock2

	
		endDecryptB:
		addi a0 t5 0 
		li t0 0
		li t1 0
		li t2 0
		li t3 0
		li t4 0
		li t5 0
		li t6 0
		li a2 0
		jr ra


		decifroC:
		addi sp sp -4
		sw ra 0(sp)
		jal decryptOccurencies
		lw ra 0(sp)
		addi sp sp 4
		lw a1 0(sp)
		addi sp sp 4
		j decryptLoop		


		decryptOccurencies:
		li t6 45
		li t5 32
		li t0 3
		li t1 0
		li t2 0
		li a3 0
		li a6 0
		li a7 0
		li t4 0
		li a6 0
		mul a3 a0 t0

		decryptOccurrenciesLoop:
		lb t0 0(a0) #recupero un carattere 
		beq t0 zero endDecryptC 
		
		posLoop:
		addi a0 a0 1
		lb t1 0(a0) #pesco il carattere successivo 
		beq t1 t6 countLoop #se il carattere successivo è un trattino vuol dire che avrò una posizione 
							# del carattere di cui sto contando le occorrenze
		addi a0 a0 1
		j decryptOccurrenciesLoop	

		countLoop:
		addi a0 a0 1
		lb t1 0(a0)
		beq t1 zero endDecryptC #se è zero concludo algoritmo 
		add t2 a3 t1 #aggiungo alla posizione del carattere
		addi t2 t2 -48
		addi t3 a0 1
		lb t4 0(t3)
		beq t4 t5 endLoopDecrypt
		beq t4 t6 endLoopDecrypt
		beq t4 zero endLoopDecrypt
		li a7 10
		addi t1 t1 -48
		mul a6 a7 t1
		addi t4 t4 -48
		add a6 a6 t4
		add a6 a3 a6
		sb t0 0(a6)
		addi a0 a0 1
		j posLoop		

		endLoopDecrypt:
		sb t0 0(t2)
		j posLoop		
				
		endDecryptC:
		addi a0 a3 1 #salvo in a0 la testa della stringa
		li t0 0
		li t1 0
		li t2 0
		li t3 0
		li t4 0
		li t5 0
		li t6 0
		li a6 0
		li a7 0
		jr ra		

		decifroD:
		addi sp sp -4
		sw ra 0(sp)
		jal decryptDictionary
		lw ra 0(sp)
		addi sp sp 4
		lw a1 0(sp)
		addi sp sp 4
		j decryptLoop
		

		decryptDictionary:
		addi sp sp -4
		sw ra 0(sp)
		jal dictionary
		lw ra 0(sp)
		addi sp sp 4
		jr ra


	endEncryptString:
		addi sp sp 4
		jr ra 
		

	endDecryptString:
		addi sp sp 4
		jr ra

	endProgram:
		add a1 a0 zero # stampa stringa finale
		li a0 4
		ecall

		la a1 characterUnderLine
		ecall

		la a1 stringExit
		li a0 4
		ecall

	
	
	
	
	
	

	

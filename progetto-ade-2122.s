#Progetto Architetture degli Elaboratori 2021/2022 - Jonathan Colombo

.data
    sostK: .word 1
    myPlainText: .string "LAUREATO"
    characterUnderLine: .byte 10       
    characterDiv: .word 0          	
	 myCypher: .string "B"
    blockKey: .string "OLE"
	 stringExit: .string "Programma terminato!"
	 stringCypherExit: .string "Caratteri terminati nella chiave!"
    stringDebugA: .string "Debug algoritmo A -> " 
    stringDebugB: .string "Debug algoritmo B -> " 
    stringFinal: .string "Stringa computata -> "
    
.text 
    main:
        la a0 myPlainText
        li a7 4
        ecall 
        
        la a0 characterUnderLine
        la a1 11
        ecall
        
        la a0 myCypher
        la a1 myPlainText
        li s1 65	#carico A
        li s2 66 	#carico B
        li s3 67    #carico C
        li s4 68    #carico D
        li s5 69    #carico E
        jal encryptString
        jal decryptString
        j endProgram
        
        encryptString:
            
            controlCharacter:
                lb t0 0(a0) #carico il carattere da controllare
                addi a0 a0 1 #incremento di 1 il count di mycypher
                addi sp sp -4 #alloco memoria
                sw a0 0(sp) 
                
                beq t0 zero endEncryptString
                beq t0 s1 cryptA
                beq t0 s2 cryptB
                #beq t0 s3 algorithmC
                #beq t0 s4 algorithmD
                #beq t0 s5 algorithmE
                j controlCharacter
                
                cryptA:
                    lw a0 sostK #carico lo shift 
                    addi sp sp -4 #alloco memoria per un byte
                    sw ra 0(sp) #mi salvo l'indirizzo di ritorno
                    jal substitution
                    
                    lw ra 0(sp)
                    addi sp sp 4 
                    
                    la a0 stringDebugA
                    li a7 4
                    ecall
                    
                    add a0 a1 zero
                    add a2 a1 zero
                    
                    li a7 4
                    ecall
                    
                    la a0 characterUnderLine
                    la a1 11
                    ecall
                    
                    addi a1 a2 0
                    lw a0 0(sp)
                    addi sp sp 4
                    j controlCharacter
                   
                    substitution:
                        li t1 26
                        li t2 65
                        li t3 91
                        li t4 97
                        li t5 123 
                        
                        add t6 a1 zero
                        
                        blt a0 zero correctNegative
                        
                        rem a0 a0 t1
                        
                        j loopEncryptA
                        
                        correctNegative:
                            sub a0 zero a0 
                            rem a0 a0 t1
                            sub a0 t1 a0
                            
                            loopEncryptA:
                                lb t0 0(t6)
                                
                                beq t0 zero endEncryptA
                                blt t0 t2 increaseIndexCharacter
                                bge t0 t5 increaseIndexCharacter 
                                blt t0 t3 characterMaiusc
                                blt t0 t4 increaseIndexCharacter
                                
                                #aggiusto i minuscoli
                                add a2 t0 a0
                                addi a2 a2 -97
                                rem a2 a2 t1
                                add a2 a2 t4
                                sb a2 0(t6)
                                j increaseIndexCharacter 
                                
                                characterMaiusc:
                                    add a2 t0 a0 
                                    addi a2 a2 -65
                                    rem a2 a2 t1
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
                                            lw a0 sostK
                                            jr ra
                cryptB:
                    la a0 blockKey
                    
                    addi sp sp -4
                    sw ra 0(sp)
                    
                    jal encryptBlock
                    
                    lw ra 0(sp)
                    addi sp sp 4
                    
                    la a0 stringDebugB
                    li a7 4
                    ecall
                    
                    add a0 a1 zero
                    add a2 a1 zero
                    
                    li a7 4
                    ecall
                    
                    la a0 characterUnderLine
                    la a1 11
                    ecall
                    
                    addi a1 a2 0
                    
                    lw a0 0(sp)
                    addi sp sp 4
                    j controlCharacter 
                     
                    encryptBlock:
                        li t0 0
                        li t1 0
		                li t2 0
		                li t6 0
                        
                        li a2 96
                        add t4 t4 a0
                        add t3 t3 a0 
                        addi t5 a1 0
                         
                        calculateString:
                            lb t0 0(t4)
                            beq t0 zero block
                            addi t1 t1 1
                            addi t4 t4 1
                            j calculateString
                            
                            
                        block:
                            lb t0 0(a1)
                            beq t0 zero endEncryptB
                            addi t0 t0 -32
                            lb t2 0(t3)
                            addi t2 t2 -32 
                            add t0 t2 t0
                            
                            rem t0 t0 a2
                            addi t0 t0 32
                            sb t0 0(a1)
                            addi t6 t6 1
                            rem t6 t6 t1
                            add t3 t6 a0
                            addi a1 a1 1
                            j block
                            
                            endEncryptB:
                                add a1 t5 zero
                                li t0 0
		                        li t1 0
		                        li t2 0
		                        li t3 0
		                        li t4 0
		                        li t5 0
		                        li t6 0		
		                        li a2 0
		                        jr ra 
                            
                                                
                decryptString:
                    addi a0 a0 -1    
                    
                        decryptLoop:
                            addi a0 a0 -1
                            lb t0 0(a0)
                            addi sp sp -4
                            sw a0 0(sp)
                            
                            beq t0 zero endDecryptString
                            beq t0 s1 decryptA
                            beq t0 s2 decryptB
                            #beq t0 s3 decryptC
                            #beq t0 s4 decryptD
                            #beq t0 s5 decryptE
                            j decryptLoop
                
                decryptA:
                    lw a0 sostK
                    addi sp sp -4
                    sw ra 0(sp)
                    jal decryptSubstitution
                    lw ra 0(sp)
                    addi sp sp 4
                    lw a0 0(sp)
                    addi sp sp 4
                    j decryptLoop
                    
                decryptSubstitution:
                    li t1 -1
                    mul a0 a0 t1
                    addi sp sp -4
                    sw ra 0(sp)
                    jal substitution
                    lw ra 0(sp)
                    addi sp sp 4
                    jr ra                                
                 
                 decryptB:
                     la a0 blockKey
                     addi sp sp -4
                     sw ra 0(sp)
                     jal decryptBlock
                     #finire e controllare parte decryptB
                     lw ra 0(sp)
                     addi sp sp 4
                     
                     
                     la a0 stringDebugB
                    li a7 4
                    ecall
                    
                    add a0 a1 zero
                    add a2 a1 zero
                    
                    li a7 4
                    ecall
                    
                    la a0 characterUnderLine
                    la a1 11
                    ecall
                    
                    addi a1 a2 0
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
                     addi t4 a0 0
                     addi t3 a0 0 
                     addi t5 a1 0
                     
                 decryptCalculateString:
                     lb t0 0(t4)
                     beq t0 zero decryptBlockTwo
                     addi t1 t1 1
                     addi t4 t4 1
                     j decryptCalculateString
                     
                 decryptBlockTwo:
                     lb t0 0(a1)
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
                     sb t0 0(a1)
                     addi t6 t6 1
                     rem t6 t6 t1
                     add t3 t6 a0
                     addi a1 a1 1
                     j decryptBlockTwo
                 
                        
                  endDecryptB:
                      addi a1 t5 0
                      li t0 0 
                      li t1 0
                      li t2 0
                      li t3 0
                      li t4 0
                      li t5 0
                      li t6 0
                      li a2 0
                      li a6 0
                      jr ra 
                         
                     
                                            
                endEncryptString:
                    addi sp sp 4
                    jr ra 
                    
                endDecryptString:
                    addi sp sp 4
                    jr ra
                    
                endProgram:
                    la a0 stringFinal
                    li a7 4
                    ecall
                    
                    add a0 a1 zero #stampo la stringa finale
                    li a7 4 
                    ecall
                    
                    la a0 characterUnderLine
                    la a1 11
                    ecall
                    
                    la a0 stringExit
                    li a7 4
                    ecall
            
            
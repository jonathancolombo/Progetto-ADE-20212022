#Progetto Architetture degli Elaboratori 2021/2022 - Jonathan Colombo

.data
    sostK: .word 1
    myPlainText: .string "myStr0ng P4ssW"
    characterUnderLine: .byte 10       
    characterDiv: .word 0          	
	  myCypher: .string "ABCDE"
    blockKey: .string "OLE"
	  stringExit: .string "Programma terminato!"
	  stringCypherExit: .string "Caratteri terminati nella chiave!"
    stringDebugA: .string "Debug algoritmo di cifratura A -> " 
    stringDebugB: .string "Debug algoritmo di cifratura B -> " 
    stringDebugC: .string "Debug algoritmo di cifratura C -> " 
    stringDebugD: .string "Debug algoritmo di cifratura D -> " 
    stringDebugE: .string "Debug algoritmo di cifratura E -> "
    
    stringDebugDA: .string "Debug algoritmo di decifratura A -> " 
    stringDebugDB: .string "Debug algoritmo di decifratura B -> " 
    stringDebugDC: .string "Debug algoritmo di decifratura C -> " 
    stringDebugDD: .string "Debug algoritmo di decifratura D -> " 
    stringDebugDE: .string "Debug algoritmo di decifratura E -> "
    
    stringFinal: .string "Stringa computata inizialmente decifrata -> "
    
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
                beq t0 s3 cryptC
                beq t0 s4 cryptD
                beq t0 s5 cryptE
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
                            lb t0 0(a1) #t0 = cod(bij)
                            beq t0 zero endEncryptB 
                            #addi t0 t0 -32
                            lb t2 0(t3) #t2 = cod(keyij)
                            #add t2 t2 t0 
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

                cryptC:
                    addi sp sp -4
                    sw ra 0(sp)
                    jal occurencies
                    
                    lw ra 0(sp)
                    addi sp sp 4
                    
                    la a0 stringDebugC
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
                    
                    occurencies:
                        li t2 4
                        li t6 45
                        div a3 a1 t2
                        add a7 a3 zero
                        li t2 32 
                        li a5 -1
                        li a4 48
                        li t0 0
                    
                    pullCharacter:
                        lb t5 0(a1)
                        beq t5 zero endOccurencies
                        addi t0 t0 1
                        bne t5 a5 avoidRepeat
                        addi a1 a1 1
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
                            addi t0 t0 -48
                        
                        continue:
                            addi sp sp -12
                            sw a1 0(sp) 
                            sw ra 4(sp)
                            sw t0 8(sp)
                            jal putPosition
                            lw a1 0(sp)
                            lw ra 4(sp)
                            lw t0 8(sp)
                            addi sp sp 12
                            addi a1 a1 1
                            addi a3 a3 1
                            sb t2 0(a3)
                            addi a3 a3 1
                            j pullCharacter
                            
                        endOccurencies:
                            addi a0 a3 -1
                            sb zero 0(a3)
                            addi a1 a7 0
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
                            addi a1 a1 1
                            lb a6 0(a1)
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
                             sb a5 0(a1)
                             j putPosition
                             
                 cryptD:
                     addi sp sp -4
                     sw ra 0(sp)
                     jal dictionary
                     
                     lw ra 0(sp)
                    addi sp sp 4
                    
                    la a0 stringDebugD
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
                     
                 dictionary:
                     add a0 a1 zero
                     li t1 48
                     li t2 58
	                 li t3 65 
		             li t4 91 
		             li t5 97
		             li t6 123
		             li a6 9
		             li a7 26

                 dictionaryLoop:
                     lb t0 0(a0)
                     beq t0 zero endLoop
		             blt t0 t1 sym
		             blt t0 t2 decNumbers
	            	 blt t0 t3 sym
	            	 blt t0 t4 decMaiusc
	            	 blt t0 t5 sym
		             blt t0 t6 decMinusc

                  sym:
            		addi a0 a0 1
		            j dictionaryLoop           
                 
                   decNumbers:
		            addi t0 t0 -48
		            sub t0 a6 t0 
		            addi t0 t0 48	
		            sb t0 0(a0)
		            addi a0 a0 1
		            j dictionaryLoop
                    
                    decMaiusc:
		                addi t0 t0 -65
		                sub t0 a7 t0
	                	addi t0 t0 96
		                sb t0 0(a0)
	                	addi a0 a0 1
		                j dictionaryLoop
                    
                    decMinusc:
		                addi t0 t0 -97
		                sub t0 a7 t0
		                addi t0 t0 64
		                sb t0 0(a0)
		                addi a0 a0 1
		                j dictionaryLoop
                        
                        endLoop:
		                jr ra 

                cryptE:
                         addi sp sp -4
                         sw ra 0(sp)
                         jal inversion
                         
                         lw ra 0(sp)
                         addi sp sp 4
                    
                        la a0 stringDebugE
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
                            beq t0 s3 decryptC
                            beq t0 s4 decryptD
                            beq t0 s5 decryptE
                            j decryptLoop
                
                decryptA:
                    lw a0 sostK
                    addi sp sp -4
                    sw ra 0(sp)
                    jal decryptSubstitution
                    
                     lw ra 0(sp)
                    addi sp sp 4
                    
                    la a0 stringDebugDA
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
                    
                     la a0 stringDebugDB
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
                     j decryptLoop
                     
                 decryptBlock:
                     li t0 0
                     li t1 0
                     li t2 0
                     li t6 0
                     li a2 32
                     li a3 0
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
                     lb t0 0(a1) #carico cod(bij) e in t0
                     beq t0 zero endDecryptB
                     lb t2 0(t3) #carico il cod(kij)
                     addi t0 t0 64
                     sub t0 t0 t2
                     rem t0 t0 a5
                     blt t0 a2 setSpecialChar
                     sb t0 0(a1)
                     addi t6 t6 1
                     rem t6 t6 t1
                     add t3 t6 a0
                     addi a1 a1 1
                     j decryptBlockTwo
                     
                 setSpecialChar:
                     add t0 t0 a5
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
                       
                  decryptC:
                      addi sp sp -4
                      sw ra 0(sp) 
                      jal decryptOccurencies
                      lw ra 0(sp)
                    addi sp sp 4
                    
                    la a0 stringDebugDC
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
                      mul a3 a1 t0
                      
                  decryptOccurenciesLoop:
                      lb t0 0(a1)
                      beq t0 zero endDecryptC
                      
                      posLoop:
                          addi a1 a1 1
                          lb t1 0(a1)
                          beq t1 t6 countLoop
                          addi a1 a1 1
                          j decryptOccurenciesLoop
                      
                      countLoop:
                          addi a1 a1 1
                          lb t1 0(a1)
                          beq t1 zero endDecryptC
                          add t2 a3 t1
                          addi t2 t2 -48
                          addi t3 a1 1
                          lb t4 0(t3)
                          beq t4 t5 endLoopDecryptC
                          beq t4 t6 endLoopDecryptC
                          beq t4 zero endLoopDecryptC
                          li a7 10
                          addi t1 t1 -48
                          mul a6 a7 t1
                          addi t4 t4 -48
                          add a6 a6 t4
                          add a6 a3 a6
                          sb t0 0(a6)
                          addi a1 a1 1
                          j posLoop 
                      
                      endLoopDecryptC:
                         sb t0 0(t2)
                         j posLoop
                         
                     endDecryptC:
                         addi a1 a3 1
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
                
                decryptD:
                    addi sp sp -4
                    sw ra 0(sp)
                    jal decryptDictionary
                    lw ra 0(sp)
                    addi sp sp 4
                    
                    la a0 stringDebugDD
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
                    
                    j decryptLoop
                
                decryptDictionary:
                    addi sp sp -4
                    sw ra 0(sp)
                    jal dictionary
                    lw ra 0(sp)
                    lw a0 0(sp)
                    addi sp sp 4
                    jr ra
                    
                    decryptE:
                         addi sp sp -4
                         sw ra 0(sp)
                         jal inversion
                         
                         lw ra 0(sp)
                         addi sp sp 4
                    
                        la a0 stringDebugDE
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
                        j decryptLoop
                        
                        inversion:
                         li t1 0 #primo contatore
                         li s7 0 #contatore lungh. max
                         
                         count_loop:
                             add t2 t1 a1 #carico la pos del carattere da controllare e conteggiare in t2
                             addi t1 t1 1 #increm. il cont.
                             lb t4 0(t2) #carico il val. del carattere in t4
                             beq t4 zero count_end
                             addi s7 s7 1 #increm. count per calcolo lungh. max.
                             j count_loop
                             
                         count_end:
                             li t1 0
                             
                                 loop_inversion:
                                     add t2 t1 a1 #pesco l'indice dell'inizio
                                     addi t1 t1 1 #incremento il count
                                     sub s8 s7 t1 #pesco l'indice dell'ultimo
                                     lb t4 0(t2) #carico il carattere dell'inizio
                                     beq t4 zero back_cryptE #se sono arrivato a fine stringa
                                     add s9 s8 a1 #pesco l'indice dell'ultimo
                                     lb t5 0(s9) #carico il carattere del fondo
                                     blt s8 t1 back_cryptE #controllo di non aver superato la metà
                                     sb t4 0(s9)
                                     sb t5 0(t2)
                                     j loop_inversion

                         back_cryptE:
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
            
            
.globl matrix_transpose_asm

matrix_transpose_asm:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        /* Write your solution here */
        
        mov $0, %eax
		mov $0, %ebx
		mov $0, %ecx
		mov $0, %edx
		mov $0, %esi
		mov $0, %edi    #Initialisation de tout les registres a 0
		
		# les param passes a la fonction sont deja places au dessus du EBP (commence a 8(%ebp))
		# valeur de retour est (%ebp)
		# inmatdata est 8(%ebp)
		# outmatdata est 12(%ebp)
		# matorder est 16(%ebp)
		
		sub $4, %esp 								# faire place pour mettre r
		sub $4, %esp 								# faire place pour mettre c
		mov 16(%ebp), %eax 							# mettre matorder dans %eax
		mov -4(%ebp), %ebx 							# mettre r dans %ebx
		mov -8(%ebp), %ecx 							# mettre c dans %ecx

        condLoop1:									#condition pour la loop1
				cmp %eax, %ebx						#cmp va activer les flags selon le tableau suivant (cmp = dest-src)
													#Dans notre cas %eax est src et dst est %ebx
				jz fin	                			#cmp src, dst 	        ZF  CF
														#	src = dst 		1 	0
														#	src < dst 		0 	0
														#	src > dst 		0 	1 
														#On utilise jz qui va faire un jump si matorder = r
						            
        forLoop1:
				condLoop2:							#condition pour la loop2
				cmp %eax, %ecx						#cmp va activer les flags selon le tableau suivant (cmp = dest-src)
													#Dans notre cas %eax est src et dst est %ecx
				jz forLoop1	            			#cmp src, dst 	        ZF  CF
														#	src = dst 		1 	0
														#	src < dst 		0 	0
														#	src > dst 		0 	1 
														#On utilise jz qui va faire un jump si matorder = c
						            
				forLoop2:
						mov %eax, %edx 				# mettre matorder dans un registre %edx pour mettre le resultat
						imul %ebx, %edx  			# faire r * matorder et mettre resultat dans %edx
						add %ecx, %edx 				# faire c + r * matorder et mettre resultat dans %edx
						
						mov %eax, %esi 				# mettre matorder dans un registre %esi pour mettre le resultat
						imul %ecx, %esi  			# faire c * matorder et mettre resultat dans %esi
						add %ebx, %esi 				# faire r + c * matorder et mettre resultat dans %esi
						
						add %edx, 12(%ebp) 			# prendre la valeur [c + r * matorder] de outmatdata
						add %esi, 8(%ebp) 			# prendre la valeur de [c + r * matorder] de inmatdata
						mov 8(%ebp), %esi 			# mettre la valeur de inmatdata dans un registre temporaire %esi
						mov %esi, 12(%ebp)			# mettre inmatdata dans outmatdata
						
				increment2:
						add $1, %ecx 				# Incremente c de 1 a chaque iteration de la boucle
						jmp condLoop2 				# revient a la condition de la loop2
				
		increment1:
				add $1, %ebx 						# Incremente r de 1 a chaque iteration de la boucle
				jmp condLoop1 						# revient a la condition de la loop1

        fin:
			leave          /* restore ebp and esp */
			ret            /* return to the caller */
        

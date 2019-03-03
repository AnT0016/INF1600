.global matrix_row_aver_asm

matrix_row_aver_asm:
        push %ebp      			/* Save old base pointer */
        mov %esp, %ebp 			/* Set ebp to current esp */

; 	mov 8(%ebp), %eax		# On met inmatdata1 dans eax
; 	mov 12(%ebp), %esi		# On met inmatdata2 dans esi
; 	mov 16(%ebp), %edx		# On met la valeur de matorder dans edx
; 	sub $4, %esp			# On fait de l'espace pour r # -4(%ebp) pointe sur r
; 	sub $4, %esp			# On fait de l'espace pour c # -8(%ebp) pointe sur c

; 	conditionFor:
; 		cmp %eax, -4(%ebp)	# On fait matorder - r et active les flags en consequent
; 		jnb exit					#cmp src, dst 	       	ZF  CF	
; 						            #	dst = src 		1 	0
; 						            #	dst < src 		0 	1
; 						            #	dst > src 		0 	0
; # jna est active si CF = 1 CAD quand la destination >= source 
; 		add $1, -4(%ebp)	# On ajoute 1 a r 

; 	conditionFor2:
; 		cmp %eax, -8(%ebp)	# On fait c-matorder et active les flags en consequent
; 		jnb conditionFor 	# Si c >= matorder on revient a la premiere loop
; 		add $1, -8(%ebp)	# On ajoute 1 a c 

; 	conditionIf:
; 		mov -8(%ebp), %ebx		# On met c dans ebx
; 		imul 16(%ebp), %ebx 		# On multiplie le contenu de ebp (c) avec matorder dans ebx 
; 		add -4(%ebp), %ebx	 	# On ajoute la valeur de r au conteu de ebx [c+r*matorder] dans ebx


; 		mov (%eax, %ebx), %ecx		# On met la valeur de inmatdata1[ebx] dans ecx
; 		mov (%esi, %ebx), %ebx		# On met la valeur de inmatdata2[ebx] dans ebx
; 		cmp %ebx, %ecx
; 		jne conditionFor		# Si les deux valeurs ne sont pas egale on increment et continu
; 		mov $1, %eax			# Si on arrive ici c'est que les deux valeurs sont egale alors on met 1 dans eax et on fini la fonction
; 		jmp fin
	 
; 	exit:
; 		mov $0, %eax			# On accede ici quand on ne retourne jamais 1	
; 	fin:
		leave          			/* Restore ebp and esp */
		ret           			/* Return to the caller */


# ebp pointe sur son adresse qui est l'endroit ou commence la fonction 
# ebp + 4 pointe a la valeur de l'adresse de la fonction precedente.	
# slide 19 cour 6
# ebp + 8 pointe ver inmatdata1
# ebp +12 pointe vers inmatdata2
# ebp+16 pointe vers matorder
# ebp-4 pointe vers la 1ere variable locale ...
# la valeur de retour est toujours dans eax

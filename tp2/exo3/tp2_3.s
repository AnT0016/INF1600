.data
	/* Votre programme assembleur ici... */
	i:
        .int 0x0

    constanteE:             #On peut mettre e dans un etiqiuette vu que ca valeur ne change pas tout au long du programme
        .int 0x0

    constante:              #Si on veut faire la boucle plus ou moins de fois on change la valeur associee a l'etiquette constante (on changerais donc 0xA en autre chose)
        .int 0xA

.global func_s

func_s:	
    mov $0, %eax
    mov $0, %ebx
    mov $0, %ecx
    mov $0, %edx
    mov $0, %esi
    mov $0, %edi    #Initialisation de tout les registres a 0 (On en a pas besoin mais c'est une habitude)

    mov b, %ebx             #Mettre la valeur de b dans le registre ebx
    mov c, %ecx             #Mettre la valeur de c dans le registre ecx
    mov d, %edx             #Mettre la valeur de d dans le registre edx
    mov e, %esi             #Mettre la valeur de e dans le registre esi
    mov %esi, constanteE     #Pacer la valeure de E (contenu dans le registre esi)a l'adresse memoire de l'etiquette constanteE
    mov i, %esi             #Mettre la variable i dans le registre esi

condition:
		cmp constante, %esi 	#cmp va activer les flags selon le tableau suivant
						        #Dans notre cas i est src et 10 dst
	    ja fin	                #cmp src, dst 	        ZF  CF	
						            #	dst = src 		1 	0
						            #	dst < src 		0 	1
						            #	dst > src 		0 	0 
						            #On utilise jna qui va faire un jump si i est <= a 10
forLoop:
       mov %edx, %eax           #Mettre la valeur du registre edx (d) dans le registre eax
       add constanteE, %eax      #Ajouter la valeur du registre esi (e) au registre eax
       sub %ebx, %eax           #Soustraire la valeur du registre ebx (b) du registre eax
       mov %eax, a		        #Placer la valeur du registre eax dans la variable a pour pouvoir utiliser le registre a d'autres fins (a n'es pas modifiee dans le reste du programme)		

ifBlock:
    mov %ebx, %eax              #Mettre la valeur du registre ebx(b) dans le registre eax
    sub $1000, %eax             #Soustraire 1000 de la valeur contenu dans eax et mettre le resultat dans le meme registre

    mov %ecx, %edi              #Mettre la valeure du registre ecx (c) dans le registre edi
    add $500, %edi              #Additionner 500 a la valeur contenu dans edi et mettre le resultat dans le meme registre

    cmp %eax, %edi              #Comparaison des valeur contenu dans les deux registres

    jnle ifStatement            #jnle fait une comparaison signee vu qu'a certain stades les valeurs des registre ebx (b) et ecx (c) sont negatives
    
elseBlock:
    sub constanteE, %ebx         #Soustraire la valeur de e du registre ebx et mettre le resultat dans ce meme registre
    add $500, %edx              #Ajouter 500 a la valeur contenu dans edx et mettre le resultat dans le meme registre
    jmp increment               #Incrementer et finir la loop for     

ifStatement:
    sub $500, %ecx              #Soustraire 500 de la valeur du regsitre ecx et palcer le resultat dans ce meme registre
    cmp %ecx, %ebx              #Comparer ecx et ebx et activer les bon flagds
    jnle ifBlock2               #jnle prend en consideration que la comparaison a ete faite sur des valeurs signees
    jmp increment               

ifBlock2:
    sub $500, %ebx              #Sosutraire 500 de la valeur du registre ebx et mettre le resultat dans ce meme registres

increment:
		add $1, %esi 		    #Incremente i a de 1 a chaque iteration de la boucle
		jmp condition		    #Sans condition a chaque fin de boucle va revenir a l'etape de condition
		
fin:
	ret                         #Fin de programme

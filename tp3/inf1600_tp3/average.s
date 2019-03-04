.global matrix_row_aver_asm

/*
** elem         -4(%ebp) 
** c            -8(%ebp)
** r            -12(%ebp)
** matorder     16(%ebp)
** outmatdata   12(%ebp)
** inmatdata    8(%ebp)
*/ 

matrix_row_aver_asm:
        push %ebp      			/* Save old base pointer */
        mov %esp, %ebp 			/* Set ebp to current esp */

    subl	$16, %esp               # On fait de l'espace pour r, c et esp
	movl	$0, -12(%ebp)           # On met 0 dans r
	jmp	condition1              # Sans condition partir a la condition 1

for1:
	movl	$0, -4(%ebp)            # Initialisation de element a 0
	movl	$0, -8(%ebp)            # Initialisation de c a 0
	jmp	condition2              # Sans condition aller a la condition 2

for2:
	movl	-12(%ebp), %eax         # On met r dans eax
	imull	16(%ebp), %eax          # Multiplication de matorder avec r
	movl	%eax, %edx              # On met r*matorder dans edx
	movl	-8(%ebp), %eax          # On met c dans eax
	addl	%edx, %eax              # On ajoute c a r*matorder
	leal	0(,%eax,4), %edx        # On trouve le contenu de l'adresse et met dans edx
	movl	8(%ebp), %eax           # On met inmatdata dans eax
	addl	%edx, %eax              # On fait inmatdata+ eedx (inmatdata[c+matorder*r])
	movl	(%eax), %eax            # On met le contenu a l'adresse eax dans eax
	addl	%eax, -4(%ebp)          # On ajoutue eax a c dans c
	addl	$1, -8(%ebp)            # On increment r de 1

condition2:
	movl	-8(%ebp), %eax          # On met c dans eax
	cmpl	16(%ebp), %eax          # Comapraison de c et matorder
	jnae	for2                    # Si c < matorder on fait un jump au for2
                                    # Sinon on :
	movl	-12(%ebp), %eax         # On met r dans eax
	leal	0(,%eax,4), %edx        # On trouve la valeur demandee et met dans edx
	movl	12(%ebp), %eax          # On met outmatdata dans eax
	leal	(%edx,%eax), %ecx       # On met edx+eax dans ecx
	movl	-4(%ebp), %eax          # On met c dans eax
	cltd                            # sign-extend EAX -> EDX:EAX (de stackoverflow pour regler une erreur de compilation)
	idivl	16(%ebp)                # Division par source 32,
	movl	%eax, (%ecx)            # On met la valeur de eax dans l'emplacement memeoire a l'adreesse ecx
	addl	$1, -12(%ebp)           # Icrementation de r de 1

condition1:
	movl	-12(%ebp), %eax         # On met r dans eax
	cmpl	16(%ebp), %eax          # Comparaison de r et matorder 
	jnae	for1                    # SI r < matorder aller au for1

fin:
        leave          /* restore ebp and esp */
        ret            /* return to the caller */

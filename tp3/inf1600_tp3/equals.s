.globl matrix_equals_asm

/*
** r            -8(%ebp)
** c            -4(%ebp)
** matorder     16(%ebp)
** inmatdata2   12(%ebp)
** inmatdata1   8(%ebp)
*/

matrix_equals_asm:
        push %ebp      /* Save old base pointer */
        mov %esp, %ebp /* Set ebp to current esp */

	subl	$8, %esp        # On fait de la palce sur la pile pour c -4(%ebp) et r -8(%ebp)
	movl	$0, -8(%ebp)    # Initialisation de r a 0
	jmp condition1          # Sans condition on va a la condition 1

        for1:
                movl	$0, -4(%ebp)            # Intialisation de c a 0 a chaque iteration de la boucle for 1
                jmp	condition2              # Sans condition on va a la boucle condition 2 

        for2:
                movl	-4(%ebp), %eax          # On met c dans eax
                imull	16(%ebp), %eax          # On multiplie matorder et c
                movl	%eax, %edx              # On met matorder*c dans edx
                movl	-8(%ebp), %eax          # On met r dans eax
                addl	%edx, %eax              # On ajout fait c*matorder + r
                leal	0(,%eax,4), %edx        # 
                movl	8(%ebp), %eax           # On met inmatdata dans eax
                leal	(%edx,%eax), %ecx       # On calcul inmatdata2[edx] et on met dans ecx
                movl	-8(%ebp), %eax          # On met r dans eax
                imull	16(%ebp), %eax          # On fait r*matorder
                movl	%eax, %edx              # On met eax dans edx
                movl	-4(%ebp), %eax          # On met c dans eax
                addl	%edx, %eax              # On fait r*matorder + c
                leal	0(,%eax,4), %edx        # On calcul inmatdata1[]
                movl	12(%ebp), %eax          # On met outmatdata dans eax
                addl	%eax, %edx              # On ajout ajoute eax a edx et on met dans edx
                movl	(%ecx), %eax            # On met met ecx(inmatdata[edx]) dans eax
                cmp	%eax, (%edx)            # Comparaison de eax et edx
                je      finEqual
                addl	$1, -4(%ebp)            # On increment c de 1


        condition2:
        	movl	-4(%ebp), %eax          # On met c dans eax
                cmpl	16(%ebp), %eax          # On compare c et matorder
                jnae	for2                    # Si eax < 16(ebp) on fait un jump
                addl	$1, -8(%ebp)            # On increment r (si on fait pas de jump)                        

        condition1:
                movl	-8(%ebp), %eax          # On met r dans %eax
                cmpl	16(%ebp), %eax          # Comparaison de 16(ebp) (matorder) et eax (r)
                jnae	for1                    # Si eax < 16(ebp) on fait un jump
                jmp     finNotEqual             # Sinon on sort de la fonction


        finNotEqual:
                mov $0, %eax
                leave          /* restore ebp and esp */
                ret            /* return to the caller */

        finEqual:
                mov $1, %eax
                leave   
                ret
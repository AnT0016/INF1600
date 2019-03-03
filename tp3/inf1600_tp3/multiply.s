.globl matrix_multiply_asm

/*
** elem         -16(%ebp)      
** i            -12(%ebp)
** r            -8(%ebp)
** c            -4(%ebp)
** matorder     20(%ebp)
** outmatdata   16(%ebp)
** inmatdata2   12(%ebp)
** inmatdata1   8(%ebp)
*/

matrix_multiply_asm:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        subl	$16, %esp        # On fait de la palce sur la pile pour c -4(%ebp), r -8(%ebp), i -12(%ebp) et elem -16(%ebp)
        movl	$0, -8(%ebp)    # Initialisation de r a 0
        jmp     condition1          # Sans condition on va a la condition 1

        for1:
                movl	$0, -4(%ebp)            # Intialisation de c a 0 a chaque iteration de la boucle for 1
                jmp	condition2                  # Sans condition on va a la boucle condition 2 

        for2:
                movl     $0, -16(%ebp)           # Initialisation d'elem a 0
                movl     $0, -12(%ebp)           # Initialisation de a 0 de i a chaque iteration de la boucle 2
                jmp     condition3              # Sans condition aller a condition3

        for3:
                movl	-8(%ebp), %eax          # Mettre r dans eax
                imull	20(%ebp), %eax          # Multiplier r et matorder
                movl	%eax, %edx              # Mettre r*matorder dans edx
                movl	-12(%ebp), %eax         # Mettre i dans eax
                addl	%edx, %eax              # On fait r*matorder + i
                leal	0(,%eax,4), %edx        # On cherche le contenu a l'adresse
                movl	8(%ebp), %eax           # On met inmatdata1 dans eax
                addl	%edx, %eax              # On ajoute a l'adresse de intmatdata le contenu de eax
                movl	(%eax), %edx            # On met edx (r*matorder+i) dans la memoire a l'adresse eax
                movl	-12(%ebp), %eax         # Mettre i dans eax     
                imull	20(%ebp), %eax          # Multriplier matorder et i
                movl	%eax, %ecx              # Mettre i*matorder dans ecx
                movl	-4(%ebp), %eax          # Mettre c dans eax
                addl	%ecx, %eax              # Faire i*matorder + c
                leal	0(,%eax,4), %ecx        # On cherchee le contenu d l'adresse
                
                movl	12(%ebp), %eax          # On met inmatdata2 dans eax
                addl	%ecx, %eax              # On ajoute ecx dans eax
                movl	(%eax), %eax            # On met edx (i*matorder+c) dans la memoire a l'adresse eax
                imull	%edx, %eax              # On multiplie inmatdata1[i + r * matorder] et inmatdata2[c + i * matorder]
                addl	%eax, -16(%ebp)         # On ajoute la multiplication a elem += ...
                addl	$1, -12(%ebp)           # Incrementation de i (+1)

        condition3:
                movl	-12(%ebp), %eax         # On met i dans eax
                cmpl	20(%ebp), %eax          # On compare matorder et i
                jnae	for3                    # Si i < matorder on va a for3 
                movl	-8(%ebp), %eax          # Sinon on conitnu ici; on met r dans eax
                imull	20(%ebp), %eax          # On multiplie r et matorder
                movl	%eax, %edx              # On met r*matorder dans edx
                movl	-4(%ebp), %eax          # On met c dans eax
                addl	%edx, %eax              # On fait r*matorder + c
                leal	0(,%eax,4), %edx        # On trouve le contenu a l'adresse et on met dans edx
                movl	16(%ebp), %eax          # On met outmatdata dans eax
                addl	%eax, %edx              # On ajoute outmatdata et r*matorder + c (pour avoir outmatdata[r*matorder +c])
                movl	-16(%ebp), %eax         # On met elem dans eax
                movl	%eax, (%edx)            # On met la valeur de elem dans la memoire a l'adrese edx (outmatdata[r*matorder + c])
                addl	$1, -4(%ebp)            # On incremente c de 1

        condition2:
        	movl	-4(%ebp), %eax          # On met c dans eax
                cmpl	20(%ebp), %eax          # On compare c et matorder
                jnae	for2                    # Si eax < 20(ebp) on fait un jump
                addl	$1, -8(%ebp)            # On increment r (si on fait pas de jump)                        

        condition1:
                movl	-8(%ebp), %eax          # On met r dans %eax
                cmpl	20(%ebp), %eax          # Comparaison de 20(ebp) (matorder) et eax (r)
                jnae	for1                    # Si eax < 20(ebp) on fait un jump

        fin:
                leave          /* restore ebp and esp */
                ret            /* return to the caller */
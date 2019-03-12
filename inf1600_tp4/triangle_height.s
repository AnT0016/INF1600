.globl	_ZNK9CTriangle9HeightAsmEv

_ZNK9CTriangle9HeightAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */

        movl	8(%ebp), %eax           # On met l'objet dans eax
	movl	(%eax), %eax            # On met l'adresse de l'objet dans eax
	addl	$16, %eax               # On ajout 16 a l'adresse pour avoir la fonction qu'on veut
	movl	(%eax), %eax            # On met l'adresse dans eax
        pushl	8(%ebp)                 # On met l'objet sur le stack                
	call	*%eax                   # On appelle la fonction sur l'objet

        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */

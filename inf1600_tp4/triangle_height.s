.globl	_ZNK9CTriangle9HeightAsmEv
.data
        constante2: .float 2.0

_ZNK9CTriangle9HeightAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */

        movl	8(%ebp), %eax           # On met l'objet dans eax
	movl	(%eax), %eax            # On met l'adresse de l'objet dans eax
	addl	$16, %eax               # On ajout 16 a l'adresse pour avoir la fonction qu'on veut
	movl	(%eax), %eax            # On met l'adresse dans eax
        pushl	8(%ebp)                 # On met l'objet sur le stack                
	call	*%eax                   # On appelle la fonction sur l'objet
        fstp    -4(%ebp)                # On met la valeur de retour (A) dans -4(ebp)
        fld     -4(%ebp)                # On remet la valeur (A) enregistree sur la pile 

        fld     12(%eax)                # On met mSides[2] sur la pile a s[0] et A a s[1]
        fdivrp                          # Division de s[1] (A) par s[0] (mSides[2])
        fld     constante2              # On a 2 a s[0] et le resultat de A/mSides[2] a s[1]
        fmulp                           # On multiplie 2 * A/ mSides[2]

        leave          /* restore ebp and esp */
        ret            /* return to the caller */

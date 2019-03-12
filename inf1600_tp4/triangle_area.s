.globl _ZNK9CTriangle7AreaAsmEv

.data
        constante2: .float 2.0

_ZNK9CTriangle7AreaAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */

        movl	8(%ebp), %eax                   # On met l'objet dans eax
	movl	(%eax), %eax                    # On met l'adresse de l'objet dans eax
	addl	$8, %eax                        # On ajout 8 a l'adresse pour avoir la fonction qu'on veut
	movl	(%eax), %eax                    # On met l'adresse dans eax
        pushl	8(%ebp)                         # On met l'objet sur le stack                
	call	*%eax                           # On appelle la fonction sur l'objet
       
        sub     $8, %esp                        # On fait de l'espace sur esp
        fld     constante2                      # On met 2 sur la pile a s[0] et resultat de perimetre a s[1]
        fdivrp                                  # Division de s[1] (perimetre) par s[1] (2.0)
        pop     %ecx                            # On met la valeur de p dans ecx  

        flds    4(%eax)                         # On met mSides[0] sur la pile a s[0]
        fsubrp                                  # s[1](p) - s[0](mSides[0])
        pop     %edx                            # On met p-mSides[0] dans edx

        flds    %ecx                            # On met p sur la pile

        leave          /* restore ebp and esp */
        ret            /* return to the caller */

        # fld -4(%ebp)
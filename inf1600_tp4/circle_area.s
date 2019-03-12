.globl _ZNK7CCircle7AreaAsmEv

_ZNK7CCircle7AreaAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */

        mov     8(%ebp), %eax           # On met l'objet cicle (qui est a 8ebp) dans eax
        flds    4(%eax)                 # On met mRadius sur la pile a s[0]
        flds    4(%eax)                 # On met mRadius sur la pile une deuxieme fois on l'a donc sur s[0] et s[1]
        fmulp                           # On multiplie mRadius par lui meme
        fldpi                           # On met pi sur la pile
        fmulp                           # On multiplie pi avec le resultat de mRadius*mRadius
        # Le result de la multiplcation est sur la pile c'est donc la valeur de retour
        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */
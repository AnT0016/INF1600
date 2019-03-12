.data
        factor: .float 2.0 /* use this to multiply by two */

.text
.globl _ZNK7CCircle12PerimeterAsmEv

_ZNK7CCircle12PerimeterAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */

        mov     8(%ebp), %eax           # On met l'objet cicle (qui est a 8ebp) dans eax
        flds    4(%eax)                 # On met mRadius sur la pile a s[0]
        flds    factor                  # On met factor sur la pile a s[0] et donc mRadius est a s[1]
        fmulp                           # On multiplie mRadius et 2
        fldpi                           # On met pi sur la pile
        fmulp                           # On multiplie pi avec le resultat de mRadius*2
        # Le result de la multiplcation est sur la pile c'est donc la valeur de retour
        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */
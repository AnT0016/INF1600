.globl _ZNK9CTriangle12PerimeterAsmEv

_ZNK9CTriangle12PerimeterAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        mov     8(%ebp), %eax           # On met l'objet triangle (qui est a 8ebp) dans eax
        flds    4(%eax)                 # On met mSides[0] sur la pile a s[0]
        flds    8(%eax)                 # On met mSides[1] sur la pile a s[0] et mSides[0] est donc a s[1]
        faddp                           # On additionne mSides[0] et mSides[1]
        flds    12(%eax)                # On met mSides[2] sur la pile a s[0] et le resultat de mSides[0]+mSides[1] est a s[1]
        faddp                           # Additionne les trois valeurs de mSides
        # Le result de l'addition est sur la pile c'est donc la valeur de retour
        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */


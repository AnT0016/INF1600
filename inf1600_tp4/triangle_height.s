.globl	_ZNK9CTriangle9HeightAsmEv

_ZNK9CTriangle9HeightAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        mov     8(%ebp), %eax           # On met le pointeur de l'objet triangle dans eax
        mov     (%eax), %eax            # On met l'adresse de eax dans eax
        call    *12(%eax)               # On appelle laa 4eme fonction virtuelle de triangle (areaCpp)

        leave          /* restore ebp and esp */
        ret            /* return to the caller */

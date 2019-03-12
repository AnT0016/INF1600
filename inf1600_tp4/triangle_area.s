.globl _ZNK9CTriangle7AreaAsmEv

.data
        p: .float 
        constante2: .float 2.0

_ZNK9CTriangle7AreaAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */

        sub $8, %esp                   # On cree de la place a -4(ebp)on met p, et -8(ebp) on met des valeurs intermeddiaires

	movl	8(%ebp), %eax           # On met l'objet dans eax
	movl	(%eax), %eax            # On met l'adresse de l'objet dans eax
	movl	8(%eax), %eax           # On ajoute 8 pour acceder a la fonction premietre
	# movl	(%eax), %eax    
	pushl	8(%ebp)                 # On met l'objet sur la pile 
	call	*%eax                   # On apelle la fonction perimetre sur l'objet
        fld     %st(0)                  # On met la valeur de retour sur le stack
	addl	$16, %esp

        ; fld     constante2                      # On met 2 sur la pile a s[0] et resultat de perimetre a s[1]
        ; fdivrp                                  # Division de s[1] (perimetre) par s[1] (2.0)
        
        ; fstp    -4(%ebp)                        # On met le resultat dans -4ebp
        ; flds    4(%eax)                         # On met mSides[0] sur la pile a s[0]
        ; fsubrp                                  # s[1](p) - s[0](mSides[0])
        ; fstp    -8(%ebp)                        # On met p-mSides[0] a -8(ebp)
        ; flds    -4(%ebp)                         # On met p sur la pile
        ; flds    8(%eax)                         # On met mSides[1] sur la pile a s[0] et p a s[1]
        ; fsubrp                                  # s[1](p) - s[0](mSides[1])
        ; flds    -8(%ebp)                        # On met p-mSides[0] sur la pile
        ; fmulp                                   # On multiplie s[0] (p-mSides[0]) avec s[1] (p-mSides[1])
        ; fstp    -8(%ebp)                        # On met le resultat de la multiplication dans ecx
        ; flds    -4(%ebp)                         # On met p sur la pile
        ; flds    12(%eax)                        # On met mSides[2] sur la pile a s[0] et p a s[1]
        ; fsubrp                                  # s[1](p) - s[0](mSides[2])
        ; flds    -8(%ebp)                        # On met p-mSides[0]*p-mSides[1] sur la pile
        ; fmulp                                   # On mutplie s[0] (p-mSides[0]*p-mSides[1]) et s[1] (p-mSides[2])
        ; flds    -4(%ebp)                         # On met p sur la pile 
        ; fmulp                                   # On multiplie s[0] (p) avec s[1] ((p-mSides[0]*p-mSides[1])*p-mSides[2])
        ; fsqrt                                   # On fait la racine de s[0] ( p*(p-mSides[0]*p-mSides[1])*p-mSides[2]) )
        ; # Le resultat est sur la pile c'est donc la valeur de retour
        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */

#include <stdio.h>
/*
+---+--------------------+
| r |    Register(s)     |
+---+--------------------+
| a |   %eax, %ax, %al   |
| b |   %ebx, %bx, %bl   |
| c |   %ecx, %cx, %cl   |
| d |   %edx, %dx, %dl   |
| S |   %esi, %si        |
| D |   %edi, %di        |
+---+--------------------+
*/

unsigned int Decryption_fctC(unsigned int le)
{
	return (le & 0xff000000) | (le&0xff) << 16  | (le & 0xff00) | (le & 0xff0000) >> 16;
}

unsigned int Decryption_fct(unsigned int le)
{
	unsigned int be = 0;
// On utilise asm volatile pour dire que le compilateur de ne pas toucher a ce bout de code
// pas d'optimization ni rien
	asm volatile (
		"movl	$0xff000000, 	%%ecx;  \n\t"	// On met 0xff000000 dans ecx
		"movl 	%1,				%%eax;  \n\t"	// On met la variable en parametre le dans eax 
		"and	%%eax, 			%%ecx;  \n\t"	// On fait le & 0xff000000 et on met dans ecx
		"movl	$0xff, 			%%edx;  \n\t"	// On met 0xff dans edx
		"and	%%eax, 			%%edx;  \n\t"	// le & 0xff et on met dans edx
		"shl	$16, 			%%edx;  \n\t"	// edx << 16 dans edx
		"or		%%edx,			%%ecx;  \n\t"	// le & 	0xff000000 | le&0xff << 16 dans ecx
		"movl 	$0xff00,		%%edx;  \n\t"	// On met 0xff00 dans edx
		"and	%%eax,			%%edx;  \n\t"	// le & 0xff00
		"or 	%%edx,			%%ecx;  \n\t"	// Contenu de ecx | le & 0xff00 dans edx resultat
		"mov 	$0xff0000,		%%edx;  \n\t"	// On met 0xff0000 dans edx
		"and 	%%eax,			%%edx;  \n\t"	// le & 0xff0000 dans edx
		"shr 	$16,			%%edx;  \n\t"	// edx >> 16 dans edx
		"or 	%%edx,			%%ecx;  \n\t"	// ecx | le & 0xff0000 >> 16 
		"movl 	%%ecx,			%0;     \n\t"	// On met ecx dans %0 le registre de retour	
												// On retourne ecx 
		: "=r"(be)								// be = %0 On dit a GCC c'est l'operande de sortie le = dit write only, 
													// r pour dire utiliser nimporte quel registre
													// = pour dire valeur de retour en write only
		: "r"(le)								// le = %1 le est le parametre recu en entree 
		: "%eax", "%ecx","%edx"  				// Specification des registres utilise pour dire a gcc de ne pas mettre 
													// dedant d'autres valeurs 
	);

	return be;
}

int main()
{
	unsigned int data = 0xeeaabbff;

// Debogage
	// printf("Valeur en C: %d\n", Decryption_fctC(data));
	// printf("Valeur en Assembleur: %d\n", Decryption_fct(data));

	printf("Représentation crypte en little-endian:   %08x\n"
	       "Représentation decrypte en big-endian:    %08x\n",
	       data,
	       Decryption_fct(data));

	return 0;
}

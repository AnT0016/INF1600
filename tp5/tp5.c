
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
		"movl %1, %0;"		// On met la variable en parametre le dans eax 
		"rol $8, %0;"		// On fait un rotate left de 8 bits
		"bswap %0;"			// Fonction deja existante, byteswap qui fait des masks sur les bits
								// en une seule operation
		: "=r"(be)			// be = %0 On dit a GCC c'est l'operande de sortie le = dit write only, 
							// r pour dire utiliser nimporte quel registre
							// = pour dire valeur de retour en write only
		: "r"(le)			// le = %1 le est le parametre recu en entree 
		:   				// Specification des registres utilise pour dire a gcc de ne pas mettre 
								// dedant d'autres valeurs (ici on n'a rien utilise)
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

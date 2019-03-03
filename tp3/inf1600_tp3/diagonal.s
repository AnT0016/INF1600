
.global matrix_diagonal_asm

val:
    .int 0x0


matrix_diagonal_asm:
        push %ebp      			/* Save old base pointer */
        mov %esp, %ebp 			/* Set ebp to current esp */

        ; mov 8(%ebp), %eax       # inmatdata
        ; mov 12(%ebp), %ebx      # outmatdata
        ; mov 16(%ebp), %ecx      # matorder
        ; mov %ecx, val           # Puisqu'on ne change jamais la valeur de matorder on la met dans une etiquette
        ; mov $0, %ecx            # variable r
        ; mov $0, %edi            # variable c

        ; push %eax
        ; call printf

        ; forCondition1:

		
        leave          			/* Restore ebp and esp */
        ret            			/* Return to the caller */
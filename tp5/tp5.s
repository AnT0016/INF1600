	.file	"tp5.c"
	.text
	.globl	Decryption_fctC
	.type	Decryption_fctC, @function
Decryption_fctC:
.LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movl	8(%ebp), %eax
	andl	$-16777216, %eax
	movl	%eax, %edx
	movl	8(%ebp), %eax
	sall	$16, %eax
	andl	$16711680, %eax
	orl	%eax, %edx
	movl	8(%ebp), %eax
	andl	$65280, %eax
	orl	%eax, %edx
	movl	8(%ebp), %eax
	shrl	$16, %eax
	movzbl	%al, %eax
	orl	%edx, %eax
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	Decryption_fctC, .-Decryption_fctC
	.globl	Decryption_fct
	.type	Decryption_fct, @function
Decryption_fct:
.LFB1:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$16, %esp
	.cfi_offset 3, -12
	movl	$0, -8(%ebp)
	movl	8(%ebp), %ebx
#APP
# 26 "tp5.c" 1
	movl	$0xff000000, 	%ecx;  
	movl 	%ebx,				%eax;  
	and	%eax, 			%ecx;  
	movl	$0xff, 			%edx;  
	and	%eax, 			%edx;  
	shl	$16, 			%edx;  
	or		%edx,			%ecx;  
	movl 	$0xff00,		%edx;  
	and	%eax,			%edx;  
	or 	%edx,			%ecx;  
	mov 	$0xff0000,		%edx;  
	and 	%eax,			%edx;  
	shr 	$16,			%edx;  
	or 	%edx,			%ecx;  
	movl 	%ecx,			%ebx;     
	
# 0 "" 2
#NO_APP
	movl	%ebx, -8(%ebp)
	movl	-8(%ebp), %eax
	addl	$16, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1:
	.size	Decryption_fct, .-Decryption_fct
	.section	.rodata
	.align 4
.LC0:
	.string	"Repr\303\251sentation crypte en little-endian:   %08x\nRepr\303\251sentation decrypte en big-endian:    %08x\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB2:
	.cfi_startproc
	leal	4(%esp), %ecx
	.cfi_def_cfa 1, 0
	andl	$-16, %esp
	pushl	-4(%ecx)
	pushl	%ebp
	.cfi_escape 0x10,0x5,0x2,0x75,0
	movl	%esp, %ebp
	pushl	%ecx
	.cfi_escape 0xf,0x3,0x75,0x7c,0x6
	subl	$20, %esp
	movl	$-290800641, -12(%ebp)
	pushl	-12(%ebp)
	call	Decryption_fct
	addl	$4, %esp
	subl	$4, %esp
	pushl	%eax
	pushl	-12(%ebp)
	pushl	$.LC0
	call	printf
	addl	$16, %esp
	movl	$0, %eax
	movl	-4(%ebp), %ecx
	.cfi_def_cfa 1, 0
	leave
	.cfi_restore 5
	leal	-4(%ecx), %esp
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE2:
	.size	main, .-main
	.ident	"GCC: (GNU) 8.2.1 20181215 (Red Hat 8.2.1-6)"
	.section	.note.GNU-stack,"",@progbits

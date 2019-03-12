
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$36, %esp
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	addl	$8, %eax
	movl	(%eax), %eax
	subl	$12, %esp
	pushl	8(%ebp)
	call	*%eax
	addl	$16, %esp
	fdivrp	%st, %st(1)
	fstps	-12(%ebp)
	movl	8(%ebp), %eax
	flds	4(%eax)
	flds	-12(%ebp)
	fsubp	%st, %st(1)
	fmuls	-12(%ebp)
	movl	8(%ebp), %eax
	flds	8(%eax)
	flds	-12(%ebp)
	fsubp	%st, %st(1)
	fmulp	%st, %st(1)
	movl	8(%ebp), %eax
	flds	12(%eax)
	flds	-12(%ebp)
	fsubp	%st, %st(1)
	fmulp	%st, %st(1)
	subl	$8, %esp
	leal	-8(%esp), %esp
	fstpl	(%esp)
	call	sqrt@PLT
	addl	$16, %esp
	fstps	-28(%ebp)
	flds	-28(%ebp)
	movl	-4(%ebp), %ebx


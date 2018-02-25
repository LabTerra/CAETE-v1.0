	.file	"funcs.f90"
	.text
	.globl	___photo_MOD_leap
	.def	___photo_MOD_leap;	.scl	2;	.type	32;	.endef
___photo_MOD_leap:
LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	andl	$3, %eax
	testl	%eax, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -4(%ebp)
	movl	8(%ebp), %eax
	movl	(%eax), %ecx
	movl	$1374389535, %edx
	movl	%ecx, %eax
	imull	%edx
	sarl	$5, %edx
	movl	%ecx, %eax
	sarl	$31, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	imull	$100, %eax, %eax
	subl	%eax, %ecx
	movl	%ecx, %eax
	testl	%eax, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -8(%ebp)
	movl	8(%ebp), %eax
	movl	(%eax), %ecx
	movl	$1374389535, %edx
	movl	%ecx, %eax
	imull	%edx
	sarl	$7, %edx
	movl	%ecx, %eax
	sarl	$31, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	imull	$400, %eax, %eax
	subl	%eax, %ecx
	movl	%ecx, %eax
	testl	%eax, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -12(%ebp)
	cmpl	$0, -4(%ebp)
	je	L2
	cmpl	$0, -12(%ebp)
	jne	L3
	movl	-8(%ebp), %eax
	xorl	$1, %eax
	testl	%eax, %eax
	je	L2
L3:
	movl	$1, %eax
	jmp	L4
L2:
	movl	$0, %eax
L4:
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE0:
	.def	___extendsftf2;	.scl	2;	.type	32;	.endef
	.def	___multf3;	.scl	2;	.type	32;	.endef
	.def	___addtf3;	.scl	2;	.type	32;	.endef
	.def	___subtf3;	.scl	2;	.type	32;	.endef
	.def	___trunctfsf2;	.scl	2;	.type	32;	.endef
	.def	___lttf2;	.scl	2;	.type	32;	.endef
	.globl	___photo_MOD_allocation
	.def	___photo_MOD_allocation;	.scl	2;	.type	32;	.endef
___photo_MOD_allocation:
LFB1:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$168, %esp
	movl	8(%ebp), %eax
	flds	8(%eax)
	fstps	-12(%ebp)
	movl	8(%ebp), %eax
	flds	12(%eax)
	fstps	-16(%ebp)
	movl	8(%ebp), %eax
	flds	16(%eax)
	fstps	-20(%ebp)
	movl	8(%ebp), %eax
	flds	20(%eax)
	fstps	-24(%ebp)
	movl	8(%ebp), %eax
	flds	24(%eax)
	fstps	-28(%ebp)
	movl	8(%ebp), %eax
	flds	28(%eax)
	fstps	-32(%ebp)
	movl	16(%ebp), %eax
	flds	(%eax)
	flds	LC0
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L7
	movl	24(%ebp), %eax
	flds	(%eax)
	flds	LC0
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L7
	movl	28(%ebp), %eax
	fldz
	fstps	(%eax)
	movl	36(%ebp), %eax
	fldz
	fstps	(%eax)
	movl	32(%ebp), %eax
	fldz
	fstps	(%eax)
	movl	40(%ebp), %eax
	movl	$1, (%eax)
	jmp	L10
L7:
	movl	40(%ebp), %eax
	movl	$0, (%eax)
	movl	12(%ebp), %eax
	flds	(%eax)
	flds	LC2
	fdivrp	%st, %st(1)
	leal	-72(%ebp), %eax
	fstps	4(%esp)
	movl	%eax, (%esp)
	call	___extendsftf2
	subl	$4, %esp
	movl	-72(%ebp), %eax
	movl	%eax, -88(%ebp)
	movl	-68(%ebp), %eax
	movl	%eax, -84(%ebp)
	movl	-64(%ebp), %eax
	movl	%eax, -80(%ebp)
	movl	-60(%ebp), %eax
	movl	%eax, -76(%ebp)
	movl	-88(%ebp), %eax
	movl	%eax, -56(%ebp)
	movl	-84(%ebp), %eax
	movl	%eax, -52(%ebp)
	movl	-80(%ebp), %eax
	movl	%eax, -48(%ebp)
	movl	-76(%ebp), %eax
	movl	%eax, -44(%ebp)
	movl	16(%ebp), %eax
	flds	(%eax)
	leal	-72(%ebp), %eax
	fstps	4(%esp)
	movl	%eax, (%esp)
	call	___extendsftf2
	subl	$4, %esp
	movl	-72(%ebp), %eax
	movl	%eax, -88(%ebp)
	movl	-68(%ebp), %eax
	movl	%eax, -84(%ebp)
	movl	-64(%ebp), %eax
	movl	%eax, -80(%ebp)
	movl	-60(%ebp), %eax
	movl	%eax, -76(%ebp)
	leal	-72(%ebp), %eax
	flds	-24(%ebp)
	fstps	4(%esp)
	movl	%eax, (%esp)
	call	___extendsftf2
	subl	$4, %esp
	movl	-72(%ebp), %eax
	movl	%eax, -104(%ebp)
	movl	-68(%ebp), %eax
	movl	%eax, -100(%ebp)
	movl	-64(%ebp), %eax
	movl	%eax, -96(%ebp)
	movl	-60(%ebp), %eax
	movl	%eax, -92(%ebp)
	leal	-72(%ebp), %eax
	movl	-56(%ebp), %edx
	movl	%edx, 32(%esp)
	movl	-52(%ebp), %edx
	movl	%edx, 36(%esp)
	movl	-48(%ebp), %edx
	movl	%edx, 40(%esp)
	movl	-44(%ebp), %edx
	movl	%edx, 44(%esp)
	movl	-104(%ebp), %ecx
	movl	%ecx, 16(%esp)
	movl	-100(%ebp), %ecx
	movl	%ecx, 20(%esp)
	movl	-96(%ebp), %ecx
	movl	%ecx, 24(%esp)
	movl	-92(%ebp), %ecx
	movl	%ecx, 28(%esp)
	movl	%eax, (%esp)
	call	___multf3
	subl	$4, %esp
	movl	-72(%ebp), %eax
	movl	%eax, -120(%ebp)
	movl	-68(%ebp), %eax
	movl	%eax, -116(%ebp)
	movl	-64(%ebp), %eax
	movl	%eax, -112(%ebp)
	movl	-60(%ebp), %eax
	movl	%eax, -108(%ebp)
	movl	-120(%ebp), %eax
	movl	%eax, -104(%ebp)
	movl	-116(%ebp), %eax
	movl	%eax, -100(%ebp)
	movl	-112(%ebp), %eax
	movl	%eax, -96(%ebp)
	movl	-108(%ebp), %eax
	movl	%eax, -92(%ebp)
	movl	-104(%ebp), %eax
	movl	%eax, -120(%ebp)
	movl	-100(%ebp), %eax
	movl	%eax, -116(%ebp)
	movl	-96(%ebp), %eax
	movl	%eax, -112(%ebp)
	movl	-92(%ebp), %eax
	movl	%eax, -108(%ebp)
	leal	-72(%ebp), %eax
	movl	-120(%ebp), %ecx
	movl	%ecx, 32(%esp)
	movl	-116(%ebp), %ecx
	movl	%ecx, 36(%esp)
	movl	-112(%ebp), %ecx
	movl	%ecx, 40(%esp)
	movl	-108(%ebp), %ecx
	movl	%ecx, 44(%esp)
	movl	-88(%ebp), %ecx
	movl	%ecx, 16(%esp)
	movl	-84(%ebp), %ecx
	movl	%ecx, 20(%esp)
	movl	-80(%ebp), %ecx
	movl	%ecx, 24(%esp)
	movl	-76(%ebp), %ecx
	movl	%ecx, 28(%esp)
	movl	%eax, (%esp)
	call	___addtf3
	subl	$4, %esp
	movl	-72(%ebp), %eax
	movl	%eax, -104(%ebp)
	movl	-68(%ebp), %eax
	movl	%eax, -100(%ebp)
	movl	-64(%ebp), %eax
	movl	%eax, -96(%ebp)
	movl	-60(%ebp), %eax
	movl	%eax, -92(%ebp)
	movl	-104(%ebp), %eax
	movl	%eax, -88(%ebp)
	movl	-100(%ebp), %eax
	movl	%eax, -84(%ebp)
	movl	-96(%ebp), %eax
	movl	%eax, -80(%ebp)
	movl	-92(%ebp), %eax
	movl	%eax, -76(%ebp)
	movl	16(%ebp), %eax
	flds	(%eax)
	flds	-12(%ebp)
	flds	LC2
	fmulp	%st, %st(1)
	fdivrp	%st, %st(1)
	leal	-72(%ebp), %eax
	fstps	4(%esp)
	movl	%eax, (%esp)
	call	___extendsftf2
	subl	$4, %esp
	movl	-72(%ebp), %eax
	movl	%eax, -104(%ebp)
	movl	-68(%ebp), %eax
	movl	%eax, -100(%ebp)
	movl	-64(%ebp), %eax
	movl	%eax, -96(%ebp)
	movl	-60(%ebp), %eax
	movl	%eax, -92(%ebp)
	leal	-72(%ebp), %eax
	movl	-104(%ebp), %ecx
	movl	%ecx, 32(%esp)
	movl	-100(%ebp), %ecx
	movl	%ecx, 36(%esp)
	movl	-96(%ebp), %ecx
	movl	%ecx, 40(%esp)
	movl	-92(%ebp), %edx
	movl	%edx, 44(%esp)
	movl	-88(%ebp), %ecx
	movl	%ecx, 16(%esp)
	movl	-84(%ebp), %edx
	movl	%edx, 20(%esp)
	movl	-80(%ebp), %ecx
	movl	%ecx, 24(%esp)
	movl	-76(%ebp), %edx
	movl	%edx, 28(%esp)
	movl	%eax, (%esp)
	call	___subtf3
	subl	$4, %esp
	movl	-72(%ebp), %eax
	movl	%eax, -104(%ebp)
	movl	-68(%ebp), %eax
	movl	%eax, -100(%ebp)
	movl	-64(%ebp), %eax
	movl	%eax, -96(%ebp)
	movl	-60(%ebp), %eax
	movl	%eax, -92(%ebp)
	movl	-104(%ebp), %eax
	movl	%eax, -88(%ebp)
	movl	-100(%ebp), %eax
	movl	%eax, -84(%ebp)
	movl	-96(%ebp), %eax
	movl	%eax, -80(%ebp)
	movl	-92(%ebp), %eax
	movl	%eax, -76(%ebp)
	movl	-88(%ebp), %eax
	movl	%eax, _scl2_128.3521
	movl	-84(%ebp), %eax
	movl	%eax, _scl2_128.3521+4
	movl	-80(%ebp), %eax
	movl	%eax, _scl2_128.3521+8
	movl	-76(%ebp), %eax
	movl	%eax, _scl2_128.3521+12
	movl	24(%ebp), %eax
	flds	(%eax)
	leal	-72(%ebp), %eax
	fstps	4(%esp)
	movl	%eax, (%esp)
	call	___extendsftf2
	subl	$4, %esp
	movl	-72(%ebp), %eax
	movl	%eax, -88(%ebp)
	movl	-68(%ebp), %eax
	movl	%eax, -84(%ebp)
	movl	-64(%ebp), %eax
	movl	%eax, -80(%ebp)
	movl	-60(%ebp), %eax
	movl	%eax, -76(%ebp)
	leal	-72(%ebp), %eax
	flds	-32(%ebp)
	fstps	4(%esp)
	movl	%eax, (%esp)
	call	___extendsftf2
	subl	$4, %esp
	movl	-72(%ebp), %eax
	movl	%eax, -104(%ebp)
	movl	-68(%ebp), %eax
	movl	%eax, -100(%ebp)
	movl	-64(%ebp), %eax
	movl	%eax, -96(%ebp)
	movl	-60(%ebp), %eax
	movl	%eax, -92(%ebp)
	leal	-72(%ebp), %eax
	movl	-56(%ebp), %edx
	movl	%edx, 32(%esp)
	movl	-52(%ebp), %edx
	movl	%edx, 36(%esp)
	movl	-48(%ebp), %edx
	movl	%edx, 40(%esp)
	movl	-44(%ebp), %edx
	movl	%edx, 44(%esp)
	movl	-104(%ebp), %ecx
	movl	%ecx, 16(%esp)
	movl	-100(%ebp), %edx
	movl	%edx, 20(%esp)
	movl	-96(%ebp), %ecx
	movl	%ecx, 24(%esp)
	movl	-92(%ebp), %edx
	movl	%edx, 28(%esp)
	movl	%eax, (%esp)
	call	___multf3
	subl	$4, %esp
	movl	-72(%ebp), %eax
	movl	%eax, -120(%ebp)
	movl	-68(%ebp), %eax
	movl	%eax, -116(%ebp)
	movl	-64(%ebp), %eax
	movl	%eax, -112(%ebp)
	movl	-60(%ebp), %eax
	movl	%eax, -108(%ebp)
	movl	-120(%ebp), %eax
	movl	%eax, -104(%ebp)
	movl	-116(%ebp), %eax
	movl	%eax, -100(%ebp)
	movl	-112(%ebp), %eax
	movl	%eax, -96(%ebp)
	movl	-108(%ebp), %eax
	movl	%eax, -92(%ebp)
	movl	-104(%ebp), %eax
	movl	%eax, -120(%ebp)
	movl	-100(%ebp), %eax
	movl	%eax, -116(%ebp)
	movl	-96(%ebp), %eax
	movl	%eax, -112(%ebp)
	movl	-92(%ebp), %eax
	movl	%eax, -108(%ebp)
	leal	-72(%ebp), %eax
	movl	-120(%ebp), %ecx
	movl	%ecx, 32(%esp)
	movl	-116(%ebp), %edx
	movl	%edx, 36(%esp)
	movl	-112(%ebp), %ecx
	movl	%ecx, 40(%esp)
	movl	-108(%ebp), %edx
	movl	%edx, 44(%esp)
	movl	-88(%ebp), %ecx
	movl	%ecx, 16(%esp)
	movl	-84(%ebp), %edx
	movl	%edx, 20(%esp)
	movl	-80(%ebp), %ecx
	movl	%ecx, 24(%esp)
	movl	-76(%ebp), %edx
	movl	%edx, 28(%esp)
	movl	%eax, (%esp)
	call	___addtf3
	subl	$4, %esp
	movl	-72(%ebp), %eax
	movl	%eax, -104(%ebp)
	movl	-68(%ebp), %eax
	movl	%eax, -100(%ebp)
	movl	-64(%ebp), %eax
	movl	%eax, -96(%ebp)
	movl	-60(%ebp), %eax
	movl	%eax, -92(%ebp)
	movl	-104(%ebp), %eax
	movl	%eax, -88(%ebp)
	movl	-100(%ebp), %eax
	movl	%eax, -84(%ebp)
	movl	-96(%ebp), %eax
	movl	%eax, -80(%ebp)
	movl	-92(%ebp), %eax
	movl	%eax, -76(%ebp)
	movl	24(%ebp), %eax
	flds	(%eax)
	flds	-20(%ebp)
	flds	LC2
	fmulp	%st, %st(1)
	fdivrp	%st, %st(1)
	leal	-72(%ebp), %eax
	fstps	4(%esp)
	movl	%eax, (%esp)
	call	___extendsftf2
	subl	$4, %esp
	movl	-72(%ebp), %eax
	movl	%eax, -104(%ebp)
	movl	-68(%ebp), %eax
	movl	%eax, -100(%ebp)
	movl	-64(%ebp), %eax
	movl	%eax, -96(%ebp)
	movl	-60(%ebp), %eax
	movl	%eax, -92(%ebp)
	leal	-72(%ebp), %eax
	movl	-104(%ebp), %ecx
	movl	%ecx, 32(%esp)
	movl	-100(%ebp), %edx
	movl	%edx, 36(%esp)
	movl	-96(%ebp), %ecx
	movl	%ecx, 40(%esp)
	movl	-92(%ebp), %edx
	movl	%edx, 44(%esp)
	movl	-88(%ebp), %ecx
	movl	%ecx, 16(%esp)
	movl	-84(%ebp), %edx
	movl	%edx, 20(%esp)
	movl	-80(%ebp), %ecx
	movl	%ecx, 24(%esp)
	movl	-76(%ebp), %edx
	movl	%edx, 28(%esp)
	movl	%eax, (%esp)
	call	___subtf3
	subl	$4, %esp
	movl	-72(%ebp), %eax
	movl	%eax, -104(%ebp)
	movl	-68(%ebp), %eax
	movl	%eax, -100(%ebp)
	movl	-64(%ebp), %eax
	movl	%eax, -96(%ebp)
	movl	-60(%ebp), %eax
	movl	%eax, -92(%ebp)
	movl	-104(%ebp), %eax
	movl	%eax, -88(%ebp)
	movl	-100(%ebp), %eax
	movl	%eax, -84(%ebp)
	movl	-96(%ebp), %eax
	movl	%eax, -80(%ebp)
	movl	-92(%ebp), %eax
	movl	%eax, -76(%ebp)
	movl	-88(%ebp), %eax
	movl	%eax, _scf2_128.3520
	movl	-84(%ebp), %eax
	movl	%eax, _scf2_128.3520+4
	movl	-80(%ebp), %eax
	movl	%eax, _scf2_128.3520+8
	movl	-76(%ebp), %eax
	movl	%eax, _scf2_128.3520+12
	flds	-28(%ebp)
	fldz
	fxch	%st(1)
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L31
	movl	20(%ebp), %eax
	flds	(%eax)
	leal	-72(%ebp), %eax
	fstps	4(%esp)
	movl	%eax, (%esp)
	call	___extendsftf2
	subl	$4, %esp
	movl	-72(%ebp), %eax
	movl	%eax, -88(%ebp)
	movl	-68(%ebp), %eax
	movl	%eax, -84(%ebp)
	movl	-64(%ebp), %eax
	movl	%eax, -80(%ebp)
	movl	-60(%ebp), %eax
	movl	%eax, -76(%ebp)
	leal	-72(%ebp), %eax
	flds	-28(%ebp)
	fstps	4(%esp)
	movl	%eax, (%esp)
	call	___extendsftf2
	subl	$4, %esp
	movl	-72(%ebp), %eax
	movl	%eax, -104(%ebp)
	movl	-68(%ebp), %eax
	movl	%eax, -100(%ebp)
	movl	-64(%ebp), %eax
	movl	%eax, -96(%ebp)
	movl	-60(%ebp), %eax
	movl	%eax, -92(%ebp)
	leal	-72(%ebp), %eax
	movl	-56(%ebp), %edx
	movl	%edx, 32(%esp)
	movl	-52(%ebp), %edx
	movl	%edx, 36(%esp)
	movl	-48(%ebp), %edx
	movl	%edx, 40(%esp)
	movl	-44(%ebp), %edx
	movl	%edx, 44(%esp)
	movl	-104(%ebp), %ecx
	movl	%ecx, 16(%esp)
	movl	-100(%ebp), %edx
	movl	%edx, 20(%esp)
	movl	-96(%ebp), %ecx
	movl	%ecx, 24(%esp)
	movl	-92(%ebp), %edx
	movl	%edx, 28(%esp)
	movl	%eax, (%esp)
	call	___multf3
	subl	$4, %esp
	movl	-72(%ebp), %eax
	movl	%eax, -120(%ebp)
	movl	-68(%ebp), %eax
	movl	%eax, -116(%ebp)
	movl	-64(%ebp), %eax
	movl	%eax, -112(%ebp)
	movl	-60(%ebp), %eax
	movl	%eax, -108(%ebp)
	movl	-120(%ebp), %eax
	movl	%eax, -104(%ebp)
	movl	-116(%ebp), %eax
	movl	%eax, -100(%ebp)
	movl	-112(%ebp), %eax
	movl	%eax, -96(%ebp)
	movl	-108(%ebp), %eax
	movl	%eax, -92(%ebp)
	movl	-104(%ebp), %eax
	movl	%eax, -120(%ebp)
	movl	-100(%ebp), %eax
	movl	%eax, -116(%ebp)
	movl	-96(%ebp), %eax
	movl	%eax, -112(%ebp)
	movl	-92(%ebp), %eax
	movl	%eax, -108(%ebp)
	leal	-72(%ebp), %eax
	movl	-120(%ebp), %ecx
	movl	%ecx, 32(%esp)
	movl	-116(%ebp), %edx
	movl	%edx, 36(%esp)
	movl	-112(%ebp), %ecx
	movl	%ecx, 40(%esp)
	movl	-108(%ebp), %edx
	movl	%edx, 44(%esp)
	movl	-88(%ebp), %ecx
	movl	%ecx, 16(%esp)
	movl	-84(%ebp), %edx
	movl	%edx, 20(%esp)
	movl	-80(%ebp), %ecx
	movl	%ecx, 24(%esp)
	movl	-76(%ebp), %edx
	movl	%edx, 28(%esp)
	movl	%eax, (%esp)
	call	___addtf3
	subl	$4, %esp
	movl	-72(%ebp), %eax
	movl	%eax, -104(%ebp)
	movl	-68(%ebp), %eax
	movl	%eax, -100(%ebp)
	movl	-64(%ebp), %eax
	movl	%eax, -96(%ebp)
	movl	-60(%ebp), %eax
	movl	%eax, -92(%ebp)
	movl	-104(%ebp), %eax
	movl	%eax, -88(%ebp)
	movl	-100(%ebp), %eax
	movl	%eax, -84(%ebp)
	movl	-96(%ebp), %eax
	movl	%eax, -80(%ebp)
	movl	-92(%ebp), %eax
	movl	%eax, -76(%ebp)
	movl	20(%ebp), %eax
	flds	(%eax)
	flds	-16(%ebp)
	flds	LC2
	fmulp	%st, %st(1)
	fdivrp	%st, %st(1)
	leal	-72(%ebp), %eax
	fstps	4(%esp)
	movl	%eax, (%esp)
	call	___extendsftf2
	subl	$4, %esp
	movl	-72(%ebp), %eax
	movl	%eax, -104(%ebp)
	movl	-68(%ebp), %eax
	movl	%eax, -100(%ebp)
	movl	-64(%ebp), %eax
	movl	%eax, -96(%ebp)
	movl	-60(%ebp), %eax
	movl	%eax, -92(%ebp)
	leal	-72(%ebp), %eax
	movl	-104(%ebp), %ecx
	movl	%ecx, 32(%esp)
	movl	-100(%ebp), %edx
	movl	%edx, 36(%esp)
	movl	-96(%ebp), %ecx
	movl	%ecx, 40(%esp)
	movl	-92(%ebp), %edx
	movl	%edx, 44(%esp)
	movl	-88(%ebp), %ecx
	movl	%ecx, 16(%esp)
	movl	-84(%ebp), %edx
	movl	%edx, 20(%esp)
	movl	-80(%ebp), %ecx
	movl	%ecx, 24(%esp)
	movl	-76(%ebp), %edx
	movl	%edx, 28(%esp)
	movl	%eax, (%esp)
	call	___subtf3
	subl	$4, %esp
	movl	-72(%ebp), %eax
	movl	%eax, -104(%ebp)
	movl	-68(%ebp), %eax
	movl	%eax, -100(%ebp)
	movl	-64(%ebp), %eax
	movl	%eax, -96(%ebp)
	movl	-60(%ebp), %eax
	movl	%eax, -92(%ebp)
	movl	-104(%ebp), %eax
	movl	%eax, -88(%ebp)
	movl	-100(%ebp), %eax
	movl	%eax, -84(%ebp)
	movl	-96(%ebp), %eax
	movl	%eax, -80(%ebp)
	movl	-92(%ebp), %eax
	movl	%eax, -76(%ebp)
	movl	-88(%ebp), %eax
	movl	%eax, _sca2_128.3519
	movl	-84(%ebp), %eax
	movl	%eax, _sca2_128.3519+4
	movl	-80(%ebp), %eax
	movl	%eax, _sca2_128.3519+8
	movl	-76(%ebp), %eax
	movl	%eax, _sca2_128.3519+12
	movl	_sca2_128.3519, %eax
	movl	%eax, -88(%ebp)
	movl	_sca2_128.3519+4, %eax
	movl	%eax, -84(%ebp)
	movl	_sca2_128.3519+8, %eax
	movl	%eax, -80(%ebp)
	movl	_sca2_128.3519+12, %eax
	movl	%eax, -76(%ebp)
	movl	-88(%ebp), %eax
	movl	%eax, (%esp)
	movl	-84(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-80(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	-76(%ebp), %eax
	movl	%eax, 12(%esp)
	call	___trunctfsf2
	fstps	-88(%ebp)
	movl	-88(%ebp), %edx
	movl	32(%ebp), %eax
	movl	%edx, (%eax)
	jmp	L13
L31:
	movl	32(%ebp), %eax
	fldz
	fstps	(%eax)
L13:
	movl	_scf2_128.3520, %eax
	movl	%eax, -88(%ebp)
	movl	_scf2_128.3520+4, %eax
	movl	%eax, -84(%ebp)
	movl	_scf2_128.3520+8, %eax
	movl	%eax, -80(%ebp)
	movl	_scf2_128.3520+12, %eax
	movl	%eax, -76(%ebp)
	movl	-88(%ebp), %eax
	movl	%eax, (%esp)
	movl	-84(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-80(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	-76(%ebp), %eax
	movl	%eax, 12(%esp)
	call	___trunctfsf2
	fstps	-88(%ebp)
	movl	-88(%ebp), %edx
	movl	36(%ebp), %eax
	movl	%edx, (%eax)
	movl	_scl2_128.3521, %eax
	movl	%eax, -88(%ebp)
	movl	_scl2_128.3521+4, %eax
	movl	%eax, -84(%ebp)
	movl	_scl2_128.3521+8, %eax
	movl	%eax, -80(%ebp)
	movl	_scl2_128.3521+12, %eax
	movl	%eax, -76(%ebp)
	movl	-88(%ebp), %eax
	movl	%eax, (%esp)
	movl	-84(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-80(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	-76(%ebp), %eax
	movl	%eax, 12(%esp)
	call	___trunctfsf2
	fstps	-88(%ebp)
	movl	-88(%ebp), %edx
	movl	28(%ebp), %eax
	movl	%edx, (%eax)
	movl	_scl2_128.3521, %eax
	movl	%eax, -88(%ebp)
	movl	_scl2_128.3521+4, %eax
	movl	%eax, -84(%ebp)
	movl	_scl2_128.3521+8, %eax
	movl	%eax, -80(%ebp)
	movl	_scl2_128.3521+12, %eax
	movl	%eax, -76(%ebp)
	movl	$0, 16(%esp)
	movl	$0, 20(%esp)
	movl	$-1744830464, 24(%esp)
	movl	$1071061369, 28(%esp)
	movl	-88(%ebp), %eax
	movl	%eax, (%esp)
	movl	-84(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-80(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	-76(%ebp), %eax
	movl	%eax, 12(%esp)
	call	___lttf2
	testl	%eax, %eax
	jns	L14
	movl	28(%ebp), %eax
	fldz
	fstps	(%eax)
L14:
	movl	_scf2_128.3520, %eax
	movl	%eax, -88(%ebp)
	movl	_scf2_128.3520+4, %eax
	movl	%eax, -84(%ebp)
	movl	_scf2_128.3520+8, %eax
	movl	%eax, -80(%ebp)
	movl	_scf2_128.3520+12, %eax
	movl	%eax, -76(%ebp)
	movl	$0, 16(%esp)
	movl	$0, 20(%esp)
	movl	$-1744830464, 24(%esp)
	movl	$1071061369, 28(%esp)
	movl	-88(%ebp), %eax
	movl	%eax, (%esp)
	movl	-84(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-80(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	-76(%ebp), %eax
	movl	%eax, 12(%esp)
	call	___lttf2
	testl	%eax, %eax
	jns	L16
	movl	36(%ebp), %eax
	fldz
	fstps	(%eax)
L16:
	movl	_sca2_128.3519, %eax
	movl	%eax, -88(%ebp)
	movl	_sca2_128.3519+4, %eax
	movl	%eax, -84(%ebp)
	movl	_sca2_128.3519+8, %eax
	movl	%eax, -80(%ebp)
	movl	_sca2_128.3519+12, %eax
	movl	%eax, -76(%ebp)
	movl	$0, 16(%esp)
	movl	$0, 20(%esp)
	movl	$-1744830464, 24(%esp)
	movl	$1071061369, 28(%esp)
	movl	-88(%ebp), %eax
	movl	%eax, (%esp)
	movl	-84(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-80(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	-76(%ebp), %eax
	movl	%eax, 12(%esp)
	call	___lttf2
	testl	%eax, %eax
	jns	L18
	movl	32(%ebp), %eax
	fldz
	fstps	(%eax)
L18:
	movl	28(%ebp), %eax
	flds	(%eax)
	fldz
	fucomip	%st(1), %st
	fstp	%st(0)
	jnb	L29
	jmp	L6
L29:
	movl	36(%ebp), %eax
	flds	(%eax)
	fldz
	fucomip	%st(1), %st
	fstp	%st(0)
	jnb	L30
	jmp	L6
L30:
	movl	40(%ebp), %eax
	movl	$1, (%eax)
L10:
	nop
L6:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE1:
	.section .rdata,"dr"
	.align 4
LC4:
	.ascii "Integer overflow when calculating the amount of memory to allocate\0"
LC5:
	.ascii "arr_in\0"
	.align 4
LC6:
	.ascii "Attempting to allocate already allocated variable '%s'\0"
	.align 4
LC7:
	.ascii "At line 1107 of file funcs.f90\0"
	.align 4
LC8:
	.ascii "Allocation would exceed memory limit\0"
LC9:
	.ascii "funcs.f90\0"
LC10:
	.ascii "old"
LC11:
	.ascii "sequential"
LC12:
	.ascii "formatted"
LC13:
	.ascii "read"
LC14:
	.ascii "unknown"
LC15:
	.ascii "direct"
LC16:
	.ascii "unformatted"
	.text
	.globl	___photo_MOD_ascii2bin2
	.def	___photo_MOD_ascii2bin2;	.scl	2;	.type	32;	.endef
___photo_MOD_ascii2bin2:
LFB2:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$428, %esp
	.cfi_offset 7, -12
	.cfi_offset 6, -16
	.cfi_offset 3, -20
	movl	$0, -68(%ebp)
	movl	16(%ebp), %eax
	movl	(%eax), %eax
	movl	$0, %edx
	testl	%eax, %eax
	movl	%edx, %ebx
	cmovns	%eax, %ebx
	testl	%ebx, %ebx
	je	L33
	movl	$2147483647, %eax
	cltd
	idivl	%ebx
	testl	%eax, %eax
	jg	L34
	movl	$1, %esi
	jmp	L36
L34:
	movl	$0, %esi
	jmp	L36
L33:
	movl	$0, %esi
L36:
	movl	20(%ebp), %eax
	movl	(%eax), %eax
	movl	$0, %edx
	testl	%eax, %eax
	movl	%edx, %ecx
	cmovns	%eax, %ecx
	testl	%ecx, %ecx
	je	L37
	movl	$2147483647, %eax
	cltd
	idivl	%ecx
	cmpl	%ebx, %eax
	jge	L38
	movl	$1, %eax
	jmp	L40
L38:
	movl	$0, %eax
	jmp	L40
L37:
	movl	$0, %eax
L40:
	leal	(%eax,%esi), %edx
	movl	%ecx, %eax
	imull	%ebx, %eax
	movl	%eax, %ecx
	cmpl	$1073741823, %ecx
	jbe	L41
	movl	$1, %ecx
	jmp	L42
L41:
	movl	$0, %ecx
L42:
	addl	%edx, %ecx
	movl	%ebx, %esi
	notl	%esi
	movl	16(%ebp), %edx
	movl	(%edx), %edx
	testl	%edx, %edx
	setle	%dl
	movzbl	%dl, %edi
	movl	20(%ebp), %edx
	movl	(%edx), %edx
	testl	%edx, %edx
	setle	%dl
	movzbl	%dl, %edx
	orl	%edi, %edx
	testl	%edx, %edx
	je	L43
	movl	$0, %eax
	jmp	L44
L43:
	sall	$2, %eax
L44:
	testl	%ecx, %ecx
	je	L45
	movl	$LC4, (%esp)
	call	__gfortran_runtime_error
L45:
	movl	-68(%ebp), %edx
	testl	%edx, %edx
	je	L46
	movl	$LC5, 8(%esp)
	movl	$LC6, 4(%esp)
	movl	$LC7, (%esp)
	call	__gfortran_runtime_error_at
L46:
	movl	$1, %edx
	testl	%eax, %eax
	cmove	%edx, %eax
	movl	%eax, (%esp)
	call	_malloc
	movl	%eax, -68(%ebp)
	movl	-68(%ebp), %eax
	testl	%eax, %eax
	jne	L47
	movl	$LC8, (%esp)
	call	__gfortran_os_error
L47:
	movl	$282, -60(%ebp)
	movl	$1, -52(%ebp)
	movl	16(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -48(%ebp)
	movl	$1, -56(%ebp)
	movl	$1, -40(%ebp)
	movl	20(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -36(%ebp)
	movl	%ebx, -44(%ebp)
	movl	%esi, -64(%ebp)
	movl	$LC9, -416(%ebp)
	movl	$1110, -412(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, -388(%ebp)
	movl	$100, -392(%ebp)
	movl	$LC10, -384(%ebp)
	movl	$3, -380(%ebp)
	movl	$LC11, -372(%ebp)
	movl	$10, -376(%ebp)
	movl	$LC12, -368(%ebp)
	movl	$9, -364(%ebp)
	movl	$LC13, -340(%ebp)
	movl	$4, -344(%ebp)
	movl	$20224, -424(%ebp)
	movl	$11, -420(%ebp)
	leal	-424(%ebp), %eax
	movl	%eax, (%esp)
	call	__gfortran_st_open
	movl	$LC9, -416(%ebp)
	movl	$1114, -412(%ebp)
	movl	12(%ebp), %eax
	movl	%eax, -388(%ebp)
	movl	$100, -392(%ebp)
	movl	$LC14, -384(%ebp)
	movl	$7, -380(%ebp)
	movl	$LC15, -372(%ebp)
	movl	$6, -376(%ebp)
	movl	$LC16, -368(%ebp)
	movl	$11, -364(%ebp)
	movl	20(%ebp), %eax
	movl	(%eax), %edx
	movl	16(%ebp), %eax
	movl	(%eax), %eax
	imull	%edx, %eax
	sall	$2, %eax
	movl	%eax, -396(%ebp)
	movl	$3968, -424(%ebp)
	movl	$21, -420(%ebp)
	leal	-424(%ebp), %eax
	movl	%eax, (%esp)
	call	__gfortran_st_open
	movl	16(%ebp), %eax
	movl	(%eax), %ebx
	movl	$1, -32(%ebp)
	cmpl	%ebx, -32(%ebp)
	jg	L48
L51:
	movl	$LC9, -416(%ebp)
	movl	$1118, -412(%ebp)
	movl	$128, -424(%ebp)
	movl	$11, -420(%ebp)
	leal	-424(%ebp), %eax
	movl	%eax, (%esp)
	call	__gfortran_st_read
	movl	20(%ebp), %eax
	movl	(%eax), %esi
	movl	$1, -28(%ebp)
	cmpl	%esi, -28(%ebp)
	jg	L49
L50:
	movl	-68(%ebp), %edx
	movl	-64(%ebp), %ecx
	movl	-44(%ebp), %eax
	imull	-32(%ebp), %eax
	addl	%eax, %ecx
	movl	-28(%ebp), %eax
	addl	%ecx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	movl	$4, 8(%esp)
	movl	%eax, 4(%esp)
	leal	-424(%ebp), %eax
	movl	%eax, (%esp)
	call	__gfortran_transfer_real
	movl	-424(%ebp), %eax
	andl	$3, %eax
	andl	$1, %eax
	testl	%eax, %eax
	jne	L49
	cmpl	%esi, -28(%ebp)
	sete	%al
	movzbl	%al, %eax
	addl	$1, -28(%ebp)
	testl	%eax, %eax
	jne	L49
	jmp	L50
L49:
	leal	-424(%ebp), %eax
	movl	%eax, (%esp)
	call	__gfortran_st_read_done
	cmpl	%ebx, -32(%ebp)
	sete	%al
	movzbl	%al, %eax
	addl	$1, -32(%ebp)
	testl	%eax, %eax
	jne	L48
	jmp	L51
L48:
	movl	$LC9, -416(%ebp)
	movl	$1122, -412(%ebp)
	movl	$1, -392(%ebp)
	movl	$0, -388(%ebp)
	movl	$512, -424(%ebp)
	movl	$21, -420(%ebp)
	leal	-424(%ebp), %eax
	movl	%eax, (%esp)
	call	__gfortran_st_write
	movl	$0, 12(%esp)
	movl	$4, 8(%esp)
	leal	-68(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-424(%ebp), %eax
	movl	%eax, (%esp)
	call	__gfortran_transfer_array_write
	leal	-424(%ebp), %eax
	movl	%eax, (%esp)
	call	__gfortran_st_write_done
	movl	$LC9, -416(%ebp)
	movl	$1123, -412(%ebp)
	movl	$0, -424(%ebp)
	movl	$11, -420(%ebp)
	leal	-424(%ebp), %eax
	movl	%eax, (%esp)
	call	__gfortran_st_close
	movl	$LC9, -416(%ebp)
	movl	$1124, -412(%ebp)
	movl	$0, -424(%ebp)
	movl	$21, -420(%ebp)
	leal	-424(%ebp), %eax
	movl	%eax, (%esp)
	call	__gfortran_st_close
	movl	-68(%ebp), %eax
	testl	%eax, %eax
	je	L52
	movl	-68(%ebp), %eax
	movl	%eax, (%esp)
	call	_free
L52:
	movl	$0, -68(%ebp)
	addl	$428, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%edi
	.cfi_restore 7
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2:
	.section .rdata,"dr"
	.align 4
LC17:
	.ascii "At line 1072 of file funcs.f90\0"
	.text
	.globl	___photo_MOD_ascii2bin
	.def	___photo_MOD_ascii2bin;	.scl	2;	.type	32;	.endef
___photo_MOD_ascii2bin:
LFB3:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$428, %esp
	.cfi_offset 7, -12
	.cfi_offset 6, -16
	.cfi_offset 3, -20
	movl	$0, -68(%ebp)
	movl	16(%ebp), %eax
	movl	(%eax), %eax
	movl	$0, %edx
	testl	%eax, %eax
	movl	%edx, %ebx
	cmovns	%eax, %ebx
	testl	%ebx, %ebx
	je	L54
	movl	$2147483647, %eax
	cltd
	idivl	%ebx
	testl	%eax, %eax
	jg	L55
	movl	$1, %esi
	jmp	L57
L55:
	movl	$0, %esi
	jmp	L57
L54:
	movl	$0, %esi
L57:
	movl	20(%ebp), %eax
	movl	(%eax), %eax
	movl	$0, %edx
	testl	%eax, %eax
	movl	%edx, %ecx
	cmovns	%eax, %ecx
	testl	%ecx, %ecx
	je	L58
	movl	$2147483647, %eax
	cltd
	idivl	%ecx
	cmpl	%ebx, %eax
	jge	L59
	movl	$1, %eax
	jmp	L61
L59:
	movl	$0, %eax
	jmp	L61
L58:
	movl	$0, %eax
L61:
	leal	(%eax,%esi), %edx
	movl	%ecx, %eax
	imull	%ebx, %eax
	movl	%eax, %ecx
	cmpl	$1073741823, %ecx
	jbe	L62
	movl	$1, %ecx
	jmp	L63
L62:
	movl	$0, %ecx
L63:
	addl	%edx, %ecx
	movl	%ebx, %esi
	notl	%esi
	movl	16(%ebp), %edx
	movl	(%edx), %edx
	testl	%edx, %edx
	setle	%dl
	movzbl	%dl, %edi
	movl	20(%ebp), %edx
	movl	(%edx), %edx
	testl	%edx, %edx
	setle	%dl
	movzbl	%dl, %edx
	orl	%edi, %edx
	testl	%edx, %edx
	je	L64
	movl	$0, %eax
	jmp	L65
L64:
	sall	$2, %eax
L65:
	testl	%ecx, %ecx
	je	L66
	movl	$LC4, (%esp)
	call	__gfortran_runtime_error
L66:
	movl	-68(%ebp), %edx
	testl	%edx, %edx
	je	L67
	movl	$LC5, 8(%esp)
	movl	$LC6, 4(%esp)
	movl	$LC17, (%esp)
	call	__gfortran_runtime_error_at
L67:
	movl	$1, %edx
	testl	%eax, %eax
	cmove	%edx, %eax
	movl	%eax, (%esp)
	call	_malloc
	movl	%eax, -68(%ebp)
	movl	-68(%ebp), %eax
	testl	%eax, %eax
	jne	L68
	movl	$LC8, (%esp)
	call	__gfortran_os_error
L68:
	movl	$282, -60(%ebp)
	movl	$1, -52(%ebp)
	movl	16(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -48(%ebp)
	movl	$1, -56(%ebp)
	movl	$1, -40(%ebp)
	movl	20(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -36(%ebp)
	movl	%ebx, -44(%ebp)
	movl	%esi, -64(%ebp)
	movl	$LC9, -416(%ebp)
	movl	$1075, -412(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, -388(%ebp)
	movl	$100, -392(%ebp)
	movl	$LC10, -384(%ebp)
	movl	$3, -380(%ebp)
	movl	$LC11, -372(%ebp)
	movl	$10, -376(%ebp)
	movl	$LC12, -368(%ebp)
	movl	$9, -364(%ebp)
	movl	$LC13, -340(%ebp)
	movl	$4, -344(%ebp)
	movl	$20224, -424(%ebp)
	movl	$11, -420(%ebp)
	leal	-424(%ebp), %eax
	movl	%eax, (%esp)
	call	__gfortran_st_open
	movl	$LC9, -416(%ebp)
	movl	$1079, -412(%ebp)
	movl	12(%ebp), %eax
	movl	%eax, -388(%ebp)
	movl	$100, -392(%ebp)
	movl	$LC14, -384(%ebp)
	movl	$7, -380(%ebp)
	movl	$LC15, -372(%ebp)
	movl	$6, -376(%ebp)
	movl	$LC16, -368(%ebp)
	movl	$11, -364(%ebp)
	movl	16(%ebp), %eax
	movl	(%eax), %edx
	movl	20(%ebp), %eax
	movl	(%eax), %eax
	imull	%edx, %eax
	sall	$2, %eax
	movl	%eax, -396(%ebp)
	movl	$3968, -424(%ebp)
	movl	$21, -420(%ebp)
	leal	-424(%ebp), %eax
	movl	%eax, (%esp)
	call	__gfortran_st_open
	movl	20(%ebp), %eax
	movl	(%eax), %ebx
	movl	$1, -32(%ebp)
	cmpl	%ebx, -32(%ebp)
	jg	L69
L72:
	movl	$LC9, -416(%ebp)
	movl	$1083, -412(%ebp)
	movl	$128, -424(%ebp)
	movl	$11, -420(%ebp)
	leal	-424(%ebp), %eax
	movl	%eax, (%esp)
	call	__gfortran_st_read
	movl	16(%ebp), %eax
	movl	(%eax), %esi
	movl	$1, -28(%ebp)
	cmpl	%esi, -28(%ebp)
	jg	L70
L71:
	movl	-68(%ebp), %edx
	movl	-64(%ebp), %ecx
	movl	-44(%ebp), %eax
	imull	-32(%ebp), %eax
	addl	%eax, %ecx
	movl	-28(%ebp), %eax
	addl	%ecx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	movl	$4, 8(%esp)
	movl	%eax, 4(%esp)
	leal	-424(%ebp), %eax
	movl	%eax, (%esp)
	call	__gfortran_transfer_real
	movl	-424(%ebp), %eax
	andl	$3, %eax
	andl	$1, %eax
	testl	%eax, %eax
	jne	L70
	cmpl	%esi, -28(%ebp)
	sete	%al
	movzbl	%al, %eax
	addl	$1, -28(%ebp)
	testl	%eax, %eax
	jne	L70
	jmp	L71
L70:
	leal	-424(%ebp), %eax
	movl	%eax, (%esp)
	call	__gfortran_st_read_done
	cmpl	%ebx, -32(%ebp)
	sete	%al
	movzbl	%al, %eax
	addl	$1, -32(%ebp)
	testl	%eax, %eax
	jne	L69
	jmp	L72
L69:
	movl	$LC9, -416(%ebp)
	movl	$1087, -412(%ebp)
	movl	$1, -392(%ebp)
	movl	$0, -388(%ebp)
	movl	$512, -424(%ebp)
	movl	$21, -420(%ebp)
	leal	-424(%ebp), %eax
	movl	%eax, (%esp)
	call	__gfortran_st_write
	movl	$0, 12(%esp)
	movl	$4, 8(%esp)
	leal	-68(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-424(%ebp), %eax
	movl	%eax, (%esp)
	call	__gfortran_transfer_array_write
	leal	-424(%ebp), %eax
	movl	%eax, (%esp)
	call	__gfortran_st_write_done
	movl	$LC9, -416(%ebp)
	movl	$1088, -412(%ebp)
	movl	$0, -424(%ebp)
	movl	$11, -420(%ebp)
	leal	-424(%ebp), %eax
	movl	%eax, (%esp)
	call	__gfortran_st_close
	movl	$LC9, -416(%ebp)
	movl	$1089, -412(%ebp)
	movl	$0, -424(%ebp)
	movl	$21, -420(%ebp)
	leal	-424(%ebp), %eax
	movl	%eax, (%esp)
	call	__gfortran_st_close
	movl	-68(%ebp), %eax
	testl	%eax, %eax
	je	L73
	movl	-68(%ebp), %eax
	movl	%eax, (%esp)
	call	_free
L73:
	movl	$0, -68(%ebp)
	addl	$428, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%edi
	.cfi_restore 7
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3:
	.globl	___photo_MOD_spinup3
	.def	___photo_MOD_spinup3;	.scl	2;	.type	32;	.endef
___photo_MOD_spinup3:
LFB4:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$92, %esp
	movl	12(%ebp), %eax
	flds	(%eax)
	fstps	-8(%ebp)
	movl	12(%ebp), %eax
	flds	4(%eax)
	fstps	-12(%ebp)
	movl	12(%ebp), %eax
	flds	8(%eax)
	fstps	-16(%ebp)
	movl	12(%ebp), %eax
	flds	12(%eax)
	fstps	-20(%ebp)
	movl	12(%ebp), %eax
	flds	16(%eax)
	fstps	-24(%ebp)
	movl	12(%ebp), %eax
	flds	20(%eax)
	fstps	-28(%ebp)
	flds	-24(%ebp)
	fldz
	fxch	%st(1)
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L75
	flds	-12(%ebp)
	fldz
	fxch	%st(1)
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L75
	movl	$1, %eax
	jmp	L78
L75:
	movl	$0, %eax
L78:
	movl	%eax, -32(%ebp)
	flds	LC18
	fstps	-36(%ebp)
	movl	8(%ebp), %eax
	flds	(%eax)
	fldz
	fucomip	%st(1), %st
	fstp	%st(0)
	jnb	L106
	movl	8(%ebp), %eax
	flds	(%eax)
	fstps	-40(%ebp)
	movl	$1, -4(%ebp)
	cmpl	$36525, -4(%ebp)
	jg	L106
L98:
	cmpl	$1, -4(%ebp)
	jne	L80
	movl	-4(%ebp), %eax
	subl	$1, %eax
	flds	-20(%ebp)
	fmuls	-40(%ebp)
	fstps	_cleafi_aux.3603(,%eax,4)
	movl	-4(%ebp), %eax
	subl	$1, %eax
	flds	-24(%ebp)
	fmuls	-40(%ebp)
	fstps	_cawoodi_aux.3599(,%eax,4)
	movl	-4(%ebp), %eax
	subl	$1, %eax
	flds	-28(%ebp)
	fmuls	-40(%ebp)
	fstps	_cfrooti_aux.3601(,%eax,4)
	jmp	L81
L80:
	movl	-4(%ebp), %eax
	subl	$2, %eax
	flds	_cleafi_aux.3603(,%eax,4)
	flds	-20(%ebp)
	fmuls	-40(%ebp)
	faddp	%st, %st(1)
	fstps	-44(%ebp)
	movl	-4(%ebp), %eax
	subl	$2, %eax
	flds	_cawoodi_aux.3599(,%eax,4)
	flds	-20(%ebp)
	fmuls	-40(%ebp)
	faddp	%st, %st(1)
	fstps	-48(%ebp)
	movl	-4(%ebp), %eax
	subl	$2, %eax
	flds	_cfrooti_aux.3601(,%eax,4)
	flds	-28(%ebp)
	fmuls	-40(%ebp)
	faddp	%st, %st(1)
	fstps	-52(%ebp)
	movl	-4(%ebp), %eax
	subl	$2, %eax
	flds	_cleafi_aux.3603(,%eax,4)
	fdivs	-8(%ebp)
	flds	-44(%ebp)
	fsubp	%st, %st(1)
	fstps	-56(%ebp)
	movl	-4(%ebp), %eax
	subl	$2, %eax
	flds	_cawoodi_aux.3599(,%eax,4)
	fdivs	-12(%ebp)
	flds	-48(%ebp)
	fsubp	%st, %st(1)
	fstps	-60(%ebp)
	movl	-4(%ebp), %eax
	subl	$2, %eax
	flds	_cfrooti_aux.3601(,%eax,4)
	fdivs	-16(%ebp)
	flds	-52(%ebp)
	fsubp	%st, %st(1)
	fstps	-64(%ebp)
	cmpl	$0, -32(%ebp)
	je	L82
	fldz
	flds	-56(%ebp)
	fucomip	%st(1), %st
	seta	%al
	movzbl	%al, %eax
	fucomi	%st(0), %st
	setp	%dl
	movzbl	%dl, %edx
	andl	$1, %edx
	orl	%edx, %eax
	testl	%eax, %eax
	je	L83
	fstp	%st(0)
	flds	-56(%ebp)
L83:
	movl	-4(%ebp), %eax
	subl	$1, %eax
	fstps	_cleafi_aux.3603(,%eax,4)
	fldz
	flds	-60(%ebp)
	fucomip	%st(1), %st
	seta	%al
	movzbl	%al, %eax
	fucomi	%st(0), %st
	setp	%dl
	movzbl	%dl, %edx
	andl	$1, %edx
	orl	%edx, %eax
	testl	%eax, %eax
	je	L84
	fstp	%st(0)
	flds	-60(%ebp)
L84:
	movl	-4(%ebp), %eax
	subl	$1, %eax
	fstps	_cawoodi_aux.3599(,%eax,4)
	fldz
	flds	-64(%ebp)
	fucomip	%st(1), %st
	seta	%al
	movzbl	%al, %eax
	fucomi	%st(0), %st
	setp	%dl
	movzbl	%dl, %edx
	andl	$1, %edx
	orl	%edx, %eax
	testl	%eax, %eax
	je	L85
	fstp	%st(0)
	flds	-64(%ebp)
L85:
	movl	-4(%ebp), %eax
	subl	$1, %eax
	fstps	_cfrooti_aux.3601(,%eax,4)
	jmp	L86
L82:
	fldz
	flds	-56(%ebp)
	fucomip	%st(1), %st
	seta	%al
	movzbl	%al, %eax
	fucomi	%st(0), %st
	setp	%dl
	movzbl	%dl, %edx
	andl	$1, %edx
	orl	%edx, %eax
	testl	%eax, %eax
	je	L87
	fstp	%st(0)
	flds	-56(%ebp)
L87:
	movl	-4(%ebp), %eax
	subl	$1, %eax
	fstps	_cleafi_aux.3603(,%eax,4)
	fldz
	flds	-64(%ebp)
	fucomip	%st(1), %st
	seta	%al
	movzbl	%al, %eax
	fucomi	%st(0), %st
	setp	%dl
	movzbl	%dl, %edx
	andl	$1, %edx
	orl	%edx, %eax
	testl	%eax, %eax
	je	L88
	fstp	%st(0)
	flds	-64(%ebp)
L88:
	movl	-4(%ebp), %eax
	subl	$1, %eax
	fstps	_cfrooti_aux.3601(,%eax,4)
	movl	-4(%ebp), %eax
	subl	$1, %eax
	fldz
	fstps	_cawoodi_aux.3599(,%eax,4)
L86:
	fildl	-4(%ebp)
	flds	LC19
	fmulp	%st, %st(1)
	fnstcw	-82(%ebp)
	movzwl	-82(%ebp), %eax
	movb	$12, %ah
	movw	%ax, -84(%ebp)
	fldcw	-84(%ebp)
	fistl	-88(%ebp)
	fldcw	-82(%ebp)
	movl	-88(%ebp), %eax
	movl	%eax, -92(%ebp)
	fildl	-92(%ebp)
	fxch	%st(1)
	fucomip	%st(1), %st
	fstp	%st(0)
	jnb	L91
	subl	$1, %eax
L91:
	movl	%eax, -68(%ebp)
	cmpl	$0, -32(%ebp)
	je	L92
	movl	-4(%ebp), %eax
	subl	$1, %eax
	flds	_cfrooti_aux.3601(,%eax,4)
	movl	-68(%ebp), %eax
	subl	$1, %eax
	flds	_cfrooti_aux.3601(,%eax,4)
	fdivrp	%st, %st(1)
	flds	-36(%ebp)
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L81
	movl	-4(%ebp), %eax
	subl	$1, %eax
	flds	_cleafi_aux.3603(,%eax,4)
	movl	-68(%ebp), %eax
	subl	$1, %eax
	flds	_cleafi_aux.3603(,%eax,4)
	fdivrp	%st, %st(1)
	flds	-36(%ebp)
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L81
	movl	-4(%ebp), %eax
	subl	$1, %eax
	flds	_cawoodi_aux.3599(,%eax,4)
	movl	-68(%ebp), %eax
	subl	$1, %eax
	flds	_cawoodi_aux.3599(,%eax,4)
	fdivrp	%st, %st(1)
	flds	-36(%ebp)
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L81
	movl	-4(%ebp), %eax
	subl	$1, %eax
	flds	_cleafi_aux.3603(,%eax,4)
	movl	16(%ebp), %eax
	fstps	(%eax)
	movl	-4(%ebp), %eax
	subl	$1, %eax
	flds	_cfrooti_aux.3601(,%eax,4)
	movl	20(%ebp), %eax
	fstps	(%eax)
	movl	-4(%ebp), %eax
	subl	$1, %eax
	flds	_cawoodi_aux.3599(,%eax,4)
	movl	24(%ebp), %eax
	fstps	(%eax)
	jmp	L79
L92:
	movl	-4(%ebp), %eax
	subl	$1, %eax
	flds	_cfrooti_aux.3601(,%eax,4)
	movl	-68(%ebp), %eax
	subl	$1, %eax
	flds	_cfrooti_aux.3601(,%eax,4)
	fdivrp	%st, %st(1)
	flds	-36(%ebp)
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L81
	movl	-4(%ebp), %eax
	subl	$1, %eax
	flds	_cleafi_aux.3603(,%eax,4)
	movl	-68(%ebp), %eax
	subl	$1, %eax
	flds	_cleafi_aux.3603(,%eax,4)
	fdivrp	%st, %st(1)
	flds	-36(%ebp)
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L81
	movl	-4(%ebp), %eax
	subl	$1, %eax
	flds	_cleafi_aux.3603(,%eax,4)
	movl	16(%ebp), %eax
	fstps	(%eax)
	movl	-4(%ebp), %eax
	subl	$1, %eax
	flds	_cfrooti_aux.3601(,%eax,4)
	movl	20(%ebp), %eax
	fstps	(%eax)
	movl	24(%ebp), %eax
	fldz
	fstps	(%eax)
	jmp	L79
L81:
	cmpl	$36525, -4(%ebp)
	sete	%al
	movzbl	%al, %eax
	addl	$1, -4(%ebp)
	testl	%eax, %eax
	jne	L106
	jmp	L98
L79:
L106:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE4:
	.globl	___photo_MOD_spinup
	.def	___photo_MOD_spinup;	.scl	2;	.type	32;	.endef
___photo_MOD_spinup:
LFB5:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$348, %esp
	.cfi_offset 3, -12
	movl	$1, %eax
L109:
	cmpl	$12, %eax
	jg	L108
	leal	-1(%eax), %edx
	leal	0(,%eax,8), %ecx
	leal	-6(%ecx), %ebx
	movl	12(%ebp), %ecx
	flds	(%ecx,%ebx,4)
	fstps	-340(%ebp,%edx,4)
	addl	$1, %eax
	jmp	L109
L108:
	movl	$1, %eax
L111:
	cmpl	$12, %eax
	jg	L110
	leal	-1(%eax), %edx
	leal	0(,%eax,8), %ecx
	leal	-5(%ecx), %ebx
	movl	12(%ebp), %ecx
	flds	(%ecx,%ebx,4)
	fstps	-244(%ebp,%edx,4)
	addl	$1, %eax
	jmp	L111
L110:
	movl	$1, %eax
L113:
	cmpl	$12, %eax
	jg	L112
	leal	-1(%eax), %edx
	leal	0(,%eax,8), %ecx
	leal	-4(%ecx), %ebx
	movl	12(%ebp), %ecx
	flds	(%ecx,%ebx,4)
	fstps	-292(%ebp,%edx,4)
	addl	$1, %eax
	jmp	L113
L112:
	movl	$1, %eax
L115:
	cmpl	$12, %eax
	jg	L114
	leal	-1(%eax), %edx
	leal	0(,%eax,8), %ecx
	leal	-3(%ecx), %ebx
	movl	12(%ebp), %ecx
	flds	(%ecx,%ebx,4)
	fstps	-196(%ebp,%edx,4)
	addl	$1, %eax
	jmp	L115
L114:
	movl	$1, %eax
L117:
	cmpl	$12, %eax
	jg	L116
	leal	-1(%eax), %edx
	leal	0(,%eax,8), %ecx
	leal	-2(%ecx), %ebx
	movl	12(%ebp), %ecx
	flds	(%ecx,%ebx,4)
	fstps	-100(%ebp,%edx,4)
	addl	$1, %eax
	jmp	L117
L116:
	movl	$1, %eax
L119:
	cmpl	$12, %eax
	jg	L118
	leal	-1(%eax), %edx
	leal	0(,%eax,8), %ecx
	leal	-1(%ecx), %ebx
	movl	12(%ebp), %ecx
	flds	(%ecx,%ebx,4)
	fstps	-148(%ebp,%edx,4)
	addl	$1, %eax
	jmp	L119
L118:
	flds	LC20
	fstps	-16(%ebp)
	movl	8(%ebp), %eax
	flds	(%eax)
	fldz
	fucomip	%st(1), %st
	fstp	%st(0)
	jnb	L153
	movl	8(%ebp), %eax
	flds	(%eax)
	fstps	-20(%ebp)
	movl	$1, -8(%ebp)
	cmpl	$12, -8(%ebp)
	jg	L153
L145:
	movl	-8(%ebp), %eax
	subl	$1, %eax
	flds	-100(%ebp,%eax,4)
	fldz
	fxch	%st(1)
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L121
	movl	-8(%ebp), %eax
	subl	$1, %eax
	flds	-244(%ebp,%eax,4)
	fldz
	fxch	%st(1)
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L121
	movl	$1, %eax
	jmp	L124
L121:
	movl	$0, %eax
L124:
	movl	%eax, -24(%ebp)
	movl	$1, -12(%ebp)
	cmpl	$36525, -12(%ebp)
	jg	L125
L144:
	cmpl	$1, -12(%ebp)
	jne	L126
	movl	-12(%ebp), %eax
	subl	$1, %eax
	movl	-8(%ebp), %edx
	subl	$1, %edx
	flds	-196(%ebp,%edx,4)
	fmuls	-20(%ebp)
	fstps	_cleafi_aux.3647(,%eax,4)
	movl	-12(%ebp), %eax
	subl	$1, %eax
	movl	-8(%ebp), %edx
	subl	$1, %edx
	flds	-100(%ebp,%edx,4)
	fmuls	-20(%ebp)
	fstps	_cawoodi_aux.3643(,%eax,4)
	movl	-12(%ebp), %eax
	subl	$1, %eax
	movl	-8(%ebp), %edx
	subl	$1, %edx
	flds	-148(%ebp,%edx,4)
	fmuls	-20(%ebp)
	fstps	_cfrooti_aux.3645(,%eax,4)
	jmp	L127
L126:
	movl	-12(%ebp), %eax
	subl	$2, %eax
	flds	_cleafi_aux.3647(,%eax,4)
	movl	-8(%ebp), %eax
	subl	$1, %eax
	flds	-196(%ebp,%eax,4)
	fmuls	-20(%ebp)
	faddp	%st, %st(1)
	fstps	-28(%ebp)
	movl	-12(%ebp), %eax
	subl	$2, %eax
	flds	_cawoodi_aux.3643(,%eax,4)
	movl	-8(%ebp), %eax
	subl	$1, %eax
	flds	-196(%ebp,%eax,4)
	fmuls	-20(%ebp)
	faddp	%st, %st(1)
	fstps	-32(%ebp)
	movl	-12(%ebp), %eax
	subl	$2, %eax
	flds	_cfrooti_aux.3645(,%eax,4)
	movl	-8(%ebp), %eax
	subl	$1, %eax
	flds	-148(%ebp,%eax,4)
	fmuls	-20(%ebp)
	faddp	%st, %st(1)
	fstps	-36(%ebp)
	movl	-12(%ebp), %eax
	subl	$2, %eax
	flds	_cleafi_aux.3647(,%eax,4)
	movl	-8(%ebp), %eax
	subl	$1, %eax
	flds	-340(%ebp,%eax,4)
	fdivrp	%st, %st(1)
	flds	-28(%ebp)
	fsubp	%st, %st(1)
	fstps	-40(%ebp)
	movl	-12(%ebp), %eax
	subl	$2, %eax
	flds	_cawoodi_aux.3643(,%eax,4)
	movl	-8(%ebp), %eax
	subl	$1, %eax
	flds	-244(%ebp,%eax,4)
	fdivrp	%st, %st(1)
	flds	-32(%ebp)
	fsubp	%st, %st(1)
	fstps	-44(%ebp)
	movl	-12(%ebp), %eax
	subl	$2, %eax
	flds	_cfrooti_aux.3645(,%eax,4)
	movl	-8(%ebp), %eax
	subl	$1, %eax
	flds	-292(%ebp,%eax,4)
	fdivrp	%st, %st(1)
	flds	-36(%ebp)
	fsubp	%st, %st(1)
	fstps	-48(%ebp)
	cmpl	$0, -24(%ebp)
	je	L128
	fldz
	flds	-40(%ebp)
	fucomip	%st(1), %st
	seta	%al
	movzbl	%al, %eax
	fucomi	%st(0), %st
	setp	%dl
	movzbl	%dl, %edx
	andl	$1, %edx
	orl	%edx, %eax
	testl	%eax, %eax
	je	L129
	fstp	%st(0)
	flds	-40(%ebp)
L129:
	movl	-12(%ebp), %eax
	subl	$1, %eax
	fstps	_cleafi_aux.3647(,%eax,4)
	fldz
	flds	-44(%ebp)
	fucomip	%st(1), %st
	seta	%al
	movzbl	%al, %eax
	fucomi	%st(0), %st
	setp	%dl
	movzbl	%dl, %edx
	andl	$1, %edx
	orl	%edx, %eax
	testl	%eax, %eax
	je	L130
	fstp	%st(0)
	flds	-44(%ebp)
L130:
	movl	-12(%ebp), %eax
	subl	$1, %eax
	fstps	_cawoodi_aux.3643(,%eax,4)
	fldz
	flds	-48(%ebp)
	fucomip	%st(1), %st
	seta	%al
	movzbl	%al, %eax
	fucomi	%st(0), %st
	setp	%dl
	movzbl	%dl, %edx
	andl	$1, %edx
	orl	%edx, %eax
	testl	%eax, %eax
	je	L131
	fstp	%st(0)
	flds	-48(%ebp)
L131:
	movl	-12(%ebp), %eax
	subl	$1, %eax
	fstps	_cfrooti_aux.3645(,%eax,4)
	jmp	L132
L128:
	fldz
	flds	-40(%ebp)
	fucomip	%st(1), %st
	seta	%al
	movzbl	%al, %eax
	fucomi	%st(0), %st
	setp	%dl
	movzbl	%dl, %edx
	andl	$1, %edx
	orl	%edx, %eax
	testl	%eax, %eax
	je	L133
	fstp	%st(0)
	flds	-40(%ebp)
L133:
	movl	-12(%ebp), %eax
	subl	$1, %eax
	fstps	_cleafi_aux.3647(,%eax,4)
	movl	-12(%ebp), %eax
	subl	$1, %eax
	fldz
	fstps	_cawoodi_aux.3643(,%eax,4)
	fldz
	flds	-48(%ebp)
	fucomip	%st(1), %st
	seta	%al
	movzbl	%al, %eax
	fucomi	%st(0), %st
	setp	%dl
	movzbl	%dl, %edx
	andl	$1, %edx
	orl	%edx, %eax
	testl	%eax, %eax
	je	L134
	fstp	%st(0)
	flds	-48(%ebp)
L134:
	movl	-12(%ebp), %eax
	subl	$1, %eax
	fstps	_cfrooti_aux.3645(,%eax,4)
L132:
	fildl	-12(%ebp)
	flds	LC19
	fmulp	%st, %st(1)
	fnstcw	-342(%ebp)
	movzwl	-342(%ebp), %eax
	movb	$12, %ah
	movw	%ax, -344(%ebp)
	fldcw	-344(%ebp)
	fistl	-348(%ebp)
	fldcw	-342(%ebp)
	movl	-348(%ebp), %eax
	movl	%eax, -352(%ebp)
	fildl	-352(%ebp)
	fxch	%st(1)
	fucomip	%st(1), %st
	fstp	%st(0)
	jnb	L137
	subl	$1, %eax
L137:
	movl	%eax, -52(%ebp)
	cmpl	$0, -24(%ebp)
	je	L138
	movl	-12(%ebp), %eax
	subl	$1, %eax
	flds	_cfrooti_aux.3645(,%eax,4)
	movl	-52(%ebp), %eax
	subl	$1, %eax
	flds	_cfrooti_aux.3645(,%eax,4)
	fdivrp	%st, %st(1)
	flds	-16(%ebp)
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L127
	movl	-12(%ebp), %eax
	subl	$1, %eax
	flds	_cleafi_aux.3647(,%eax,4)
	movl	-52(%ebp), %eax
	subl	$1, %eax
	flds	_cleafi_aux.3647(,%eax,4)
	fdivrp	%st, %st(1)
	flds	-16(%ebp)
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L127
	movl	-12(%ebp), %eax
	subl	$1, %eax
	flds	_cawoodi_aux.3643(,%eax,4)
	movl	-52(%ebp), %eax
	subl	$1, %eax
	flds	_cawoodi_aux.3643(,%eax,4)
	fdivrp	%st, %st(1)
	flds	-16(%ebp)
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L127
	movl	-8(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-12(%ebp), %eax
	subl	$1, %eax
	flds	_cleafi_aux.3647(,%eax,4)
	movl	16(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-8(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-12(%ebp), %eax
	subl	$1, %eax
	flds	_cfrooti_aux.3645(,%eax,4)
	movl	20(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-8(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-12(%ebp), %eax
	subl	$1, %eax
	flds	_cawoodi_aux.3643(,%eax,4)
	movl	24(%ebp), %eax
	fstps	(%eax,%edx,4)
	jmp	L125
L138:
	movl	-12(%ebp), %eax
	subl	$1, %eax
	flds	_cfrooti_aux.3645(,%eax,4)
	movl	-52(%ebp), %eax
	subl	$1, %eax
	flds	_cfrooti_aux.3645(,%eax,4)
	fdivrp	%st, %st(1)
	flds	-16(%ebp)
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L127
	movl	-12(%ebp), %eax
	subl	$1, %eax
	flds	_cleafi_aux.3647(,%eax,4)
	movl	-52(%ebp), %eax
	subl	$1, %eax
	flds	_cleafi_aux.3647(,%eax,4)
	fdivrp	%st, %st(1)
	flds	-16(%ebp)
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L127
	movl	-8(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-12(%ebp), %eax
	subl	$1, %eax
	flds	_cleafi_aux.3647(,%eax,4)
	movl	16(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-8(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-12(%ebp), %eax
	subl	$1, %eax
	flds	_cfrooti_aux.3645(,%eax,4)
	movl	20(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-8(%ebp), %eax
	leal	-1(%eax), %edx
	movl	24(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	jmp	L125
L127:
	cmpl	$36525, -12(%ebp)
	sete	%al
	movzbl	%al, %eax
	addl	$1, -12(%ebp)
	testl	%eax, %eax
	jne	L125
	jmp	L144
L125:
	cmpl	$12, -8(%ebp)
	sete	%al
	movzbl	%al, %eax
	addl	$1, -8(%ebp)
	testl	%eax, %eax
	jne	L153
	jmp	L145
L153:
	nop
	addl	$348, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE5:
	.globl	___photo_MOD_test_dt
	.def	___photo_MOD_test_dt;	.scl	2;	.type	32;	.endef
___photo_MOD_test_dt:
LFB6:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$28, %esp
	.cfi_offset 7, -12
	.cfi_offset 6, -16
	.cfi_offset 3, -20
	movl	8(%ebp), %eax
	movl	12(%eax), %edx
	testl	%edx, %edx
	jne	L156
	movl	$1, %edx
L156:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -20(%ebp)
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$2, %eax
	movl	%edx, %eax
	negl	%eax
	movl	%eax, -36(%ebp)
	movl	16(%ebp), %eax
	movl	(%eax), %eax
	leal	-9(%eax), %edi
	movl	$1, %eax
L158:
	cmpl	$12, %eax
	jg	L159
	movl	%eax, %ecx
	imull	%edx, %ecx
	movl	-36(%ebp), %ebx
	addl	%ecx, %ebx
	leal	0(,%eax,8), %ecx
	leal	(%ecx,%edi), %esi
	movl	12(%ebp), %ecx
	flds	(%ecx,%esi,4)
	movl	-20(%ebp), %ecx
	fstps	(%ecx,%ebx,4)
	addl	$1, %eax
	jmp	L158
L159:
	nop
	addl	$28, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%edi
	.cfi_restore 7
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE6:
	.section .rdata,"dr"
LC21:
	.ascii "pls.bin"
	.text
	.globl	___photo_MOD_pft_par2
	.def	___photo_MOD_pft_par2;	.scl	2;	.type	32;	.endef
___photo_MOD_pft_par2:
LFB7:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$428, %esp
	.cfi_offset 7, -12
	.cfi_offset 6, -16
	.cfi_offset 3, -20
	movl	8(%ebp), %eax
	movl	12(%eax), %esi
	testl	%esi, %esi
	jne	L162
	movl	$1, %esi
L162:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -28(%ebp)
	movl	8(%ebp), %eax
	movl	24(%eax), %ebx
	movl	%ebx, %eax
	addl	%eax, %eax
	addl	%ebx, %eax
	sall	$2, %eax
	movl	%esi, %eax
	negl	%eax
	subl	%ebx, %eax
	movl	%eax, %edi
	movl	$LC9, -376(%ebp)
	movl	$814, -372(%ebp)
	movl	$LC21, -348(%ebp)
	movl	$7, -352(%ebp)
	movl	$LC10, -344(%ebp)
	movl	$3, -340(%ebp)
	movl	$LC15, -332(%ebp)
	movl	$6, -336(%ebp)
	movl	$LC16, -328(%ebp)
	movl	$11, -324(%ebp)
	movl	$384, -356(%ebp)
	movl	$3968, -384(%ebp)
	movl	$45, -380(%ebp)
	leal	-384(%ebp), %eax
	movl	%eax, (%esp)
	call	__gfortran_st_open
	movl	$LC9, -376(%ebp)
	movl	$815, -372(%ebp)
	movl	$1, -352(%ebp)
	movl	$0, -348(%ebp)
	movl	$512, -384(%ebp)
	movl	$45, -380(%ebp)
	leal	-384(%ebp), %eax
	movl	%eax, (%esp)
	call	__gfortran_st_read
	movl	$282, -412(%ebp)
	movl	$1, -404(%ebp)
	movl	$8, -400(%ebp)
	movl	%esi, -408(%ebp)
	movl	$1, -392(%ebp)
	movl	$12, -388(%ebp)
	movl	%ebx, -396(%ebp)
	movl	-28(%ebp), %eax
	movl	%eax, -420(%ebp)
	movl	%edi, -416(%ebp)
	movl	$0, 12(%esp)
	movl	$4, 8(%esp)
	leal	-420(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-384(%ebp), %eax
	movl	%eax, (%esp)
	call	__gfortran_transfer_array
	leal	-384(%ebp), %eax
	movl	%eax, (%esp)
	call	__gfortran_st_read_done
	movl	$LC9, -376(%ebp)
	movl	$816, -372(%ebp)
	movl	$0, -384(%ebp)
	movl	$45, -380(%ebp)
	leal	-384(%ebp), %eax
	movl	%eax, (%esp)
	call	__gfortran_st_close
	nop
	addl	$428, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%edi
	.cfi_restore 7
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE7:
	.globl	___photo_MOD_pft_par
	.def	___photo_MOD_pft_par;	.scl	2;	.type	32;	.endef
___photo_MOD_pft_par:
LFB8:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$424, %esp
	movl	$LC9, -352(%ebp)
	movl	$784, -348(%ebp)
	movl	$LC21, -324(%ebp)
	movl	$7, -328(%ebp)
	movl	$LC10, -320(%ebp)
	movl	$3, -316(%ebp)
	movl	$LC15, -308(%ebp)
	movl	$6, -312(%ebp)
	movl	$LC16, -304(%ebp)
	movl	$11, -300(%ebp)
	movl	$384, -332(%ebp)
	movl	$3968, -360(%ebp)
	movl	$45, -356(%ebp)
	leal	-360(%ebp), %eax
	movl	%eax, (%esp)
	call	__gfortran_st_open
	movl	$LC9, -352(%ebp)
	movl	$785, -348(%ebp)
	movl	$1, -328(%ebp)
	movl	$0, -324(%ebp)
	movl	$512, -360(%ebp)
	movl	$45, -356(%ebp)
	leal	-360(%ebp), %eax
	movl	%eax, (%esp)
	call	__gfortran_st_read
	movl	$282, -388(%ebp)
	movl	$1, -380(%ebp)
	movl	$12, -376(%ebp)
	movl	$1, -384(%ebp)
	movl	$1, -368(%ebp)
	movl	$8, -364(%ebp)
	movl	$12, -372(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, -396(%ebp)
	movl	$-13, -392(%ebp)
	movl	$0, 12(%esp)
	movl	$4, 8(%esp)
	leal	-396(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-360(%ebp), %eax
	movl	%eax, (%esp)
	call	__gfortran_transfer_array
	leal	-360(%ebp), %eax
	movl	%eax, (%esp)
	call	__gfortran_st_read_done
	movl	$LC9, -352(%ebp)
	movl	$786, -348(%ebp)
	movl	$0, -360(%ebp)
	movl	$45, -356(%ebp)
	leal	-360(%ebp), %eax
	movl	%eax, (%esp)
	call	__gfortran_st_close
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE8:
	.globl	___photo_MOD_pft_area_frac
	.def	___photo_MOD_pft_area_frac;	.scl	2;	.type	32;	.endef
___photo_MOD_pft_area_frac:
LFB9:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$388, %esp
	.cfi_offset 3, -12
	leal	-172(%ebp), %eax
	movl	8(%ebp), %edx
	movl	(%edx), %ecx
	movl	%ecx, (%eax)
	movl	4(%edx), %ecx
	movl	%ecx, 4(%eax)
	movl	8(%edx), %ecx
	movl	%ecx, 8(%eax)
	movl	12(%edx), %ecx
	movl	%ecx, 12(%eax)
	movl	16(%edx), %ecx
	movl	%ecx, 16(%eax)
	movl	20(%edx), %ecx
	movl	%ecx, 20(%eax)
	movl	24(%edx), %ecx
	movl	%ecx, 24(%eax)
	movl	28(%edx), %ecx
	movl	%ecx, 28(%eax)
	movl	32(%edx), %ecx
	movl	%ecx, 32(%eax)
	movl	36(%edx), %ecx
	movl	%ecx, 36(%eax)
	movl	40(%edx), %ecx
	movl	%ecx, 40(%eax)
	movl	44(%edx), %edx
	movl	%edx, 44(%eax)
	leal	-124(%ebp), %eax
	movl	12(%ebp), %edx
	movl	(%edx), %ecx
	movl	%ecx, (%eax)
	movl	4(%edx), %ecx
	movl	%ecx, 4(%eax)
	movl	8(%edx), %ecx
	movl	%ecx, 8(%eax)
	movl	12(%edx), %ecx
	movl	%ecx, 12(%eax)
	movl	16(%edx), %ecx
	movl	%ecx, 16(%eax)
	movl	20(%edx), %ecx
	movl	%ecx, 20(%eax)
	movl	24(%edx), %ecx
	movl	%ecx, 24(%eax)
	movl	28(%edx), %ecx
	movl	%ecx, 28(%eax)
	movl	32(%edx), %ecx
	movl	%ecx, 32(%eax)
	movl	36(%edx), %ecx
	movl	%ecx, 36(%eax)
	movl	40(%edx), %ecx
	movl	%ecx, 40(%eax)
	movl	44(%edx), %edx
	movl	%edx, 44(%eax)
	leal	-76(%ebp), %eax
	movl	16(%ebp), %edx
	movl	(%edx), %ecx
	movl	%ecx, (%eax)
	movl	4(%edx), %ecx
	movl	%ecx, 4(%eax)
	movl	8(%edx), %ecx
	movl	%ecx, 8(%eax)
	movl	12(%edx), %ecx
	movl	%ecx, 12(%eax)
	movl	16(%edx), %ecx
	movl	%ecx, 16(%eax)
	movl	20(%edx), %ecx
	movl	%ecx, 20(%eax)
	movl	24(%edx), %ecx
	movl	%ecx, 24(%eax)
	movl	28(%edx), %ecx
	movl	%ecx, 28(%eax)
	movl	32(%edx), %ecx
	movl	%ecx, 32(%eax)
	movl	36(%edx), %ecx
	movl	%ecx, 36(%eax)
	movl	40(%edx), %ecx
	movl	%ecx, 40(%eax)
	movl	44(%edx), %edx
	movl	%edx, 44(%eax)
	fldz
	fstps	-20(%ebp)
	fldz
	fstps	-24(%ebp)
	movl	$1, -16(%ebp)
	cmpl	$12, -16(%ebp)
	jg	L167
L177:
	movl	-16(%ebp), %eax
	subl	$1, %eax
	flds	-172(%ebp,%eax,4)
	fucomip	%st(0), %st
	jnp	L168
	movl	-16(%ebp), %eax
	subl	$1, %eax
	fldz
	fstps	-172(%ebp,%eax,4)
L168:
	movl	-16(%ebp), %eax
	subl	$1, %eax
	flds	-124(%ebp,%eax,4)
	fucomip	%st(0), %st
	jnp	L169
	movl	-16(%ebp), %eax
	subl	$1, %eax
	fldz
	fstps	-124(%ebp,%eax,4)
L169:
	movl	-16(%ebp), %eax
	subl	$1, %eax
	flds	-76(%ebp,%eax,4)
	fucomip	%st(0), %st
	jnp	L170
	movl	-16(%ebp), %eax
	subl	$1, %eax
	fldz
	fstps	-76(%ebp,%eax,4)
L170:
	movl	-16(%ebp), %eax
	subl	$1, %eax
	flds	-172(%ebp,%eax,4)
	movl	-16(%ebp), %eax
	subl	$1, %eax
	flds	-172(%ebp,%eax,4)
	fld1
	fsubrp	%st, %st(1)
	fucomi	%st(1), %st
	jp	L211
	fucomip	%st(1), %st
	fstp	%st(0)
	jne	L171
	movl	-16(%ebp), %eax
	subl	$1, %eax
	fldz
	fstps	-172(%ebp,%eax,4)
	jmp	L171
L211:
	fstp	%st(0)
	fstp	%st(0)
L171:
	movl	-16(%ebp), %eax
	subl	$1, %eax
	flds	-124(%ebp,%eax,4)
	movl	-16(%ebp), %eax
	subl	$1, %eax
	flds	-124(%ebp,%eax,4)
	fld1
	fsubrp	%st, %st(1)
	fucomi	%st(1), %st
	jp	L212
	fucomip	%st(1), %st
	fstp	%st(0)
	jne	L173
	movl	-16(%ebp), %eax
	subl	$1, %eax
	fldz
	fstps	-124(%ebp,%eax,4)
	jmp	L173
L212:
	fstp	%st(0)
	fstp	%st(0)
L173:
	movl	-16(%ebp), %eax
	subl	$1, %eax
	flds	-76(%ebp,%eax,4)
	movl	-16(%ebp), %eax
	subl	$1, %eax
	flds	-76(%ebp,%eax,4)
	fld1
	fsubrp	%st, %st(1)
	fucomi	%st(1), %st
	jp	L213
	fucomip	%st(1), %st
	fstp	%st(0)
	jne	L175
	movl	-16(%ebp), %eax
	subl	$1, %eax
	fldz
	fstps	-76(%ebp,%eax,4)
	jmp	L175
L213:
	fstp	%st(0)
	fstp	%st(0)
L175:
	cmpl	$12, -16(%ebp)
	sete	%al
	movzbl	%al, %eax
	addl	$1, -16(%ebp)
	testl	%eax, %eax
	jne	L167
	jmp	L177
L167:
	movl	$1, -16(%ebp)
	cmpl	$12, -16(%ebp)
	jg	L178
L179:
	movl	-16(%ebp), %eax
	subl	$1, %eax
	fldz
	fstps	-272(%ebp,%eax,4)
	movl	-16(%ebp), %eax
	subl	$1, %eax
	fldz
	fstps	-224(%ebp,%eax,4)
	movl	-16(%ebp), %eax
	leal	-1(%eax), %edx
	movl	20(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-16(%ebp), %eax
	leal	-1(%eax), %edx
	movl	24(%ebp), %eax
	movl	$0, (%eax,%edx,4)
	cmpl	$12, -16(%ebp)
	sete	%al
	movzbl	%al, %eax
	addl	$1, -16(%ebp)
	testl	%eax, %eax
	jne	L178
	jmp	L179
L178:
	movl	$1, -16(%ebp)
	cmpl	$12, -16(%ebp)
	jg	L180
L185:
	movl	-16(%ebp), %eax
	subl	$1, %eax
	flds	-172(%ebp,%eax,4)
	flds	LC0
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L181
	movl	-16(%ebp), %eax
	subl	$1, %eax
	flds	-124(%ebp,%eax,4)
	flds	LC0
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L181
	movl	-16(%ebp), %eax
	subl	$1, %eax
	fldz
	fstps	-224(%ebp,%eax,4)
	movl	-16(%ebp), %eax
	subl	$1, %eax
	fldz
	fstps	-272(%ebp,%eax,4)
	jmp	L184
L181:
	movl	-16(%ebp), %eax
	subl	$1, %eax
	movl	-16(%ebp), %edx
	subl	$1, %edx
	flds	-172(%ebp,%edx,4)
	movl	-16(%ebp), %edx
	subl	$1, %edx
	flds	-124(%ebp,%edx,4)
	faddp	%st, %st(1)
	movl	-16(%ebp), %edx
	subl	$1, %edx
	flds	-76(%ebp,%edx,4)
	faddp	%st, %st(1)
	fstps	-224(%ebp,%eax,4)
	movl	-16(%ebp), %eax
	subl	$1, %eax
	movl	-16(%ebp), %edx
	subl	$1, %edx
	flds	-76(%ebp,%edx,4)
	fstps	-272(%ebp,%eax,4)
L184:
	movl	-16(%ebp), %eax
	subl	$1, %eax
	flds	-224(%ebp,%eax,4)
	flds	-20(%ebp)
	faddp	%st, %st(1)
	fstps	-20(%ebp)
	movl	-16(%ebp), %eax
	subl	$1, %eax
	flds	-272(%ebp,%eax,4)
	flds	-24(%ebp)
	faddp	%st, %st(1)
	fstps	-24(%ebp)
	cmpl	$12, -16(%ebp)
	sete	%al
	movzbl	%al, %eax
	addl	$1, -16(%ebp)
	testl	%eax, %eax
	jne	L180
	jmp	L185
L180:
	flds	-20(%ebp)
	fldz
	fxch	%st(1)
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L209
	movl	$1, -16(%ebp)
	cmpl	$12, -16(%ebp)
	jg	L188
L191:
	movl	-16(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-16(%ebp), %eax
	subl	$1, %eax
	flds	-224(%ebp,%eax,4)
	fdivs	-20(%ebp)
	movl	20(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-16(%ebp), %eax
	leal	-1(%eax), %edx
	movl	20(%ebp), %eax
	flds	(%eax,%edx,4)
	fldz
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L189
	movl	-16(%ebp), %eax
	leal	-1(%eax), %edx
	movl	20(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
L189:
	cmpl	$12, -16(%ebp)
	sete	%al
	movzbl	%al, %eax
	addl	$1, -16(%ebp)
	testl	%eax, %eax
	jne	L188
	jmp	L191
L209:
	movl	$1, -16(%ebp)
	cmpl	$12, -16(%ebp)
	jg	L188
L192:
	movl	-16(%ebp), %eax
	leal	-1(%eax), %edx
	movl	20(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	cmpl	$12, -16(%ebp)
	sete	%al
	movzbl	%al, %eax
	addl	$1, -16(%ebp)
	testl	%eax, %eax
	jne	L188
	jmp	L192
L188:
	movl	$1, -12(%ebp)
	cmpl	$0, -12(%ebp)
	jne	L193
	movl	$1, -12(%ebp)
L193:
	cmpl	$1, -12(%ebp)
	jne	L194
	flds	-24(%ebp)
	fldz
	fxch	%st(1)
	fucomip	%st(1), %st
	fstp	%st(0)
	ja	L207
	jmp	L210
L207:
	movl	$265, -288(%ebp)
	movl	$1, -280(%ebp)
	movl	$1, -276(%ebp)
	movl	$1, -284(%ebp)
	leal	-176(%ebp), %eax
	movl	%eax, -296(%ebp)
	movl	$-1, -292(%ebp)
	movl	$281, -312(%ebp)
	movl	$1, -304(%ebp)
	movl	$12, -300(%ebp)
	movl	$1, -308(%ebp)
	leal	-272(%ebp), %eax
	movl	%eax, -320(%ebp)
	movl	$-1, -316(%ebp)
	leal	-320(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-296(%ebp), %eax
	movl	%eax, (%esp)
	call	__gfortran_maxloc0_4_r4
	movl	-176(%ebp), %eax
	movl	%eax, -28(%ebp)
	movl	-28(%ebp), %eax
	leal	-1(%eax), %edx
	movl	24(%ebp), %eax
	movl	$1, (%eax,%edx,4)
	jmp	L210
L194:
	movl	-12(%ebp), %ebx
	movl	$1, -16(%ebp)
	cmpl	%ebx, -16(%ebp)
	jg	L210
L199:
	flds	-24(%ebp)
	fldz
	fxch	%st(1)
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L197
	movl	$265, -336(%ebp)
	movl	$1, -328(%ebp)
	movl	$1, -324(%ebp)
	movl	$1, -332(%ebp)
	leal	-176(%ebp), %eax
	movl	%eax, -344(%ebp)
	movl	$-1, -340(%ebp)
	movl	$281, -360(%ebp)
	movl	$1, -352(%ebp)
	movl	$12, -348(%ebp)
	movl	$1, -356(%ebp)
	leal	-272(%ebp), %eax
	movl	%eax, -368(%ebp)
	movl	$-1, -364(%ebp)
	leal	-368(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-344(%ebp), %eax
	movl	%eax, (%esp)
	call	__gfortran_maxloc0_4_r4
	movl	-176(%ebp), %eax
	movl	%eax, -28(%ebp)
	movl	-28(%ebp), %eax
	subl	$1, %eax
	fldz
	fstps	-272(%ebp,%eax,4)
	movl	-28(%ebp), %eax
	leal	-1(%eax), %edx
	movl	24(%ebp), %eax
	movl	$1, (%eax,%edx,4)
L197:
	cmpl	%ebx, -16(%ebp)
	sete	%al
	movzbl	%al, %eax
	addl	$1, -16(%ebp)
	testl	%eax, %eax
	jne	L210
	jmp	L199
L210:
	nop
	addl	$388, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE9:
	.globl	___photo_MOD_carbon2
	.def	___photo_MOD_carbon2;	.scl	2;	.type	32;	.endef
___photo_MOD_carbon2:
LFB10:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$72, %esp
	fldz
	fstpl	-16(%ebp)
	fldz
	fstpl	-24(%ebp)
	fldz
	fstpl	-32(%ebp)
	movl	24(%ebp), %eax
	fldz
	fstps	(%eax)
	movl	28(%ebp), %eax
	fldz
	fstps	(%eax)
	movl	16(%ebp), %eax
	flds	(%eax)
	flds	LC2
	fmulp	%st, %st(1)
	flds	LC24
	fmulp	%st, %st(1)
	flds	LC25
	fsubrp	%st, %st(1)
	fstps	4(%esp)
	flds	LC26
	fstps	(%esp)
	call	_powf
	flds	LC27
	fmulp	%st, %st(1)
	fstpl	-24(%ebp)
	movl	8(%ebp), %eax
	flds	(%eax)
	fldl	LC28
	fsubrp	%st, %st(1)
	fldl	LC29
	fmulp	%st, %st(1)
	fstpl	8(%esp)
	fldl	LC30
	fstpl	(%esp)
	call	_pow
	fstpl	-32(%ebp)
	movl	20(%ebp), %eax
	flds	(%eax)
	fldl	LC29
	fmulp	%st, %st(1)
	fstpl	-16(%ebp)
	fldl	-16(%ebp)
	fdivl	-24(%ebp)
	fstps	-44(%ebp)
	flds	-44(%ebp)
	movl	24(%ebp), %eax
	fstps	(%eax)
	movl	24(%ebp), %eax
	flds	(%eax)
	fldl	LC31
	fmulp	%st, %st(1)
	fldl	-32(%ebp)
	fldl	LC32
	fmulp	%st, %st(1)
	fdivrp	%st, %st(1)
	movl	12(%ebp), %eax
	flds	(%eax)
	fmulp	%st, %st(1)
	fstps	-44(%ebp)
	flds	-44(%ebp)
	movl	28(%ebp), %eax
	fstps	(%eax)
	movl	8(%ebp), %eax
	flds	(%eax)
	flds	LC33
	fxch	%st(1)
	fucomip	%st(1), %st
	fstp	%st(0)
	jb	L215
	movl	8(%ebp), %eax
	flds	(%eax)
	flds	LC34
	fucomip	%st(1), %st
	fstp	%st(0)
	jb	L215
	fldl	-24(%ebp)
	fld	%st(0)
	fmulp	%st, %st(1)
	fldl	-32(%ebp)
	fld	%st(0)
	fmulp	%st, %st(1)
	movl	24(%ebp), %eax
	flds	(%eax)
	fmulp	%st, %st(2)
	movl	28(%ebp), %eax
	flds	(%eax)
	movl	12(%ebp), %eax
	flds	(%eax)
	fmulp	%st, %st(1)
	movl	16(%ebp), %eax
	flds	(%eax)
	fmulp	%st, %st(1)
	fmulp	%st, %st(1)
	faddp	%st, %st(1)
	fldl	LC35
	fmulp	%st, %st(1)
	fstps	-44(%ebp)
	flds	-44(%ebp)
	movl	32(%ebp), %eax
	fstps	(%eax)
	jmp	L218
L215:
	movl	32(%ebp), %eax
	fldz
	fstps	(%eax)
L218:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE10:
	.globl	___photo_MOD_g_resp
	.def	___photo_MOD_g_resp;	.scl	2;	.type	32;	.endef
___photo_MOD_g_resp:
LFB11:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$72, %esp
	movl	8(%ebp), %eax
	flds	(%eax)
	fldz
	fucomip	%st(1), %st
	fstp	%st(0)
	jb	L238
	fldz
	fstps	-12(%ebp)
	jmp	L224
L238:
	movl	8(%ebp), %eax
	flds	(%eax)
	fstps	-12(%ebp)
L224:
	movl	16(%ebp), %eax
	flds	(%eax)
	fldz
	fucomip	%st(1), %st
	fstp	%st(0)
	jb	L239
	fldz
	fstps	-8(%ebp)
	jmp	L227
L239:
	movl	16(%ebp), %eax
	flds	(%eax)
	fstps	-8(%ebp)
L227:
	movl	12(%ebp), %eax
	flds	(%eax)
	fldz
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L240
	fldz
	fstps	-4(%ebp)
	jmp	L230
L240:
	movl	12(%ebp), %eax
	flds	(%eax)
	fstps	-4(%ebp)
L230:
	flds	-4(%ebp)
	flds	LC36
	fmulp	%st, %st(1)
	fstpl	-24(%ebp)
	flds	-12(%ebp)
	flds	LC37
	fmulp	%st, %st(1)
	fstpl	-32(%ebp)
	flds	-8(%ebp)
	flds	LC37
	fmulp	%st, %st(1)
	fstpl	-40(%ebp)
	fldl	-24(%ebp)
	fldl	LC38
	fmulp	%st, %st(1)
	fstpl	-48(%ebp)
	fldl	-32(%ebp)
	faddl	-40(%ebp)
	faddl	-48(%ebp)
	fldl	LC39
	fdivrp	%st, %st(1)
	fstpl	-56(%ebp)
	fldl	-56(%ebp)
	fstps	-16(%ebp)
	fldz
	flds	-16(%ebp)
	fxch	%st(1)
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L231
	fldz
	fstps	-16(%ebp)
L231:
	flds	-16(%ebp)
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE11:
	.globl	___photo_MOD_m_resp
	.def	___photo_MOD_m_resp;	.scl	2;	.type	32;	.endef
___photo_MOD_m_resp:
LFB12:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$88, %esp
	movl	20(%ebp), %eax
	flds	(%eax)
	flds	LC36
	fmulp	%st, %st(1)
	fstpl	-24(%ebp)
	movl	12(%ebp), %eax
	flds	(%eax)
	flds	LC40
	fmulp	%st, %st(1)
	fldl	LC41
	fmulp	%st, %st(1)
	fldl	LC42
	fmulp	%st, %st(1)
	fstpl	-72(%ebp)
	movl	8(%ebp), %eax
	flds	(%eax)
	flds	LC43
	fmulp	%st, %st(1)
	fstps	(%esp)
	call	_expf
	fmull	-72(%ebp)
	fstpl	-32(%ebp)
	movl	16(%ebp), %eax
	flds	(%eax)
	flds	LC40
	fmulp	%st, %st(1)
	fldl	LC41
	fmulp	%st, %st(1)
	fldl	LC42
	fmulp	%st, %st(1)
	fstpl	-72(%ebp)
	movl	8(%ebp), %eax
	flds	(%eax)
	flds	LC43
	fmulp	%st, %st(1)
	fstps	(%esp)
	call	_expf
	fmull	-72(%ebp)
	fstpl	-40(%ebp)
	fldl	-24(%ebp)
	fldl	LC39
	fmulp	%st, %st(1)
	fldl	LC44
	fmulp	%st, %st(1)
	fldl	LC42
	fmulp	%st, %st(1)
	fstpl	-72(%ebp)
	movl	8(%ebp), %eax
	flds	(%eax)
	flds	LC43
	fmulp	%st, %st(1)
	fstps	(%esp)
	call	_expf
	fmull	-72(%ebp)
	fstpl	-48(%ebp)
	fldl	-32(%ebp)
	faddl	-40(%ebp)
	faddl	-48(%ebp)
	fldl	LC39
	fdivrp	%st, %st(1)
	fstpl	-56(%ebp)
	fldl	-56(%ebp)
	fstps	-12(%ebp)
	fldz
	flds	-12(%ebp)
	fxch	%st(1)
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L242
	fldz
	fstps	-12(%ebp)
L242:
	flds	-12(%ebp)
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE12:
	.globl	___photo_MOD_tetens
	.def	___photo_MOD_tetens;	.scl	2;	.type	32;	.endef
___photo_MOD_tetens:
LFB13:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	8(%ebp), %eax
	flds	(%eax)
	fldz
	fxch	%st(1)
	fucomip	%st(1), %st
	fstp	%st(0)
	jb	L251
	movl	8(%ebp), %eax
	flds	(%eax)
	flds	LC45
	fdivrp	%st, %st(1)
	flds	LC46
	fsubp	%st, %st(1)
	movl	8(%ebp), %eax
	flds	(%eax)
	movl	8(%ebp), %eax
	flds	(%eax)
	flds	LC47
	faddp	%st, %st(1)
	fdivrp	%st, %st(1)
	fmulp	%st, %st(1)
	fstps	(%esp)
	call	_expf
	flds	LC48
	fmulp	%st, %st(1)
	fstps	-12(%ebp)
	flds	-12(%ebp)
	jmp	L249
L251:
	movl	8(%ebp), %eax
	flds	(%eax)
	flds	LC49
	fdivrp	%st, %st(1)
	flds	LC50
	fsubp	%st, %st(1)
	movl	8(%ebp), %eax
	flds	(%eax)
	movl	8(%ebp), %eax
	flds	(%eax)
	flds	LC51
	faddp	%st, %st(1)
	fdivrp	%st, %st(1)
	fmulp	%st, %st(1)
	fstps	(%esp)
	call	_expf
	flds	LC52
	fmulp	%st, %st(1)
	fstps	-12(%ebp)
	flds	-12(%ebp)
L249:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE13:
	.globl	___photo_MOD_photosynthesis_rate
	.def	___photo_MOD_photosynthesis_rate;	.scl	2;	.type	32;	.endef
___photo_MOD_photosynthesis_rate:
LFB14:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$248, %esp
	movl	8(%ebp), %eax
	flds	(%eax)
	fstps	-224(%ebp)
	movl	12(%ebp), %eax
	flds	(%eax)
	flds	LC53
	fsubrp	%st, %st(1)
	flds	LC54
	fmulp	%st, %st(1)
	fstps	4(%esp)
	flds	LC55
	fstps	(%esp)
	call	_powf
	fmuls	-224(%ebp)
	fstps	-224(%ebp)
	movl	12(%ebp), %eax
	flds	(%eax)
	flds	LC56
	fsubrp	%st, %st(1)
	flds	LC57
	fmulp	%st, %st(1)
	fstps	(%esp)
	call	_expf
	fld1
	faddp	%st, %st(1)
	fdivrs	-224(%ebp)
	fstpl	-40(%ebp)
	movl	12(%ebp), %eax
	flds	(%eax)
	fldl	LC28
	fsubrp	%st, %st(1)
	fldl	LC29
	fmulp	%st, %st(1)
	fstpl	8(%esp)
	fldl	LC58
	fstpl	(%esp)
	call	_pow
	fldl	LC59
	fmulp	%st, %st(1)
	fldl	LC60
	fdivp	%st, %st(1)
	fstpl	-48(%ebp)
	movl	12(%ebp), %eax
	flds	(%eax)
	fldl	LC28
	fsubrp	%st, %st(1)
	fldl	LC29
	fmulp	%st, %st(1)
	fstpl	8(%esp)
	fldl	LC61
	fstpl	(%esp)
	call	_pow
	fldl	LC62
	fmulp	%st, %st(1)
	fstpl	-56(%ebp)
	movl	12(%ebp), %eax
	flds	(%eax)
	fldl	LC28
	fsubrp	%st, %st(1)
	fldl	LC29
	fmulp	%st, %st(1)
	fstpl	8(%esp)
	fldl	LC63
	fstpl	(%esp)
	call	_pow
	fldl	LC64
	fmulp	%st, %st(1)
	fstpl	-64(%ebp)
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	call	___photo_MOD_tetens
	fstpl	-72(%ebp)
	movl	16(%ebp), %eax
	flds	(%eax)
	fsubl	-72(%ebp)
	fldl	-72(%ebp)
	fdivp	%st, %st(1)
	fldl	LC65
	fmulp	%st, %st(1)
	fstpl	-80(%ebp)
	fldl	-80(%ebp)
	fldl	LC66
	fmulp	%st, %st(1)
	fchs
	fstpl	-88(%ebp)
	fldl	-88(%ebp)
	fldl	LC29
	fdivrp	%st, %st(1)
	fld1
	fsubp	%st, %st(1)
	fldl	LC68
	fmulp	%st, %st(1)
	fldl	LC69
	fsubl	-48(%ebp)
	fmulp	%st, %st(1)
	faddl	-48(%ebp)
	fstpl	-96(%ebp)
	fldl	-96(%ebp)
	fsubl	-48(%ebp)
	fldl	LC60
	fdivl	-64(%ebp)
	fld1
	faddp	%st, %st(1)
	fmull	-56(%ebp)
	faddl	-96(%ebp)
	fdivrp	%st, %st(1)
	fmull	-40(%ebp)
	fstpl	-104(%ebp)
	movl	24(%ebp), %eax
	movl	(%eax), %eax
	testl	%eax, %eax
	je	L253
	movl	20(%ebp), %eax
	flds	(%eax)
	fstpl	-16(%ebp)
	jmp	L254
L253:
	movl	20(%ebp), %eax
	flds	(%eax)
	movl	20(%ebp), %eax
	flds	(%eax)
	flds	LC70
	fmulp	%st, %st(1)
	fsubrp	%st, %st(1)
	fstpl	-16(%ebp)
L254:
	fldl	-16(%ebp)
	fldl	LC71
	fmulp	%st, %st(1)
	fldl	-96(%ebp)
	fsubl	-48(%ebp)
	fldl	-48(%ebp)
	fadd	%st(0), %st
	faddl	-96(%ebp)
	fdivrp	%st, %st(1)
	fmulp	%st, %st(1)
	fstpl	-112(%ebp)
	fldl	-40(%ebp)
	fldl	LC72
	fmulp	%st, %st(1)
	fstpl	-120(%ebp)
	fldl	-104(%ebp)
	faddl	-112(%ebp)
	fchs
	fstpl	-128(%ebp)
	fldl	-104(%ebp)
	fmull	-112(%ebp)
	fstpl	-136(%ebp)
	fldl	-128(%ebp)
	fmul	%st(0), %st
	fldl	-136(%ebp)
	fldl	LC73
	fmulp	%st, %st(1)
	fsubrp	%st, %st(1)
	fstpl	-144(%ebp)
	fldl	-144(%ebp)
	fldz
	fucomip	%st(1), %st
	fstp	%st(0)
	jp	L255
	fldl	-144(%ebp)
	fldz
	fucomip	%st(1), %st
	fstp	%st(0)
	jne	L255
	fldl	-128(%ebp)
	fchs
	fldl	LC74
	fdivrp	%st, %st(1)
	fstpl	-32(%ebp)
	jmp	L257
L255:
	fldl	-144(%ebp)
	fldz
	fxch	%st(1)
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L272
	fldl	-128(%ebp)
	fchs
	fldl	-144(%ebp)
	fsqrt
	fsubrp	%st, %st(1)
	fldl	LC74
	fdivrp	%st, %st(1)
	fstpl	-152(%ebp)
	fldl	-144(%ebp)
	fsqrt
	fsubl	-128(%ebp)
	fldl	LC74
	fdivrp	%st, %st(1)
	fstpl	-160(%ebp)
	fldl	-152(%ebp)
	fstps	-220(%ebp)
	flds	-220(%ebp)
	fldl	-160(%ebp)
	fstps	-220(%ebp)
	flds	-220(%ebp)
	fxch	%st(1)
	fucomi	%st(1), %st
	fstp	%st(1)
	seta	%al
	movzbl	%al, %eax
	fucomi	%st(0), %st
	setp	%dl
	movzbl	%dl, %edx
	andl	$1, %edx
	orl	%edx, %eax
	testl	%eax, %eax
	je	L260
	fstp	%st(0)
	fldl	-160(%ebp)
	fstps	-220(%ebp)
	flds	-220(%ebp)
L260:
	fstpl	-32(%ebp)
	jmp	L257
L272:
	fldz
	fstpl	-32(%ebp)
L257:
	fldl	-32(%ebp)
	faddl	-120(%ebp)
	fchs
	fstpl	-168(%ebp)
	fldl	-32(%ebp)
	fmull	-120(%ebp)
	fstpl	-176(%ebp)
	fldl	-168(%ebp)
	fmul	%st(0), %st
	fldl	-176(%ebp)
	fldl	LC75
	fmulp	%st, %st(1)
	fsubrp	%st, %st(1)
	fstpl	-184(%ebp)
	fldl	-184(%ebp)
	fldz
	fucomip	%st(1), %st
	fstp	%st(0)
	jp	L261
	fldl	-184(%ebp)
	fldz
	fucomip	%st(1), %st
	fstp	%st(0)
	jne	L261
	fldl	-168(%ebp)
	fchs
	fldl	LC76
	fdivrp	%st, %st(1)
	fstpl	-24(%ebp)
	jmp	L263
L261:
	fldl	-184(%ebp)
	fldz
	fxch	%st(1)
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L273
	fldl	-168(%ebp)
	fchs
	fldl	-184(%ebp)
	fsqrt
	fsubrp	%st, %st(1)
	fldl	LC76
	fdivrp	%st, %st(1)
	fstpl	-192(%ebp)
	fldl	-184(%ebp)
	fsqrt
	fsubl	-168(%ebp)
	fldl	LC76
	fdivrp	%st, %st(1)
	fstpl	-200(%ebp)
	fldl	-192(%ebp)
	fstps	-220(%ebp)
	flds	-220(%ebp)
	fldl	-200(%ebp)
	fstps	-220(%ebp)
	flds	-220(%ebp)
	fxch	%st(1)
	fucomi	%st(1), %st
	fstp	%st(1)
	seta	%al
	movzbl	%al, %eax
	fucomi	%st(0), %st
	setp	%dl
	movzbl	%dl, %edx
	andl	$1, %edx
	orl	%edx, %eax
	testl	%eax, %eax
	je	L266
	fstp	%st(0)
	fldl	-200(%ebp)
	fstps	-220(%ebp)
	flds	-220(%ebp)
L266:
	fstpl	-24(%ebp)
	jmp	L263
L273:
	fldz
	fstpl	-24(%ebp)
L263:
	fldl	-24(%ebp)
	fstps	-204(%ebp)
	flds	-204(%ebp)
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE14:
	.globl	___photo_MOD_vapor_p_defcit
	.def	___photo_MOD_vapor_p_defcit;	.scl	2;	.type	32;	.endef
___photo_MOD_vapor_p_defcit:
LFB15:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$56, %esp
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	___photo_MOD_tetens
	fstps	-28(%ebp)
	movl	-28(%ebp), %eax
	movl	%eax, -12(%ebp)
	movl	12(%ebp), %eax
	flds	(%eax)
	fmuls	-12(%ebp)
	fstps	-16(%ebp)
	flds	-12(%ebp)
	fsubs	-16(%ebp)
	flds	LC26
	fdivrp	%st, %st(1)
	fstps	-20(%ebp)
	flds	-20(%ebp)
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE15:
	.globl	___photo_MOD_water_ue
	.def	___photo_MOD_water_ue;	.scl	2;	.type	32;	.endef
___photo_MOD_water_ue:
LFB16:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	12(%ebp), %eax
	flds	(%eax)
	fld1
	fdivp	%st, %st(1)
	flds	LC77
	fmulp	%st, %st(1)
	fstps	-4(%ebp)
	movl	16(%ebp), %eax
	flds	(%eax)
	flds	LC26
	fdivrp	%st, %st(1)
	fstps	-8(%ebp)
	movl	20(%ebp), %eax
	flds	(%eax)
	fdivs	-8(%ebp)
	fmuls	-4(%ebp)
	fstps	-12(%ebp)
	movl	8(%ebp), %eax
	flds	(%eax)
	fdivs	-12(%ebp)
	fstps	-16(%ebp)
	flds	-16(%ebp)
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE16:
	.section .rdata,"dr"
	.align 4
LC78:
	.ascii "vpd less than zero in canopy_resistence"
	.text
	.globl	___photo_MOD_canopy_resistence
	.def	___photo_MOD_canopy_resistence;	.scl	2;	.type	32;	.endef
___photo_MOD_canopy_resistence:
LFB17:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$424, %esp
	movl	8(%ebp), %eax
	flds	(%eax)
	fldz
	fucomip	%st(1), %st
	fstp	%st(0)
	jb	L283
	movl	$LC9, -376(%ebp)
	movl	$244, -372(%ebp)
	movl	$128, -384(%ebp)
	movl	$6, -380(%ebp)
	leal	-384(%ebp), %eax
	movl	%eax, (%esp)
	call	__gfortran_st_write
	movl	$39, 8(%esp)
	movl	$LC78, 4(%esp)
	leal	-384(%ebp), %eax
	movl	%eax, (%esp)
	call	__gfortran_transfer_character_write
	leal	-384(%ebp), %eax
	movl	%eax, (%esp)
	call	__gfortran_st_write_done
	movl	$0, 4(%esp)
	movl	$0, (%esp)
	call	__gfortran_stop_string
L283:
	movl	8(%ebp), %eax
	flds	(%eax)
	fsqrt
	fstpl	-16(%ebp)
	movl	16(%ebp), %eax
	flds	(%eax)
	fdivl	-16(%ebp)
	fld1
	faddp	%st, %st(1)
	fldl	LC79
	fmulp	%st, %st(1)
	movl	12(%ebp), %eax
	flds	(%eax)
	flds	LC80
	fmulp	%st, %st(1)
	flds	LC81
	fdivrp	%st, %st(1)
	fmulp	%st, %st(1)
	fldl	LC82
	faddp	%st, %st(1)
	fstpl	-24(%ebp)
	fldl	-24(%ebp)
	fldl	LC83
	fdivrp	%st, %st(1)
	fld1
	fdivp	%st, %st(1)
	fstps	-28(%ebp)
	flds	-28(%ebp)
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE17:
	.globl	___photo_MOD_water_stress_modifier
	.def	___photo_MOD_water_stress_modifier;	.scl	2;	.type	32;	.endef
___photo_MOD_water_stress_modifier:
LFB18:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$88, %esp
	movl	8(%ebp), %eax
	flds	(%eax)
	flds	LC84
	fdivrp	%st, %st(1)
	fstpl	-32(%ebp)
	movl	12(%ebp), %eax
	flds	(%eax)
	flds	LC40
	fmulp	%st, %st(1)
	fldl	LC72
	fmulp	%st, %st(1)
	fmull	-32(%ebp)
	fstpl	-40(%ebp)
	movl	16(%ebp), %eax
	flds	(%eax)
	fldz
	fxch	%st(1)
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L297
	movl	16(%ebp), %eax
	flds	(%eax)
	flds	LC85
	fmulp	%st, %st(1)
	fld1
	fdivp	%st, %st(1)
	fstpl	-24(%ebp)
	jmp	L287
L297:
	fldl	LC86
	fstpl	-24(%ebp)
L287:
	movl	20(%ebp), %eax
	flds	(%eax)
	fldl	LC87
	fmulp	%st, %st(1)
	fldl	LC88
	fdivl	-24(%ebp)
	fld1
	faddp	%st, %st(1)
	fdivrp	%st, %st(1)
	fstpl	-48(%ebp)
	fldl	-48(%ebp)
	fldz
	fxch	%st(1)
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L298
	fldl	-40(%ebp)
	fdivl	-48(%ebp)
	fstpl	-16(%ebp)
	fldl	-16(%ebp)
	fldl	LC89
	fmulp	%st, %st(1)
	fchs
	fstpl	(%esp)
	call	_exp
	fstpl	-16(%ebp)
	fld1
	fsubl	-16(%ebp)
	fstpl	-16(%ebp)
	jmp	L290
L298:
	fldl	-32(%ebp)
	fstpl	-16(%ebp)
L290:
	fldz
	fldl	-16(%ebp)
	fxch	%st(1)
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L291
	fldl	-32(%ebp)
	fstpl	-16(%ebp)
L291:
	fldl	-16(%ebp)
	fstps	-52(%ebp)
	flds	-52(%ebp)
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE18:
	.globl	___photo_MOD_spec_leaf_area
	.def	___photo_MOD_spec_leaf_area;	.scl	2;	.type	32;	.endef
___photo_MOD_spec_leaf_area:
LFB19:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$56, %esp
	movl	8(%ebp), %eax
	flds	(%eax)
	flds	LC90
	fmulp	%st, %st(1)
	fstps	-12(%ebp)
	flds	-12(%ebp)
	flds	LC91
	fdivrp	%st, %st(1)
	fstps	-16(%ebp)
	flds	-16(%ebp)
	fadd	%st(0), %st
	fstps	4(%esp)
	flds	LC26
	fstps	(%esp)
	call	_powf
	fstps	-28(%ebp)
	movl	-28(%ebp), %eax
	movl	%eax, -28(%ebp)
	flds	-28(%ebp)
	flds	LC92
	fmulp	%st, %st(1)
	fstps	-20(%ebp)
	flds	LC2
	fdivs	-20(%ebp)
	flds	LC93
	fstps	4(%esp)
	fstps	(%esp)
	call	_powf
	flds	LC94
	fmulp	%st, %st(1)
	fstps	-24(%ebp)
	flds	-24(%ebp)
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE19:
	.globl	___photo_MOD_f_four
	.def	___photo_MOD_f_four;	.scl	2;	.type	32;	.endef
___photo_MOD_f_four:
LFB20:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$72, %esp
	movl	16(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	call	___photo_MOD_leaf_area_index
	fstps	-48(%ebp)
	movl	-48(%ebp), %eax
	movl	%eax, -12(%ebp)
	flds	-12(%ebp)
	fldl	LC72
	fmulp	%st, %st(1)
	fchs
	fstpl	(%esp)
	call	_exp
	fld1
	fsubp	%st, %st(1)
	fldl	LC72
	fdivrp	%st, %st(1)
	fstpl	-24(%ebp)
	fldl	-24(%ebp)
	fstps	-28(%ebp)
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	cmpl	$90, %eax
	jne	L302
	flds	-28(%ebp)
	jmp	L303
L302:
	flds	-12(%ebp)
	fsubl	-24(%ebp)
	fstpl	-40(%ebp)
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	cmpl	$20, %eax
	jne	L304
	fldl	-40(%ebp)
	fstps	-28(%ebp)
	flds	-28(%ebp)
	jmp	L303
L304:
	fldl	-24(%ebp)
	fstps	-28(%ebp)
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	cmpl	$3, %eax
	jne	L305
	flds	-28(%ebp)
	jmp	L303
L305:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	cmpl	$1, %eax
	jne	L306
	fldl	-24(%ebp)
	fldl	LC72
	fmulp	%st, %st(1)
	fchs
	fstpl	(%esp)
	call	_exp
	fld1
	fsubp	%st, %st(1)
	fldl	LC72
	fdivrp	%st, %st(1)
	fstps	-28(%ebp)
	flds	-28(%ebp)
	jmp	L303
L306:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	cmpl	$2, %eax
	jne	L307
	fldl	-40(%ebp)
	fldl	LC95
	fmulp	%st, %st(1)
	fchs
	fstpl	(%esp)
	call	_exp
	fld1
	fsubp	%st, %st(1)
	fldl	LC95
	fdivrp	%st, %st(1)
	fstps	-28(%ebp)
	flds	-28(%ebp)
	jmp	L303
L307:
	flds	-28(%ebp)
L303:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE20:
	.globl	___photo_MOD_leaf_area_index
	.def	___photo_MOD_leaf_area_index;	.scl	2;	.type	32;	.endef
___photo_MOD_leaf_area_index:
LFB21:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	8(%ebp), %eax
	flds	(%eax)
	flds	LC40
	fmulp	%st, %st(1)
	movl	12(%ebp), %eax
	flds	(%eax)
	fmulp	%st, %st(1)
	fstps	-4(%ebp)
	flds	-4(%ebp)
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE21:
	.section .rdata,"dr"
	.align 4
LC96:
	.long	1
	.align 4
LC97:
	.long	2
	.text
	.globl	___photo_MOD_gross_ph
	.def	___photo_MOD_gross_ph;	.scl	2;	.type	32;	.endef
___photo_MOD_gross_ph:
LFB22:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$56, %esp
	movl	16(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$LC96, (%esp)
	call	___photo_MOD_f_four
	fstps	-28(%ebp)
	movl	-28(%ebp), %eax
	movl	%eax, -12(%ebp)
	movl	16(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$LC97, (%esp)
	call	___photo_MOD_f_four
	fstps	-28(%ebp)
	movl	-28(%ebp), %eax
	movl	%eax, -16(%ebp)
	movl	8(%ebp), %eax
	flds	(%eax)
	flds	LC98
	fmulp	%st, %st(1)
	fmuls	-12(%ebp)
	fmuls	-16(%ebp)
	fstps	-20(%ebp)
	flds	-20(%ebp)
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE22:
	.globl	___water_MOD_evpot2
	.def	___water_MOD_evpot2;	.scl	2;	.type	32;	.endef
___water_MOD_evpot2:
LFB23:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$88, %esp
	flds	LC91
	fstps	-12(%ebp)
	movl	12(%ebp), %eax
	flds	(%eax)
	fld1
	faddp	%st, %st(1)
	fstps	-52(%ebp)
	movl	12(%ebp), %eax
	flds	(%eax)
	fld1
	fsubrp	%st, %st(1)
	fstps	-56(%ebp)
	leal	-52(%ebp), %eax
	movl	%eax, (%esp)
	call	___photo_MOD_tetens
	fstps	-60(%ebp)
	movl	-60(%ebp), %eax
	movl	%eax, -16(%ebp)
	leal	-56(%ebp), %eax
	movl	%eax, (%esp)
	call	___photo_MOD_tetens
	fstps	-60(%ebp)
	movl	-60(%ebp), %eax
	movl	%eax, -20(%ebp)
	flds	-16(%ebp)
	fsubs	-20(%ebp)
	flds	-52(%ebp)
	flds	-56(%ebp)
	fsubrp	%st, %st(1)
	fdivrp	%st, %st(1)
	fstps	-24(%ebp)
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	call	___photo_MOD_tetens
	fstps	-60(%ebp)
	movl	-60(%ebp), %eax
	movl	%eax, -28(%ebp)
	movl	16(%ebp), %eax
	flds	(%eax)
	fld1
	fsubp	%st, %st(1)
	fmuls	-28(%ebp)
	fstps	-32(%ebp)
	flds	LC91
	fstps	-36(%ebp)
	movl	8(%ebp), %eax
	flds	(%eax)
	flds	LC99
	fmulp	%st, %st(1)
	flds	LC100
	fdivrp	%st, %st(1)
	fstps	-40(%ebp)
	flds	-12(%ebp)
	fadds	-36(%ebp)
	fmuls	-40(%ebp)
	fdivs	-12(%ebp)
	fstps	-44(%ebp)
	movl	20(%ebp), %eax
	flds	(%eax)
	fmuls	-24(%ebp)
	flds	LC101
	fdivs	-12(%ebp)
	fmuls	-32(%ebp)
	faddp	%st, %st(1)
	flds	-24(%ebp)
	fadds	-44(%ebp)
	fdivrp	%st, %st(1)
	fstps	-48(%ebp)
	flds	-48(%ebp)
	flds	LC102
	fmulp	%st, %st(1)
	fstps	-48(%ebp)
	flds	-48(%ebp)
	fldz
	fucomip	%st(1), %st
	seta	%al
	movzbl	%al, %eax
	fucomi	%st(0), %st
	setp	%dl
	movzbl	%dl, %edx
	andl	$1, %edx
	orl	%edx, %eax
	testl	%eax, %eax
	je	L313
	fstp	%st(0)
	fldz
L313:
	fstps	-48(%ebp)
	flds	-48(%ebp)
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE23:
	.globl	___water_MOD_runoff
	.def	___water_MOD_runoff;	.scl	2;	.type	32;	.endef
___water_MOD_runoff:
LFB24:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$56, %esp
	movl	8(%ebp), %eax
	flds	(%eax)
	flds	LC103
	fstps	4(%esp)
	fstps	(%esp)
	call	_powf
	fstps	-28(%ebp)
	movl	-28(%ebp), %eax
	movl	%eax, -28(%ebp)
	flds	-28(%ebp)
	flds	LC104
	fmulp	%st, %st(1)
	fstps	-12(%ebp)
	flds	-12(%ebp)
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE24:
	.globl	___water_MOD_available_energy
	.def	___water_MOD_available_energy;	.scl	2;	.type	32;	.endef
___water_MOD_available_energy:
LFB25:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	8(%ebp), %eax
	flds	(%eax)
	flds	LC105
	fmulp	%st, %st(1)
	flds	LC106
	faddp	%st, %st(1)
	fstps	-4(%ebp)
	flds	-4(%ebp)
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE25:
	.globl	___water_MOD_penman
	.def	___water_MOD_penman;	.scl	2;	.type	32;	.endef
___water_MOD_penman:
LFB26:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$88, %esp
	flds	LC91
	fstps	-16(%ebp)
	flds	LC107
	fstps	-20(%ebp)
	movl	12(%ebp), %eax
	flds	(%eax)
	fld1
	faddp	%st, %st(1)
	fstps	-52(%ebp)
	movl	12(%ebp), %eax
	flds	(%eax)
	fld1
	fsubrp	%st, %st(1)
	fstps	-56(%ebp)
	leal	-52(%ebp), %eax
	movl	%eax, (%esp)
	call	___photo_MOD_tetens
	fstps	-60(%ebp)
	movl	-60(%ebp), %eax
	movl	%eax, -24(%ebp)
	leal	-56(%ebp), %eax
	movl	%eax, (%esp)
	call	___photo_MOD_tetens
	fstps	-60(%ebp)
	movl	-60(%ebp), %eax
	movl	%eax, -28(%ebp)
	flds	-24(%ebp)
	fsubs	-28(%ebp)
	flds	-52(%ebp)
	flds	-56(%ebp)
	fsubrp	%st, %st(1)
	fdivrp	%st, %st(1)
	fstps	-32(%ebp)
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	call	___photo_MOD_tetens
	fstps	-60(%ebp)
	movl	-60(%ebp), %eax
	movl	%eax, -36(%ebp)
	movl	16(%ebp), %eax
	flds	(%eax)
	fld1
	fsubp	%st, %st(1)
	fmuls	-36(%ebp)
	fstps	-40(%ebp)
	fld1
	fdivs	-20(%ebp)
	flds	LC108
	fsubrp	%st, %st(1)
	flds	-40(%ebp)
	fucomip	%st(1), %st
	fstp	%st(0)
	jnb	L320
	movl	24(%ebp), %eax
	flds	(%eax)
	flds	LC109
	fxch	%st(1)
	fucomip	%st(1), %st
	fstp	%st(0)
	jb	L321
L320:
	fldz
	fstps	-12(%ebp)
L321:
	fld1
	fdivs	-20(%ebp)
	flds	LC108
	fsubrp	%st, %st(1)
	flds	-40(%ebp)
	fxch	%st(1)
	fucomip	%st(1), %st
	fstp	%st(0)
	ja	L323
	movl	24(%ebp), %eax
	flds	(%eax)
	flds	LC109
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L324
L323:
	movl	8(%ebp), %eax
	flds	(%eax)
	flds	LC99
	fmulp	%st, %st(1)
	flds	LC100
	fdivrp	%st, %st(1)
	fstps	-44(%ebp)
	movl	24(%ebp), %eax
	flds	(%eax)
	fadds	-16(%ebp)
	fmuls	-44(%ebp)
	fdivs	-16(%ebp)
	fstps	-48(%ebp)
	movl	20(%ebp), %eax
	flds	(%eax)
	fmuls	-32(%ebp)
	flds	LC101
	fdivs	-16(%ebp)
	fmuls	-40(%ebp)
	faddp	%st, %st(1)
	flds	-32(%ebp)
	fadds	-48(%ebp)
	fdivrp	%st, %st(1)
	fstps	-12(%ebp)
	flds	-12(%ebp)
	flds	LC102
	fmulp	%st, %st(1)
	fstps	-12(%ebp)
	flds	-12(%ebp)
	fldz
	fucomip	%st(1), %st
	seta	%al
	movzbl	%al, %eax
	fucomi	%st(0), %st
	setp	%dl
	movzbl	%dl, %edx
	andl	$1, %edx
	orl	%edx, %eax
	testl	%eax, %eax
	je	L326
	fstp	%st(0)
	fldz
L326:
	fstps	-12(%ebp)
L324:
	flds	-12(%ebp)
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE26:
	.globl	___water_MOD_soil_temp
	.def	___water_MOD_soil_temp;	.scl	2;	.type	32;	.endef
___water_MOD_soil_temp:
LFB27:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	8(%ebp), %eax
	flds	(%eax)
	fldz
	fmulp	%st, %st(1)
	fld1
	faddp	%st, %st(1)
	movl	12(%ebp), %eax
	flds	(%eax)
	fmulp	%st, %st(1)
	fstps	_t1.3960
	movl	8(%ebp), %eax
	flds	(%eax)
	flds	_t1.3960
	faddp	%st, %st(1)
	flds	LC55
	fdivrp	%st, %st(1)
	fstps	-4(%ebp)
	flds	-4(%ebp)
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE27:
	.globl	___water_MOD_soil_temp_sub
	.def	___water_MOD_soil_temp_sub;	.scl	2;	.type	32;	.endef
___water_MOD_soil_temp_sub:
LFB28:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	$1, %eax
L332:
	cmpl	$12, %eax
	jg	L331
	leal	-1(%eax), %ecx
	movl	12(%ebp), %edx
	flds	LC110
	fstps	(%edx,%ecx,4)
	addl	$1, %eax
	jmp	L332
L331:
	movl	$1, -8(%ebp)
	cmpl	$1200, -8(%ebp)
	jg	L336
L335:
	movl	-8(%ebp), %ecx
	movl	$715827883, %edx
	movl	%ecx, %eax
	imull	%edx
	sarl	%edx
	movl	%ecx, %eax
	sarl	$31, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$2, %eax
	subl	%eax, %ecx
	movl	%ecx, %eax
	movl	%eax, -4(%ebp)
	cmpl	$0, -4(%ebp)
	jne	L334
	movl	$12, -4(%ebp)
L334:
	flds	_t0.3964
	fldz
	fmulp	%st, %st(1)
	fld1
	faddp	%st, %st(1)
	movl	-4(%ebp), %eax
	leal	-1(%eax), %edx
	movl	8(%ebp), %eax
	flds	(%eax,%edx,4)
	fmulp	%st, %st(1)
	fstps	_t1.3965
	movl	-4(%ebp), %eax
	leal	-1(%eax), %edx
	flds	_t0.3964
	flds	_t1.3965
	faddp	%st, %st(1)
	flds	LC55
	fdivrp	%st, %st(1)
	movl	12(%ebp), %eax
	fstps	(%eax,%edx,4)
	flds	_t1.3965
	fstps	_t0.3964
	cmpl	$1200, -8(%ebp)
	sete	%al
	movzbl	%al, %eax
	addl	$1, -8(%ebp)
	testl	%eax, %eax
	jne	L336
	jmp	L335
L336:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE28:
.lcomm _scl2_128.3521,16,16
.lcomm _scf2_128.3520,16,16
.lcomm _sca2_128.3519,16,16
.lcomm _cleafi_aux.3603,146100,32
.lcomm _cawoodi_aux.3599,146100,32
.lcomm _cfrooti_aux.3601,146100,32
.lcomm _cleafi_aux.3647,146100,32
.lcomm _cawoodi_aux.3643,146100,32
.lcomm _cfrooti_aux.3645,146100,32
.lcomm _t1.3960,4,4
.lcomm _t0.3964,4,4
.lcomm _t1.3965,4,4
	.section .rdata,"dr"
	.align 4
LC0:
	.long	1000593162
	.align 4
LC2:
	.long	1136033792
	.align 4
LC18:
	.long	1065361605
	.align 4
LC19:
	.long	1059648963
	.align 4
LC20:
	.long	1065354055
	.align 4
LC24:
	.long	985254760
	.align 4
LC25:
	.long	1069172549
	.align 4
LC26:
	.long	1092616192
	.align 4
LC27:
	.long	1066695393
	.align 8
LC28:
	.long	0
	.long	1077477376
	.align 8
LC29:
	.long	-1610612736
	.long	1069128089
	.align 8
LC30:
	.long	0
	.long	1073741824
	.align 8
LC31:
	.long	1073741824
	.long	1070805811
	.align 8
LC32:
	.long	-1610612736
	.long	1068079513
	.align 4
LC33:
	.long	-1054867456
	.align 4
LC34:
	.long	1112014848
	.align 8
LC35:
	.long	0
	.long	1070596096
	.align 4
LC36:
	.long	1028443341
	.align 4
LC37:
	.long	1067450368
	.align 8
LC38:
	.long	0
	.long	1072955392
	.align 8
LC39:
	.long	0
	.long	1083129856
	.align 4
LC40:
	.long	1148846080
	.align 8
LC41:
	.long	1610612736
	.long	1067558841
	.align 8
LC42:
	.long	0
	.long	1077149696
	.align 4
LC43:
	.long	1008981770
	.align 8
LC44:
	.long	-2147483648
	.long	1063834369
	.align 4
LC45:
	.long	1131053056
	.align 4
LC46:
	.long	1100311691
	.align 4
LC47:
	.long	1132499436
	.align 4
LC48:
	.long	1086559827
	.align 4
LC49:
	.long	1135008154
	.align 4
LC50:
	.long	1102596538
	.align 4
LC51:
	.long	1133242614
	.align 4
LC52:
	.long	1086558568
	.align 4
LC53:
	.long	1103626240
	.align 4
LC54:
	.long	1036831949
	.align 4
LC55:
	.long	1073741824
	.align 4
LC56:
	.long	1108344832
	.align 4
LC57:
	.long	1050253722
	.align 8
LC58:
	.long	-1610612736
	.long	1071791472
	.align 8
LC59:
	.long	0
	.long	1085558784
	.align 8
LC60:
	.long	0
	.long	1087681536
	.align 8
LC61:
	.long	-1073741824
	.long	1073794252
	.align 8
LC62:
	.long	0
	.long	1077805056
	.align 8
LC63:
	.long	1073741824
	.long	1072902963
	.align 8
LC64:
	.long	0
	.long	1088244736
	.align 8
LC65:
	.long	-2147483648
	.long	1071900524
	.align 8
LC66:
	.long	-1073741824
	.long	1070868725
	.align 8
LC68:
	.long	-1073741824
	.long	1072483532
	.align 8
LC69:
	.long	-1610612736
	.long	1078045899
	.align 4
LC70:
	.long	1045220557
	.align 8
LC71:
	.long	-1483911200
	.long	1068591218
	.align 8
LC72:
	.long	0
	.long	1071644672
	.align 8
LC73:
	.long	536870912
	.long	1074433884
	.align 8
LC74:
	.long	536870912
	.long	1073385308
	.align 8
LC75:
	.long	1610612736
	.long	1074643599
	.align 8
LC76:
	.long	1610612736
	.long	1073595023
	.align 4
LC77:
	.long	1109655552
	.align 8
LC79:
	.long	-1610612736
	.long	1073322393
	.align 4
LC80:
	.long	1232348160
	.align 4
LC81:
	.long	1135542272
	.align 8
LC82:
	.long	-536870912
	.long	1062232653
	.align 8
LC83:
	.long	0
	.long	1078231040
	.align 4
LC84:
	.long	1140457472
	.align 4
LC85:
	.long	843503470
	.align 8
LC86:
	.long	536870912
	.long	1093295612
	.align 8
LC87:
	.long	1073741824
	.long	1073103241
	.align 8
LC88:
	.long	0
	.long	1091645696
	.align 8
LC89:
	.long	-536870912
	.long	1068415057
	.align 4
LC90:
	.long	1094713344
	.align 4
LC91:
	.long	1120403456
	.align 4
LC92:
	.long	1106466133
	.align 4
LC93:
	.long	-1091861217
	.align 4
LC94:
	.long	1022739087
	.align 8
LC95:
	.long	0
	.long	1073217536
	.align 4
LC98:
	.long	1220077671
	.align 4
LC99:
	.long	1148911616
	.align 4
LC100:
	.long	1236927968
	.align 4
LC101:
	.long	1150720410
	.align 4
LC102:
	.long	1024488027
	.align 4
LC103:
	.long	1087583027
	.align 4
LC104:
	.long	1094189056
	.align 4
LC105:
	.long	1077495726
	.align 4
LC106:
	.long	1112624595
	.align 4
LC107:
	.long	1021396910
	.align 4
LC108:
	.long	1056964608
	.align 4
LC109:
	.long	1138819072
	.align 4
LC110:
	.long	-971228160
	.ident	"GCC: (GNU) 6.4.0"
	.def	__gfortran_runtime_error;	.scl	2;	.type	32;	.endef
	.def	__gfortran_runtime_error_at;	.scl	2;	.type	32;	.endef
	.def	_malloc;	.scl	2;	.type	32;	.endef
	.def	__gfortran_os_error;	.scl	2;	.type	32;	.endef
	.def	__gfortran_st_open;	.scl	2;	.type	32;	.endef
	.def	__gfortran_st_read;	.scl	2;	.type	32;	.endef
	.def	__gfortran_transfer_real;	.scl	2;	.type	32;	.endef
	.def	__gfortran_st_read_done;	.scl	2;	.type	32;	.endef
	.def	__gfortran_st_write;	.scl	2;	.type	32;	.endef
	.def	__gfortran_transfer_array_write;	.scl	2;	.type	32;	.endef
	.def	__gfortran_st_write_done;	.scl	2;	.type	32;	.endef
	.def	__gfortran_st_close;	.scl	2;	.type	32;	.endef
	.def	_free;	.scl	2;	.type	32;	.endef
	.def	__gfortran_transfer_array;	.scl	2;	.type	32;	.endef
	.def	__gfortran_maxloc0_4_r4;	.scl	2;	.type	32;	.endef
	.def	__gfortran_maxloc0_4_r4;	.scl	2;	.type	32;	.endef
	.def	_powf;	.scl	2;	.type	32;	.endef
	.def	_pow;	.scl	2;	.type	32;	.endef
	.def	_expf;	.scl	2;	.type	32;	.endef
	.def	__gfortran_transfer_character_write;	.scl	2;	.type	32;	.endef
	.def	__gfortran_stop_string;	.scl	2;	.type	32;	.endef
	.def	_exp;	.scl	2;	.type	32;	.endef

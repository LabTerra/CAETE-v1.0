	.file	"budget.f90"
	.text
	.globl	___budget_caete_MOD_budget
	.def	___budget_caete_MOD_budget;	.scl	2;	.type	32;	.endef
___budget_caete_MOD_budget:
LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$2140, %esp
	.cfi_offset 7, -12
	.cfi_offset 6, -16
	.cfi_offset 3, -20
	movl	$1, -32(%ebp)
	cmpl	$12, -32(%ebp)
	jg	L2
L3:
	movl	-32(%ebp), %eax
	subl	$1, %eax
	fldz
	fstps	-1524(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	fldz
	fstps	-1044(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	fldz
	fstps	-1092(%ebp,%eax,4)
	cmpl	$12, -32(%ebp)
	sete	%al
	movzbl	%al, %eax
	addl	$1, -32(%ebp)
	testl	%eax, %eax
	jne	L2
	jmp	L3
L2:
	fld1
	fchs
	fstps	-44(%ebp)
	flds	LC2
	fstps	-48(%ebp)
	fldz
	fstps	-40(%ebp)
	fldz
	fstps	-36(%ebp)
	movl	32(%ebp), %eax
	flds	(%eax)
	flds	-44(%ebp)
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L44
	movl	36(%ebp), %eax
	flds	(%eax)
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	subl	$1, %eax
	movl	_ndmonth.3465(,%eax,4), %eax
	movl	%eax, -1980(%ebp)
	fildl	-1980(%ebp)
	fdivrp	%st, %st(1)
	fstps	-40(%ebp)
	jmp	L6
L44:
	movl	36(%ebp), %eax
	flds	(%eax)
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	subl	$1, %eax
	movl	_ndmonth.3465(,%eax,4), %eax
	movl	%eax, -1980(%ebp)
	fildl	-1980(%ebp)
	fdivrp	%st, %st(1)
	fstps	-36(%ebp)
L6:
	movl	88(%ebp), %eax
	fldz
	fstps	(%eax)
	movl	$1, -32(%ebp)
	cmpl	$12, -32(%ebp)
	jg	L7
L8:
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	16(%ebp), %eax
	flds	(%eax,%ecx,4)
	fstps	-1908(%ebp,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	20(%ebp), %eax
	flds	(%eax,%ecx,4)
	fstps	-1140(%ebp,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	24(%ebp), %eax
	flds	(%eax,%ecx,4)
	fstps	-1764(%ebp,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	76(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	80(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	84(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	120(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	104(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	92(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	96(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	100(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	108(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	112(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	116(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	124(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	128(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	144(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	148(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	152(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	fldz
	fstps	-1380(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	LC3
	fstps	-192(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	LC3
	fstps	-96(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	LC3
	fstps	-144(%ebp,%eax,4)
	cmpl	$12, -32(%ebp)
	sete	%al
	movzbl	%al, %eax
	addl	$1, -32(%ebp)
	testl	%eax, %eax
	jne	L7
	jmp	L8
L7:
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	subl	$1, %eax
	movl	_ndmonth.3465(,%eax,4), %eax
	movl	%eax, -1980(%ebp)
	movl	$1, -28(%ebp)
	cmpl	%eax, -28(%ebp)
	jg	L9
L33:
	fldz
	fstps	-948(%ebp)
	leal	-672(%ebp), %eax
	movl	52(%ebp), %edx
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
	leal	-432(%ebp), %eax
	movl	56(%ebp), %edx
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
	leal	-528(%ebp), %eax
	movl	60(%ebp), %edx
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
	movl	-192(%ebp), %eax
	movl	%eax, -384(%ebp)
	movl	-188(%ebp), %eax
	movl	%eax, -380(%ebp)
	movl	-184(%ebp), %eax
	movl	%eax, -376(%ebp)
	movl	-180(%ebp), %eax
	movl	%eax, -372(%ebp)
	movl	-176(%ebp), %eax
	movl	%eax, -368(%ebp)
	movl	-172(%ebp), %eax
	movl	%eax, -364(%ebp)
	movl	-168(%ebp), %eax
	movl	%eax, -360(%ebp)
	movl	-164(%ebp), %eax
	movl	%eax, -356(%ebp)
	movl	-160(%ebp), %eax
	movl	%eax, -352(%ebp)
	movl	-156(%ebp), %eax
	movl	%eax, -348(%ebp)
	movl	-152(%ebp), %eax
	movl	%eax, -344(%ebp)
	movl	-148(%ebp), %eax
	movl	%eax, -340(%ebp)
	movl	-96(%ebp), %eax
	movl	%eax, -288(%ebp)
	movl	-92(%ebp), %eax
	movl	%eax, -284(%ebp)
	movl	-88(%ebp), %eax
	movl	%eax, -280(%ebp)
	movl	-84(%ebp), %eax
	movl	%eax, -276(%ebp)
	movl	-80(%ebp), %eax
	movl	%eax, -272(%ebp)
	movl	-76(%ebp), %eax
	movl	%eax, -268(%ebp)
	movl	-72(%ebp), %eax
	movl	%eax, -264(%ebp)
	movl	-68(%ebp), %eax
	movl	%eax, -260(%ebp)
	movl	-64(%ebp), %eax
	movl	%eax, -256(%ebp)
	movl	-60(%ebp), %eax
	movl	%eax, -252(%ebp)
	movl	-56(%ebp), %eax
	movl	%eax, -248(%ebp)
	movl	-52(%ebp), %eax
	movl	%eax, -244(%ebp)
	movl	-144(%ebp), %eax
	movl	%eax, -336(%ebp)
	movl	-140(%ebp), %eax
	movl	%eax, -332(%ebp)
	movl	-136(%ebp), %eax
	movl	%eax, -328(%ebp)
	movl	-132(%ebp), %eax
	movl	%eax, -324(%ebp)
	movl	-128(%ebp), %eax
	movl	%eax, -320(%ebp)
	movl	-124(%ebp), %eax
	movl	%eax, -316(%ebp)
	movl	-120(%ebp), %eax
	movl	%eax, -312(%ebp)
	movl	-116(%ebp), %eax
	movl	%eax, -308(%ebp)
	movl	-112(%ebp), %eax
	movl	%eax, -304(%ebp)
	movl	-108(%ebp), %eax
	movl	%eax, -300(%ebp)
	movl	-104(%ebp), %eax
	movl	%eax, -296(%ebp)
	movl	-100(%ebp), %eax
	movl	%eax, -292(%ebp)
	leal	-1284(%ebp), %edx
	movl	$0, %eax
	movl	$12, %ecx
	movl	%edx, %edi
	rep stosl
	leal	-1476(%ebp), %edx
	movl	$0, %eax
	movl	$12, %ecx
	movl	%edx, %edi
	rep stosl
	leal	-240(%ebp), %edx
	movl	$0, %eax
	movl	$12, %ecx
	movl	%edx, %edi
	rep stosl
	leal	-1236(%ebp), %edx
	movl	$0, %eax
	movl	$12, %ecx
	movl	%edx, %edi
	rep stosl
	leal	-1092(%ebp), %edx
	movl	$0, %eax
	movl	$12, %ecx
	movl	%edx, %edi
	rep stosl
	leal	-1044(%ebp), %edx
	movl	$0, %eax
	movl	$12, %ecx
	movl	%edx, %edi
	rep stosl
	leal	-1860(%ebp), %edx
	movl	$0, %eax
	movl	$12, %ecx
	movl	%edx, %edi
	rep stosl
	leal	-1524(%ebp), %edx
	movl	$0, %eax
	movl	$12, %ecx
	movl	%edx, %edi
	rep stosl
	leal	-1668(%ebp), %edx
	movl	$0, %eax
	movl	$12, %ecx
	movl	%edx, %edi
	rep stosl
	leal	-1572(%ebp), %edx
	movl	$0, %eax
	movl	$12, %ecx
	movl	%edx, %edi
	rep stosl
	leal	-1956(%ebp), %edx
	movl	$0, %eax
	movl	$12, %ecx
	movl	%edx, %edi
	rep stosl
	leal	-816(%ebp), %edx
	movl	$0, %eax
	movl	$12, %ecx
	movl	%edx, %edi
	rep stosl
	leal	-1428(%ebp), %eax
	movl	%eax, 16(%esp)
	leal	-1332(%ebp), %eax
	movl	%eax, 12(%esp)
	leal	-432(%ebp), %eax
	movl	%eax, 8(%esp)
	leal	-528(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-672(%ebp), %eax
	movl	%eax, (%esp)
	call	___photo_MOD_pft_area_frac
	movl	32(%ebp), %eax
	movl	%eax, (%esp)
	call	___water_MOD_available_energy
	fstps	-1984(%ebp)
	movl	-1984(%ebp), %eax
	movl	%eax, -1960(%ebp)
	leal	-1960(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	48(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	32(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	40(%ebp), %eax
	movl	%eax, (%esp)
	call	___water_MOD_evpot2
	fstps	-1984(%ebp)
	movl	-1984(%ebp), %eax
	movl	%eax, -948(%ebp)
	movl	$1, -32(%ebp)
	cmpl	$12, -32(%ebp)
	jg	L10
L32:
	movl	$0, _end_pls.3450
	movl	-32(%ebp), %eax
	sall	$3, %eax
	leal	-9(%eax), %esi
	movl	$1, %eax
L12:
	cmpl	$8, %eax
	jg	L11
	leal	-1(%eax), %edx
	leal	(%eax,%esi), %ebx
	movl	8(%ebp), %ecx
	flds	(%ecx,%ebx,4)
	fstps	-896(%ebp,%edx,4)
	addl	$1, %eax
	jmp	L12
L11:
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-1332(%ebp,%eax,4)
	fstps	_ocp.3469
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	leal	-1956(%ebp), %eax
	sall	$2, %edx
	addl	%edx, %eax
	movl	%eax, -1984(%ebp)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	leal	-1524(%ebp), %eax
	sall	$2, %edx
	leal	(%eax,%edx), %esi
	movl	%esi, -1988(%ebp)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	leal	-1572(%ebp), %eax
	sall	$2, %edx
	leal	(%eax,%edx), %ebx
	movl	%ebx, -1992(%ebp)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	leal	-1668(%ebp), %eax
	sall	$2, %edx
	leal	(%eax,%edx), %edi
	movl	%edi, -1996(%ebp)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	leal	-1860(%ebp), %edx
	sall	$2, %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, -2000(%ebp)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	leal	-1044(%ebp), %edx
	sall	$2, %eax
	addl	%eax, %edx
	movl	%edx, -2004(%ebp)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	leal	-1092(%ebp), %edx
	sall	$2, %eax
	leal	(%edx,%eax), %esi
	movl	%esi, -2008(%ebp)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	leal	-1236(%ebp), %edx
	sall	$2, %eax
	leal	(%edx,%eax), %ebx
	movl	%ebx, -2012(%ebp)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	leal	-1284(%ebp), %edx
	sall	$2, %eax
	leal	(%edx,%eax), %edi
	movl	%edi, -2016(%ebp)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	leal	-240(%ebp), %edx
	sall	$2, %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, -2020(%ebp)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	leal	-1476(%ebp), %edx
	sall	$2, %eax
	addl	%eax, %edx
	movl	%edx, -2024(%ebp)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	leal	-336(%ebp), %edx
	sall	$2, %eax
	leal	(%edx,%eax), %esi
	movl	%esi, -2028(%ebp)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	leal	-288(%ebp), %edx
	sall	$2, %eax
	leal	(%edx,%eax), %ebx
	movl	%ebx, -2032(%ebp)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	leal	-384(%ebp), %edx
	sall	$2, %eax
	leal	(%edx,%eax), %edi
	movl	%edi, -2036(%ebp)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	leal	-528(%ebp), %edx
	sall	$2, %eax
	leal	(%edx,%eax), %edi
	movl	-32(%ebp), %eax
	subl	$1, %eax
	leal	-432(%ebp), %edx
	sall	$2, %eax
	leal	(%edx,%eax), %esi
	movl	-32(%ebp), %eax
	subl	$1, %eax
	leal	-672(%ebp), %edx
	sall	$2, %eax
	leal	(%edx,%eax), %ebx
	movl	-32(%ebp), %eax
	subl	$1, %eax
	leal	-1908(%ebp), %edx
	sall	$2, %eax
	leal	(%edx,%eax), %ecx
	movl	-32(%ebp), %eax
	subl	$1, %eax
	leal	-1428(%ebp), %edx
	sall	$2, %eax
	addl	%eax, %edx
	movl	-1984(%ebp), %eax
	movl	%eax, 100(%esp)
	movl	-1988(%ebp), %eax
	movl	%eax, 96(%esp)
	movl	-1992(%ebp), %eax
	movl	%eax, 92(%esp)
	movl	-1996(%ebp), %eax
	movl	%eax, 88(%esp)
	movl	-2000(%ebp), %eax
	movl	%eax, 84(%esp)
	movl	-2004(%ebp), %eax
	movl	%eax, 80(%esp)
	movl	-2008(%ebp), %eax
	movl	%eax, 76(%esp)
	movl	-2012(%ebp), %eax
	movl	%eax, 72(%esp)
	movl	-2016(%ebp), %eax
	movl	%eax, 68(%esp)
	movl	-2020(%ebp), %eax
	movl	%eax, 64(%esp)
	movl	-2024(%ebp), %eax
	movl	%eax, 60(%esp)
	movl	$_ocp.3469, 56(%esp)
	movl	-2028(%ebp), %eax
	movl	%eax, 52(%esp)
	movl	-2032(%ebp), %eax
	movl	%eax, 48(%esp)
	movl	-2036(%ebp), %eax
	movl	%eax, 44(%esp)
	movl	%edi, 40(%esp)
	movl	%esi, 36(%esp)
	movl	%ebx, 32(%esp)
	leal	-948(%ebp), %eax
	movl	%eax, 28(%esp)
	movl	48(%ebp), %eax
	movl	%eax, 24(%esp)
	movl	44(%ebp), %eax
	movl	%eax, 20(%esp)
	movl	%ecx, 16(%esp)
	movl	40(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	32(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	%edx, 4(%esp)
	leal	-896(%ebp), %eax
	movl	%eax, (%esp)
	call	___productivity_MOD_prod
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	leal	-576(%ebp), %eax
	sall	$2, %edx
	leal	(%eax,%edx), %esi
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	leal	-480(%ebp), %eax
	sall	$2, %edx
	addl	%edx, %eax
	movl	%eax, -1984(%ebp)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	leal	-720(%ebp), %eax
	sall	$2, %edx
	leal	(%eax,%edx), %ebx
	movl	%ebx, -1988(%ebp)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	leal	-528(%ebp), %eax
	sall	$2, %edx
	leal	(%eax,%edx), %edi
	movl	-32(%ebp), %eax
	subl	$1, %eax
	leal	-432(%ebp), %edx
	sall	$2, %eax
	leal	(%edx,%eax), %ebx
	movl	-32(%ebp), %eax
	subl	$1, %eax
	leal	-672(%ebp), %edx
	sall	$2, %eax
	leal	(%edx,%eax), %ecx
	movl	-32(%ebp), %eax
	subl	$1, %eax
	leal	-1284(%ebp), %edx
	sall	$2, %eax
	addl	%edx, %eax
	movl	$_end_pls.3450, 32(%esp)
	movl	%esi, 28(%esp)
	movl	-1984(%ebp), %esi
	movl	%esi, 24(%esp)
	movl	-1988(%ebp), %esi
	movl	%esi, 20(%esp)
	movl	%edi, 16(%esp)
	movl	%ebx, 12(%esp)
	movl	%ecx, 8(%esp)
	movl	%eax, 4(%esp)
	leal	-896(%ebp), %eax
	movl	%eax, (%esp)
	call	___photo_MOD_allocation
	movl	_end_pls.3450, %eax
	testl	%eax, %eax
	je	L13
	movl	$1, _no_cell.3466
	movl	-32(%ebp), %eax
	subl	$1, %eax
	fldz
	fstps	-192(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	fldz
	fstps	-96(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	fldz
	fstps	-144(%ebp,%eax,4)
	jmp	L14
L13:
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-1476(%ebp,%eax,4)
	fldz
	fxch	%st(1)
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L45
	movl	-32(%ebp), %eax
	subl	$1, %eax
	movl	-32(%ebp), %edx
	subl	$1, %edx
	flds	-1284(%ebp,%edx,4)
	movl	-32(%ebp), %edx
	subl	$1, %edx
	flds	-1476(%ebp,%edx,4)
	fdivrp	%st, %st(1)
	fstps	-816(%ebp,%eax,4)
	jmp	L17
L45:
	movl	-32(%ebp), %eax
	subl	$1, %eax
	fldz
	fstps	-816(%ebp,%eax,4)
L17:
	movl	-32(%ebp), %eax
	subl	$1, %eax
	movl	-32(%ebp), %edx
	subl	$1, %edx
	flds	-720(%ebp,%edx,4)
	movl	-32(%ebp), %edx
	subl	$1, %edx
	flds	-672(%ebp,%edx,4)
	fsubrp	%st, %st(1)
	fstps	-192(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	movl	-32(%ebp), %edx
	subl	$1, %edx
	flds	-480(%ebp,%edx,4)
	movl	-32(%ebp), %edx
	subl	$1, %edx
	flds	-432(%ebp,%edx,4)
	fsubrp	%st, %st(1)
	fstps	-96(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	movl	-32(%ebp), %edx
	subl	$1, %edx
	flds	-576(%ebp,%edx,4)
	movl	-32(%ebp), %edx
	subl	$1, %edx
	flds	-528(%ebp,%edx,4)
	fsubrp	%st, %st(1)
	fstps	-144(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	32(%ebp), %eax
	flds	(%eax)
	flds	LC4
	fmulp	%st, %st(1)
	flds	LC5
	faddp	%st, %st(1)
	movl	32(%ebp), %eax
	flds	(%eax)
	flds	LC6
	fmulp	%st, %st(1)
	fmuls	-36(%ebp)
	faddp	%st, %st(1)
	fstps	-1812(%ebp,%edx,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-1812(%ebp,%eax,4)
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
	je	L18
	fstp	%st(0)
	fldz
L18:
	movl	-32(%ebp), %eax
	subl	$1, %eax
	fstps	-1812(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-1812(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-1764(%ebp,%eax,4)
	fadds	-40(%ebp)
	fxch	%st(1)
	fucomi	%st(1), %st
	seta	%al
	movzbl	%al, %eax
	fucomi	%st(0), %st
	setp	%dl
	movzbl	%dl, %edx
	andl	$1, %edx
	orl	%edx, %eax
	testl	%eax, %eax
	je	L48
	fstp	%st(0)
	jmp	L19
L48:
	fstp	%st(1)
L19:
	movl	-32(%ebp), %eax
	subl	$1, %eax
	fstps	-1812(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	movl	-32(%ebp), %edx
	subl	$1, %edx
	flds	-1812(%ebp,%edx,4)
	flds	-40(%ebp)
	fsubp	%st, %st(1)
	fstps	-864(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	movl	-32(%ebp), %edx
	subl	$1, %edx
	flds	-1764(%ebp,%edx,4)
	movl	-32(%ebp), %edx
	subl	$1, %edx
	flds	-864(%ebp,%edx,4)
	faddp	%st, %st(1)
	fstps	-1764(%ebp,%eax,4)
	movl	28(%ebp), %eax
	flds	(%eax)
	flds	-48(%ebp)
	fucomip	%st(1), %st
	fstp	%st(0)
	jb	L46
	movl	-32(%ebp), %eax
	subl	$1, %eax
	movl	-32(%ebp), %edx
	subl	$1, %edx
	flds	-1140(%ebp,%edx,4)
	movl	-32(%ebp), %edx
	subl	$1, %edx
	flds	-1908(%ebp,%edx,4)
	faddp	%st, %st(1)
	fstps	-1140(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	fldz
	fstps	-1908(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	movl	-32(%ebp), %edx
	subl	$1, %edx
	flds	-1812(%ebp,%edx,4)
	fadds	-36(%ebp)
	fstps	-1716(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	fldz
	fstps	-996(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	fldz
	fstps	-1476(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	fldz
	fstps	-240(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	fldz
	fstps	-1284(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	fldz
	fstps	-1236(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	fldz
	fstps	-624(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	fldz
	fstps	-768(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	fldz
	fstps	-1188(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	LC7
	fstps	-1524(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	fldz
	fstps	-1668(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	fldz
	fstps	-1572(%ebp,%eax,4)
	jmp	L22
L46:
	movl	-32(%ebp), %eax
	subl	$1, %eax
	movl	-32(%ebp), %edx
	subl	$1, %edx
	flds	-1908(%ebp,%edx,4)
	movl	-32(%ebp), %edx
	subl	$1, %edx
	flds	-1140(%ebp,%edx,4)
	faddp	%st, %st(1)
	fstps	-1908(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	fldz
	fstps	-1140(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	fldz
	fstps	-1620(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-1908(%ebp,%eax,4)
	flds	LC8
	fxch	%st(1)
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L23
	movl	-32(%ebp), %eax
	subl	$1, %eax
	movl	-32(%ebp), %edx
	subl	$1, %edx
	flds	-1908(%ebp,%edx,4)
	flds	LC8
	fsubrp	%st, %st(1)
	fstps	-1620(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	LC8
	fstps	-1908(%ebp,%eax,4)
L23:
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-1908(%ebp,%eax,4)
	flds	LC8
	fdivrp	%st, %st(1)
	fstps	-1964(%ebp)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %ebx
	leal	-1964(%ebp), %eax
	movl	%eax, (%esp)
	call	___water_MOD_runoff
	fstps	-1984(%ebp)
	movl	-1984(%ebp), %eax
	movl	%eax, -1716(%ebp,%ebx,4)
	movl	32(%ebp), %eax
	movl	%eax, (%esp)
	call	___water_MOD_available_energy
	fstps	-1984(%ebp)
	movl	-1984(%ebp), %eax
	movl	%eax, -1968(%ebp)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %ebx
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	leal	-1524(%ebp), %eax
	sall	$2, %edx
	addl	%edx, %eax
	movl	%eax, 16(%esp)
	leal	-1968(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	48(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	32(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	40(%ebp), %eax
	movl	%eax, (%esp)
	call	___water_MOD_penman
	fstps	-1984(%ebp)
	movl	-1984(%ebp), %eax
	movl	%eax, -996(%ebp,%ebx,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	movl	-32(%ebp), %edx
	subl	$1, %edx
	flds	-1812(%ebp,%edx,4)
	fadds	-36(%ebp)
	movl	-32(%ebp), %edx
	subl	$1, %edx
	flds	-996(%ebp,%edx,4)
	fsubrp	%st, %st(1)
	movl	-32(%ebp), %edx
	subl	$1, %edx
	flds	-1716(%ebp,%edx,4)
	fsubrp	%st, %st(1)
	fstps	-944(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	movl	-32(%ebp), %edx
	subl	$1, %edx
	flds	-1908(%ebp,%edx,4)
	movl	-32(%ebp), %edx
	subl	$1, %edx
	flds	-944(%ebp,%edx,4)
	faddp	%st, %st(1)
	fstps	-1908(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-1908(%ebp,%eax,4)
	flds	LC8
	fxch	%st(1)
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L25
	movl	-32(%ebp), %eax
	subl	$1, %eax
	movl	-32(%ebp), %edx
	subl	$1, %edx
	flds	-1716(%ebp,%edx,4)
	movl	-32(%ebp), %edx
	subl	$1, %edx
	flds	-1908(%ebp,%edx,4)
	flds	LC8
	fsubrp	%st, %st(1)
	faddp	%st, %st(1)
	fstps	-1716(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	LC8
	fstps	-1908(%ebp,%eax,4)
L25:
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-1908(%ebp,%eax,4)
	fldz
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L27
	movl	-32(%ebp), %eax
	subl	$1, %eax
	fldz
	fstps	-1908(%ebp,%eax,4)
L27:
	movl	-32(%ebp), %eax
	subl	$1, %eax
	movl	-32(%ebp), %edx
	subl	$1, %edx
	flds	-1716(%ebp,%edx,4)
	movl	-32(%ebp), %edx
	subl	$1, %edx
	flds	-1620(%ebp,%edx,4)
	faddp	%st, %st(1)
	fstps	-1716(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	leal	-1188(%ebp), %eax
	sall	$2, %edx
	addl	%edx, %eax
	movl	%eax, -1984(%ebp)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	leal	-768(%ebp), %eax
	sall	$2, %edx
	leal	(%eax,%edx), %edi
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	leal	-624(%ebp), %eax
	sall	$2, %edx
	leal	(%eax,%edx), %esi
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	leal	-1236(%ebp), %eax
	sall	$2, %edx
	leal	(%eax,%edx), %ebx
	movl	-32(%ebp), %eax
	subl	$1, %eax
	leal	-996(%ebp), %edx
	sall	$2, %eax
	leal	(%edx,%eax), %ecx
	movl	-32(%ebp), %eax
	subl	$1, %eax
	leal	-1092(%ebp), %edx
	sall	$2, %eax
	addl	%edx, %eax
	movl	-1984(%ebp), %edx
	movl	%edx, 24(%esp)
	movl	%edi, 20(%esp)
	movl	%esi, 16(%esp)
	movl	%ebx, 12(%esp)
	movl	%ecx, 8(%esp)
	movl	%eax, 4(%esp)
	movl	28(%ebp), %eax
	movl	%eax, (%esp)
	call	___photo_MOD_carbon2
L22:
	movl	-32(%ebp), %eax
	subl	$1, %eax
	movl	-32(%ebp), %edx
	subl	$1, %edx
	flds	-1380(%ebp,%edx,4)
	movl	-32(%ebp), %edx
	subl	$1, %edx
	flds	-1332(%ebp,%edx,4)
	faddp	%st, %st(1)
	fstps	-1380(%ebp,%eax,4)
	cmpl	$1, -32(%ebp)
	jne	L29
	movl	88(%ebp), %eax
	flds	(%eax)
	flds	-948(%ebp)
	faddp	%st, %st(1)
	movl	88(%ebp), %eax
	fstps	(%eax)
L29:
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	76(%ebp), %eax
	flds	(%eax,%ecx,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-1812(%ebp,%eax,4)
	faddp	%st, %st(1)
	movl	76(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	80(%ebp), %eax
	flds	(%eax,%ecx,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-1716(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-1332(%ebp,%eax,4)
	fmulp	%st, %st(1)
	faddp	%st, %st(1)
	movl	80(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	84(%ebp), %eax
	flds	(%eax,%ecx,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-996(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-1332(%ebp,%eax,4)
	fmulp	%st, %st(1)
	faddp	%st, %st(1)
	movl	84(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	120(%ebp), %eax
	flds	(%eax,%ecx,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-1524(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-1332(%ebp,%eax,4)
	fmulp	%st, %st(1)
	faddp	%st, %st(1)
	movl	120(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	92(%ebp), %eax
	flds	(%eax,%ecx,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-1476(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-1332(%ebp,%eax,4)
	fmulp	%st, %st(1)
	faddp	%st, %st(1)
	movl	92(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	96(%ebp), %eax
	flds	(%eax,%ecx,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-240(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-1332(%ebp,%eax,4)
	fmulp	%st, %st(1)
	faddp	%st, %st(1)
	movl	96(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	100(%ebp), %eax
	flds	(%eax,%ecx,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-1284(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-1332(%ebp,%eax,4)
	fmulp	%st, %st(1)
	faddp	%st, %st(1)
	movl	100(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	148(%ebp), %eax
	flds	(%eax,%ecx,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-1956(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-1332(%ebp,%eax,4)
	fmulp	%st, %st(1)
	faddp	%st, %st(1)
	movl	148(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	152(%ebp), %eax
	flds	(%eax,%ecx,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-816(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-1332(%ebp,%eax,4)
	fmulp	%st, %st(1)
	faddp	%st, %st(1)
	movl	152(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	104(%ebp), %eax
	flds	(%eax,%ecx,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-1236(%ebp,%eax,4)
	faddp	%st, %st(1)
	movl	104(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	108(%ebp), %eax
	flds	(%eax,%ecx,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-624(%ebp,%eax,4)
	faddp	%st, %st(1)
	movl	108(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	112(%ebp), %eax
	flds	(%eax,%ecx,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-768(%ebp,%eax,4)
	faddp	%st, %st(1)
	movl	112(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	116(%ebp), %eax
	flds	(%eax,%ecx,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-1188(%ebp,%eax,4)
	faddp	%st, %st(1)
	movl	116(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	124(%ebp), %eax
	flds	(%eax,%ecx,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-1668(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-1332(%ebp,%eax,4)
	fmulp	%st, %st(1)
	faddp	%st, %st(1)
	movl	124(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	128(%ebp), %eax
	flds	(%eax,%ecx,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-1572(%ebp,%eax,4)
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-1332(%ebp,%eax,4)
	fmulp	%st, %st(1)
	faddp	%st, %st(1)
	movl	128(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-720(%ebp,%eax,4)
	movl	132(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-480(%ebp,%eax,4)
	movl	136(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-576(%ebp,%eax,4)
	movl	140(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-720(%ebp,%eax,4)
	movl	52(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-480(%ebp,%eax,4)
	movl	56(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-576(%ebp,%eax,4)
	movl	60(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	$0, _no_cell.3466
L14:
	movl	_no_cell.3466, %eax
	testl	%eax, %eax
	je	L30
	cmpl	$1, -32(%ebp)
	jne	L31
	flds	-948(%ebp)
	movl	88(%ebp), %eax
	fstps	(%eax)
L31:
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	76(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	80(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	84(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	120(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	92(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	96(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	100(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	148(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	152(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	104(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	108(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	112(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	116(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	124(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	128(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	144(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	132(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	136(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	140(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	52(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	56(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	60(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	64(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	68(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	72(%ebp), %eax
	fldz
	fstps	(%eax,%edx,4)
L30:
	cmpl	$12, -32(%ebp)
	sete	%al
	movzbl	%al, %eax
	addl	$1, -32(%ebp)
	testl	%eax, %eax
	jne	L10
	jmp	L32
L10:
	movl	-1980(%ebp), %eax
	cmpl	%eax, -28(%ebp)
	sete	%al
	movzbl	%al, %eax
	addl	$1, -28(%ebp)
	testl	%eax, %eax
	jne	L9
	jmp	L33
L9:
	movl	$1, -32(%ebp)
	cmpl	$12, -32(%ebp)
	jg	L47
L36:
	cmpl	$1, -32(%ebp)
	jne	L35
	movl	88(%ebp), %eax
	flds	(%eax)
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	subl	$1, %eax
	movl	_ndmonth.3465(,%eax,4), %eax
	movl	%eax, -1980(%ebp)
	fildl	-1980(%ebp)
	fdivrp	%st, %st(1)
	movl	88(%ebp), %eax
	fstps	(%eax)
L35:
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-1908(%ebp,%eax,4)
	movl	64(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-1140(%ebp,%eax,4)
	movl	68(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-1764(%ebp,%eax,4)
	movl	72(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	76(%ebp), %eax
	flds	(%eax,%ecx,4)
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	subl	$1, %eax
	movl	_ndmonth.3465(,%eax,4), %eax
	movl	%eax, -1980(%ebp)
	fildl	-1980(%ebp)
	fdivrp	%st, %st(1)
	movl	76(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	80(%ebp), %eax
	flds	(%eax,%ecx,4)
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	subl	$1, %eax
	movl	_ndmonth.3465(,%eax,4), %eax
	movl	%eax, -1980(%ebp)
	fildl	-1980(%ebp)
	fdivrp	%st, %st(1)
	movl	80(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	84(%ebp), %eax
	flds	(%eax,%ecx,4)
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	subl	$1, %eax
	movl	_ndmonth.3465(,%eax,4), %eax
	movl	%eax, -1980(%ebp)
	fildl	-1980(%ebp)
	fdivrp	%st, %st(1)
	movl	84(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	120(%ebp), %eax
	flds	(%eax,%ecx,4)
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	subl	$1, %eax
	movl	_ndmonth.3465(,%eax,4), %eax
	movl	%eax, -1980(%ebp)
	fildl	-1980(%ebp)
	fdivrp	%st, %st(1)
	movl	120(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	148(%ebp), %eax
	flds	(%eax,%ecx,4)
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	subl	$1, %eax
	movl	_ndmonth.3465(,%eax,4), %eax
	movl	%eax, -1980(%ebp)
	fildl	-1980(%ebp)
	fdivrp	%st, %st(1)
	movl	148(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	152(%ebp), %eax
	flds	(%eax,%ecx,4)
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	subl	$1, %eax
	movl	_ndmonth.3465(,%eax,4), %eax
	movl	%eax, -1980(%ebp)
	fildl	-1980(%ebp)
	fdivrp	%st, %st(1)
	movl	152(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	104(%ebp), %eax
	flds	(%eax,%ecx,4)
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	subl	$1, %eax
	movl	_ndmonth.3465(,%eax,4), %eax
	movl	%eax, -1980(%ebp)
	fildl	-1980(%ebp)
	fdivrp	%st, %st(1)
	movl	104(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	92(%ebp), %eax
	flds	(%eax,%ecx,4)
	flds	LC9
	fdivrp	%st, %st(1)
	flds	LC10
	fmulp	%st, %st(1)
	movl	92(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	96(%ebp), %eax
	flds	(%eax,%ecx,4)
	flds	LC9
	fdivrp	%st, %st(1)
	flds	LC10
	fmulp	%st, %st(1)
	movl	96(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	100(%ebp), %eax
	flds	(%eax,%ecx,4)
	flds	LC9
	fdivrp	%st, %st(1)
	flds	LC10
	fmulp	%st, %st(1)
	movl	100(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	108(%ebp), %eax
	flds	(%eax,%ecx,4)
	flds	LC9
	fdivrp	%st, %st(1)
	flds	LC10
	fmulp	%st, %st(1)
	movl	108(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	112(%ebp), %eax
	flds	(%eax,%ecx,4)
	flds	LC9
	fdivrp	%st, %st(1)
	flds	LC10
	fmulp	%st, %st(1)
	movl	112(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	116(%ebp), %eax
	flds	(%eax,%ecx,4)
	flds	LC9
	fdivrp	%st, %st(1)
	flds	LC10
	fmulp	%st, %st(1)
	movl	116(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	124(%ebp), %eax
	flds	(%eax,%ecx,4)
	flds	LC9
	fdivrp	%st, %st(1)
	flds	LC10
	fmulp	%st, %st(1)
	movl	124(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	128(%ebp), %eax
	flds	(%eax,%ecx,4)
	flds	LC9
	fdivrp	%st, %st(1)
	flds	LC10
	fmulp	%st, %st(1)
	movl	128(%ebp), %eax
	fstps	(%eax,%edx,4)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-32(%ebp), %eax
	subl	$1, %eax
	flds	-1332(%ebp,%eax,4)
	flds	LC11
	fmulp	%st, %st(1)
	movl	144(%ebp), %eax
	fstps	(%eax,%edx,4)
	cmpl	$12, -32(%ebp)
	sete	%al
	movzbl	%al, %eax
	addl	$1, -32(%ebp)
	testl	%eax, %eax
	jne	L47
	jmp	L36
L47:
	nop
	addl	$2140, %esp
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
LFE0:
	.data
	.align 32
_ndmonth.3465:
	.long	31
	.long	28
	.long	31
	.long	30
	.long	31
	.long	30
	.long	31
	.long	31
	.long	30
	.long	31
	.long	30
	.long	31
.lcomm _end_pls.3450,4,4
.lcomm _ocp.3469,4,4
.lcomm _no_cell.3466,4,4
	.section .rdata,"dr"
	.align 4
LC2:
	.long	-1071644672
	.align 4
LC3:
	.long	869711765
	.align 4
LC4:
	.long	1076048691
	.align 4
LC5:
	.long	1076384236
	.align 4
LC6:
	.long	1035650833
	.align 4
LC7:
	.long	1138819072
	.align 4
LC8:
	.long	1140457472
	.align 4
LC9:
	.long	1136033792
	.align 4
LC10:
	.long	1094713344
	.align 4
LC11:
	.long	1120403456
	.ident	"GCC: (GNU) 6.4.0"
	.def	___photo_MOD_pft_area_frac;	.scl	2;	.type	32;	.endef
	.def	___water_MOD_available_energy;	.scl	2;	.type	32;	.endef
	.def	___water_MOD_evpot2;	.scl	2;	.type	32;	.endef
	.def	___productivity_MOD_prod;	.scl	2;	.type	32;	.endef
	.def	___photo_MOD_allocation;	.scl	2;	.type	32;	.endef
	.def	___water_MOD_runoff;	.scl	2;	.type	32;	.endef
	.def	___water_MOD_penman;	.scl	2;	.type	32;	.endef
	.def	___photo_MOD_carbon2;	.scl	2;	.type	32;	.endef

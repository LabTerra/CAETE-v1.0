	.file	"productivity.f90"
	.text
	.globl	___productivity_MOD_prod
	.def	___productivity_MOD_prod;	.scl	2;	.type	32;	.endef
___productivity_MOD_prod:
LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$88, %esp
	movl	40(%ebp), %eax
	flds	(%eax)
	flds	LC0
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L2
	movl	48(%ebp), %eax
	flds	(%eax)
	flds	LC0
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L2
	movl	$1, _no_cell.3374
	jmp	L5
L2:
	movl	8(%ebp), %eax
	flds	(%eax)
	fstps	-16(%ebp)
	movl	8(%ebp), %eax
	flds	4(%eax)
	fstps	-20(%ebp)
	movl	8(%ebp), %eax
	flds	8(%eax)
	fstps	-28(%ebp)
	movl	12(%ebp), %eax
	movl	%eax, 16(%esp)
	movl	28(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	20(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	16(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-20(%ebp), %eax
	movl	%eax, (%esp)
	call	___photo_MOD_photosynthesis_rate
	fstps	-44(%ebp)
	movl	-44(%ebp), %eax
	movl	%eax, -12(%ebp)
	movl	32(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	16(%ebp), %eax
	movl	%eax, (%esp)
	call	___photo_MOD_vapor_p_defcit
	fstps	-44(%ebp)
	movl	-44(%ebp), %edx
	movl	92(%ebp), %eax
	movl	%edx, (%eax)
	leal	-16(%ebp), %eax
	movl	%eax, 8(%esp)
	leal	-12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	92(%ebp), %eax
	movl	%eax, (%esp)
	call	___photo_MOD_canopy_resistence
	fstps	-44(%ebp)
	movl	-44(%ebp), %edx
	movl	104(%ebp), %eax
	movl	%edx, (%eax)
	movl	92(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	20(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	104(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	___photo_MOD_water_ue
	fstps	-44(%ebp)
	movl	-44(%ebp), %edx
	movl	108(%ebp), %eax
	movl	%edx, (%eax)
	movl	36(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	104(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	48(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	24(%ebp), %eax
	movl	%eax, (%esp)
	call	___photo_MOD_water_stress_modifier
	fstps	-44(%ebp)
	movl	-44(%ebp), %edx
	movl	84(%ebp), %eax
	movl	%edx, (%eax)
	movl	16(%ebp), %eax
	flds	(%eax)
	flds	LC1
	fxch	%st(1)
	fucomip	%st(1), %st
	fstp	%st(0)
	jb	L6
	movl	16(%ebp), %eax
	flds	(%eax)
	flds	LC2
	fucomip	%st(1), %st
	fstp	%st(0)
	jb	L6
	movl	84(%ebp), %eax
	flds	(%eax)
	flds	-12(%ebp)
	fmulp	%st, %st(1)
	movl	88(%ebp), %eax
	fstps	(%eax)
	jmp	L9
L6:
	movl	88(%ebp), %eax
	fldz
	fstps	(%eax)
L9:
	leal	-28(%ebp), %eax
	movl	%eax, (%esp)
	call	___photo_MOD_spec_leaf_area
	fstps	-44(%ebp)
	movl	-44(%ebp), %eax
	movl	%eax, -24(%ebp)
	movl	40(%ebp), %eax
	flds	(%eax)
	movl	64(%ebp), %eax
	flds	(%eax)
	fmulp	%st, %st(1)
	fstps	-32(%ebp)
	leal	-24(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-32(%ebp), %eax
	movl	%eax, (%esp)
	call	___photo_MOD_leaf_area_index
	fstps	-44(%ebp)
	movl	-44(%ebp), %edx
	movl	80(%ebp), %eax
	movl	%edx, (%eax)
	leal	-24(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	40(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	88(%ebp), %eax
	movl	%eax, (%esp)
	call	___photo_MOD_gross_ph
	fstps	-44(%ebp)
	movl	-44(%ebp), %edx
	movl	68(%ebp), %eax
	movl	%edx, (%eax)
	movl	44(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	48(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	40(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	16(%ebp), %eax
	movl	%eax, (%esp)
	call	___photo_MOD_m_resp
	fstps	-44(%ebp)
	movl	-44(%ebp), %edx
	movl	96(%ebp), %eax
	movl	%edx, (%eax)
	movl	60(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	56(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	52(%ebp), %eax
	movl	%eax, (%esp)
	call	___photo_MOD_g_resp
	fstps	-44(%ebp)
	movl	-44(%ebp), %edx
	movl	100(%ebp), %eax
	movl	%edx, (%eax)
	movl	100(%ebp), %eax
	flds	(%eax)
	fldz
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L10
	movl	100(%ebp), %eax
	fldz
	fstps	(%eax)
L10:
	movl	16(%ebp), %eax
	flds	(%eax)
	flds	LC1
	fxch	%st(1)
	fucomip	%st(1), %st
	fstp	%st(0)
	jb	L12
	movl	16(%ebp), %eax
	flds	(%eax)
	flds	LC2
	fucomip	%st(1), %st
	fstp	%st(0)
	jb	L12
	movl	96(%ebp), %eax
	flds	(%eax)
	movl	100(%ebp), %eax
	flds	(%eax)
	faddp	%st, %st(1)
	movl	72(%ebp), %eax
	fstps	(%eax)
	jmp	L15
L12:
	movl	72(%ebp), %eax
	fldz
	fstps	(%eax)
L15:
	movl	68(%ebp), %eax
	flds	(%eax)
	movl	72(%ebp), %eax
	flds	(%eax)
	fsubrp	%st, %st(1)
	movl	76(%ebp), %eax
	fstps	(%eax)
	movl	76(%ebp), %eax
	flds	(%eax)
	fldz
	fucomip	%st(1), %st
	fstp	%st(0)
	jbe	L16
	movl	76(%ebp), %eax
	fldz
	fstps	(%eax)
L16:
	movl	$0, _no_cell.3374
L5:
	movl	_no_cell.3374, %eax
	testl	%eax, %eax
	je	L27
	movl	68(%ebp), %eax
	fldz
	fstps	(%eax)
	movl	104(%ebp), %eax
	fldz
	fstps	(%eax)
	movl	80(%ebp), %eax
	fldz
	fstps	(%eax)
	movl	72(%ebp), %eax
	fldz
	fstps	(%eax)
	movl	76(%ebp), %eax
	fldz
	fstps	(%eax)
	movl	92(%ebp), %eax
	fldz
	fstps	(%eax)
	movl	84(%ebp), %eax
	fldz
	fstps	(%eax)
	movl	96(%ebp), %eax
	fldz
	fstps	(%eax)
	movl	100(%ebp), %eax
	fldz
	fstps	(%eax)
	movl	108(%ebp), %eax
	fldz
	fstps	(%eax)
L27:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE0:
.lcomm _no_cell.3374,4,4
	.section .rdata,"dr"
	.align 4
LC0:
	.long	1000593162
	.align 4
LC1:
	.long	-1054867456
	.align 4
LC2:
	.long	1112014848
	.ident	"GCC: (GNU) 6.4.0"
	.def	___photo_MOD_photosynthesis_rate;	.scl	2;	.type	32;	.endef
	.def	___photo_MOD_vapor_p_defcit;	.scl	2;	.type	32;	.endef
	.def	___photo_MOD_canopy_resistence;	.scl	2;	.type	32;	.endef
	.def	___photo_MOD_water_ue;	.scl	2;	.type	32;	.endef
	.def	___photo_MOD_water_stress_modifier;	.scl	2;	.type	32;	.endef
	.def	___photo_MOD_spec_leaf_area;	.scl	2;	.type	32;	.endef
	.def	___photo_MOD_leaf_area_index;	.scl	2;	.type	32;	.endef
	.def	___photo_MOD_gross_ph;	.scl	2;	.type	32;	.endef
	.def	___photo_MOD_m_resp;	.scl	2;	.type	32;	.endef
	.def	___photo_MOD_g_resp;	.scl	2;	.type	32;	.endef

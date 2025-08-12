	.cpu cortex-a15
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"scalar_compander.c"
	.text
	.align	2
	.global	compress_scalar
	.arch armv7ve
	.syntax unified
	.arm
	.fpu neon
	.type	compress_scalar, %function
compress_scalar:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	asr	r2, r0, #15
	uxth	r2, r2
	eor	r0, r0, r2
	sub	r0, r0, r2
	ubfx	r0, r0, #3, #13
	orr	r3, r0, #1
	clz	r3, r3
	sub	r3, r3, #16
	uxth	r3, r3
	cmp	r3, #11
	movcs	r3, #11
	rsb	r3, r3, #11
	uxtb	r3, r3
	lsl	r1, r3, #4
	cmp	r3, #0
	addeq	r3, r3, #1
	asr	r3, r0, r3
	and	r0, r1, #112
	orr	r0, r0, r2, lsl #7
	and	r3, r3, #15
	orr	r3, r0, r3
	uxtb	r0, r3
	eor	r0, r0, #85
	bx	lr
	.size	compress_scalar, .-compress_scalar
	.align	2
	.global	expand_scalar
	.syntax unified
	.arm
	.fpu neon
	.type	expand_scalar, %function
expand_scalar:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	eor	r0, r0, #85
	ubfx	r3, r0, #4, #3
	lsr	r2, r0, #7
	cmp	r3, #0
	and	r0, r0, #15
	lsleq	r0, r0, #1
	orreq	r0, r0, #1
	beq	.L5
	orr	r0, r0, #16
	sub	r3, r3, #1
	lsl	r0, r0, r3
	uxth	r0, r0
.L5:
	lsl	r0, r0, #3
	cmp	r2, #1
	uxth	r0, r0
	rsbeq	r0, r0, #0
	sxth	r0, r0
	bx	lr
	.size	expand_scalar, .-expand_scalar
	.ident	"GCC: (GNU) 8.2.1 20180801 (Red Hat 8.2.1-2)"
	.section	.note.GNU-stack,"",%progbits

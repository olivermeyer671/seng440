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
	.file	"lookup_compander.c"
	.text
	.align	2
	.global	load_lookup_tables
	.arch armv7ve
	.syntax unified
	.arm
	.fpu neon
	.type	load_lookup_tables, %function
load_lookup_tables:
	@ args = 0, pretend = 0, frame = 136
	@ frame_needed = 0, uses_anonymous_args = 0
	movw	r1, #:lower16:.LC0
	movw	r0, #:lower16:.LC1
	strd	r4, [sp, #-24]!
	movt	r1, #:upper16:.LC0
	movt	r0, #:upper16:.LC1
	strd	r6, [sp, #8]
	str	r8, [sp, #16]
	str	lr, [sp, #20]
	sub	sp, sp, #136
	bl	fopen
	subs	r5, r0, #0
	beq	.L16
	movw	r6, #:lower16:.LC3
	mov	r2, r5
	add	r0, sp, #8
	mov	r1, #128
	movt	r6, #:upper16:.LC3
	mov	r7, #0
	bl	fgets
.L3:
	cmp	r7, #65536
	movge	r8, #0
	movlt	r8, #1
	b	.L4
.L5:
	add	r3, sp, #4
	mov	r2, sp
	mov	r1, r6
	add	r0, sp, #8
	bl	__isoc99_sscanf
	cmp	r0, #2
	beq	.L17
.L4:
	mov	r2, r5
	mov	r1, #128
	add	r0, sp, #8
	bl	fgets
	cmp	r0, #0
	movne	r4, r8
	moveq	r4, #0
	cmp	r4, #0
	bne	.L5
	mov	r0, r5
	bl	fclose
	cmp	r7, #65536
	bne	.L18
	movw	r1, #:lower16:.LC0
	movw	r0, #:lower16:.LC5
	movt	r1, #:upper16:.LC0
	movt	r0, #:upper16:.LC5
	bl	fopen
	subs	r5, r0, #0
	beq	.L19
	movw	r7, #:lower16:.LANCHOR0
	movw	r6, #:lower16:.LC3
	mov	r2, r5
	mov	r1, #128
	add	r0, sp, #8
	movt	r7, #:upper16:.LANCHOR0
	movt	r6, #:upper16:.LC3
	bl	fgets
.L8:
	cmp	r4, #255
	movgt	r8, #0
	movle	r8, #1
	b	.L9
.L10:
	add	r3, sp, #4
	mov	r2, sp
	mov	r1, r6
	add	r0, sp, #8
	bl	__isoc99_sscanf
	cmp	r0, #2
	beq	.L20
.L9:
	mov	r2, r5
	mov	r1, #128
	add	r0, sp, #8
	bl	fgets
	cmp	r0, #0
	movne	r0, r8
	moveq	r0, #0
	cmp	r0, #0
	bne	.L10
	mov	r0, r5
	bl	fclose
	cmp	r4, #256
	bne	.L21
	add	sp, sp, #136
	@ sp needed
	ldrd	r4, [sp]
	ldrd	r6, [sp, #8]
	ldr	r8, [sp, #16]
	add	sp, sp, #20
	ldr	pc, [sp], #4
.L17:
	ldr	r3, .L22
	add	r7, r7, #1
	ldr	r2, [sp]
	ldr	r1, [sp, #4]
	strb	r1, [r2, r3]
	b	.L3
.L20:
	ldr	r3, [sp, #4]
	add	r4, r4, #1
	strh	r3, [r7], #2	@ movhi
	b	.L8
.L16:
	movw	r3, #:lower16:stderr
	movw	r2, #:lower16:.LC1
	movt	r3, #:upper16:stderr
	movw	r1, #:lower16:.LC2
	movt	r2, #:upper16:.LC1
	movt	r1, #:upper16:.LC2
	ldr	r0, [r3]
	bl	fprintf
	mov	r0, #1
	bl	exit
.L21:
	movw	r0, #:lower16:stderr
	movw	r1, #:lower16:.LC7
	movt	r0, #:upper16:stderr
	mov	r2, r4
	movt	r1, #:upper16:.LC7
	mov	r3, #256
	ldr	r0, [r0]
	bl	fprintf
	mov	r0, #1
	bl	exit
.L19:
	movw	r3, #:lower16:stderr
	movw	r2, #:lower16:.LC5
	movt	r3, #:upper16:stderr
	movw	r1, #:lower16:.LC6
	movt	r2, #:upper16:.LC5
	movt	r1, #:upper16:.LC6
	ldr	r0, [r3]
	bl	fprintf
	mov	r0, #1
	bl	exit
.L18:
	movw	r0, #:lower16:stderr
	movw	r1, #:lower16:.LC4
	movt	r0, #:upper16:stderr
	mov	r2, r7
	movt	r1, #:upper16:.LC4
	mov	r3, #65536
	ldr	r0, [r0]
	bl	fprintf
	mov	r0, #1
	bl	exit
.L23:
	.align	2
.L22:
	.word	sample_to_codeword+32768
	.size	load_lookup_tables, .-load_lookup_tables
	.align	2
	.global	compress_lookup
	.syntax unified
	.arm
	.fpu neon
	.type	compress_lookup, %function
compress_lookup:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	r0, r0, #32768
	movw	r3, #:lower16:sample_to_codeword
	uxth	r0, r0
	movt	r3, #:upper16:sample_to_codeword
	ldrb	r0, [r3, r0]	@ zero_extendqisi2
	bx	lr
	.size	compress_lookup, .-compress_lookup
	.align	2
	.global	expand_lookup
	.syntax unified
	.arm
	.fpu neon
	.type	expand_lookup, %function
expand_lookup:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	lsl	r0, r0, #1
	movw	r3, #:lower16:.LANCHOR0
	movt	r3, #:upper16:.LANCHOR0
	ldrsh	r0, [r3, r0]
	bx	lr
	.size	expand_lookup, .-expand_lookup
	.bss
	.align	3
	.set	.LANCHOR0,. + 0
	.type	codeword_to_sample, %object
	.size	codeword_to_sample, 512
codeword_to_sample:
	.space	512
	.type	sample_to_codeword, %object
	.size	sample_to_codeword, 65536
sample_to_codeword:
	.space	65536
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"r\000"
	.space	2
.LC1:
	.ascii	"lookup-tables/xlaw_compress_lookup.csv\000"
	.space	1
.LC2:
	.ascii	"Could not open compress lookup table: %s\012\000"
	.space	2
.LC3:
	.ascii	"%d,%*[^,],%d,%*[^,\012]\000"
	.space	3
.LC4:
	.ascii	"Compress table rows: %d (expected %d)\012\000"
	.space	1
.LC5:
	.ascii	"lookup-tables/alaw_expand_lookup.csv\000"
	.space	3
.LC6:
	.ascii	"Could not open expand lookup table: %s\012\000"
.LC7:
	.ascii	"Expand table rows: %d (expected %d)\012\000"
	.ident	"GCC: (GNU) 8.2.1 20180801 (Red Hat 8.2.1-2)"
	.section	.note.GNU-stack,"",%progbits

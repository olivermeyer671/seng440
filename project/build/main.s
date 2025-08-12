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
	.file	"main.c"
	.text
	.align	2
	.global	scalar_regular
	.arch armv7ve
	.syntax unified
	.arm
	.fpu neon
	.type	scalar_regular, %function
scalar_regular:
	@ args = 0, pretend = 0, frame = 48
	@ frame_needed = 0, uses_anonymous_args = 0
	movw	r1, #:lower16:.LC0
	strd	r4, [sp, #-16]!
	movt	r1, #:upper16:.LC0
	str	r6, [sp, #8]
	str	lr, [sp, #12]
	sub	sp, sp, #48
	bl	fopen
	subs	r5, r0, #0
	beq	.L9
	movw	r1, #:lower16:.LC2
	movw	r0, #:lower16:.LC3
	movt	r1, #:upper16:.LC2
	movt	r0, #:upper16:.LC3
	bl	fopen
	subs	r6, r0, #0
	beq	.L10
	mov	r3, r5
	add	r0, sp, #4
	mov	r2, #44
	mov	r1, #1
	bl	fread
	mov	r3, r6
	add	r0, sp, #4
	mov	r2, #44
	mov	r1, #1
	bl	fwrite
	b	.L5
.L6:
	ldrsh	r0, [sp]
	bl	compress_scalar
	bl	expand_scalar
	mov	r1, #2
	mov	r3, r6
	strh	r0, [sp, #2]	@ movhi
	mov	r2, #1
	add	r0, sp, r1
	bl	fwrite
.L5:
	mov	r3, r5
	mov	r2, #1
	mov	r1, #2
	mov	r0, sp
	bl	fread
	subs	r4, r0, #0
	bne	.L6
	mov	r0, r5
	bl	fclose
	mov	r0, r6
	bl	fclose
	mov	r0, r4
.L1:
	add	sp, sp, #48
	@ sp needed
	ldrd	r4, [sp]
	ldr	r6, [sp, #8]
	add	sp, sp, #12
	ldr	pc, [sp], #4
.L9:
	movw	r0, #:lower16:.LC1
	movt	r0, #:upper16:.LC1
	bl	perror
	mov	r0, #1
	b	.L1
.L10:
	movw	r0, #:lower16:.LC4
	movt	r0, #:upper16:.LC4
	bl	perror
	mov	r0, #1
	b	.L1
	.size	scalar_regular, .-scalar_regular
	.align	2
	.global	scalar_pipelined
	.syntax unified
	.arm
	.fpu neon
	.type	scalar_pipelined, %function
scalar_pipelined:
	@ args = 0, pretend = 0, frame = 48
	@ frame_needed = 0, uses_anonymous_args = 0
	movw	r1, #:lower16:.LC0
	strd	r4, [sp, #-20]!
	movt	r1, #:upper16:.LC0
	strd	r6, [sp, #8]
	str	lr, [sp, #16]
	sub	sp, sp, #52
	bl	fopen
	subs	r6, r0, #0
	beq	.L18
	movw	r1, #:lower16:.LC2
	movw	r0, #:lower16:.LC5
	movt	r1, #:upper16:.LC2
	movt	r0, #:upper16:.LC5
	bl	fopen
	subs	r7, r0, #0
	beq	.L19
	mov	r3, r6
	mov	r2, #44
	mov	r1, #1
	add	r0, sp, #4
	bl	fread
	mov	r3, r7
	mov	r2, #44
	mov	r1, #1
	add	r0, sp, #4
	bl	fwrite
	mov	r3, r6
	mov	r2, #1
	mov	r1, #2
	mov	r0, sp
	bl	fread
	ldrsh	r0, [sp]
	bl	compress_scalar
	mov	r5, r0
	bl	expand_scalar
	strh	r0, [sp, #2]	@ movhi
.L16:
	mov	r3, r6
	mov	r2, #1
	mov	r1, #2
	mov	r0, sp
	bl	fread
	mov	r4, r0
	mov	r0, r5
	bl	expand_scalar
	mov	r1, #2
	mov	r5, r0
	mov	r3, r7
	mov	r2, #1
	add	r0, sp, r1
	bl	fwrite
	cmp	r4, #0
	strh	r5, [sp, #2]	@ movhi
	bne	.L20
	mov	r3, r7
	mov	r2, #1
	mov	r1, #2
	add	r0, sp, #2
	bl	fwrite
	mov	r0, r6
	bl	fclose
	mov	r0, r7
	bl	fclose
	mov	r0, r4
.L11:
	add	sp, sp, #52
	@ sp needed
	ldrd	r4, [sp]
	ldrd	r6, [sp, #8]
	add	sp, sp, #16
	ldr	pc, [sp], #4
.L20:
	ldrsh	r0, [sp]
	bl	compress_scalar
	mov	r5, r0
	b	.L16
.L18:
	movw	r0, #:lower16:.LC1
	movt	r0, #:upper16:.LC1
	bl	perror
	mov	r0, #1
	b	.L11
.L19:
	movw	r0, #:lower16:.LC4
	movt	r0, #:upper16:.LC4
	bl	perror
	mov	r0, #1
	b	.L11
	.size	scalar_pipelined, .-scalar_pipelined
	.align	2
	.global	simd_regular
	.syntax unified
	.arm
	.fpu neon
	.type	simd_regular, %function
simd_regular:
	@ args = 0, pretend = 0, frame = 96
	@ frame_needed = 0, uses_anonymous_args = 0
	movw	r1, #:lower16:.LC0
	strd	r4, [sp, #-24]!
	movt	r1, #:upper16:.LC0
	strd	r6, [sp, #8]
	str	r8, [sp, #16]
	str	lr, [sp, #20]
	sub	sp, sp, #104
	bl	fopen
	subs	r7, r0, #0
	beq	.L28
	movw	r1, #:lower16:.LC2
	movw	r0, #:lower16:.LC6
	movt	r1, #:upper16:.LC2
	movt	r0, #:upper16:.LC6
	bl	fopen
	subs	r8, r0, #0
	beq	.L29
	mov	r3, r7
	mov	r2, #44
	mov	r1, #1
	add	r0, sp, #60
	bl	fread
	mov	r3, r8
	add	r0, sp, #60
	mov	r2, #44
	mov	r1, #1
	add	r5, sp, #20
	add	r4, sp, #8
	bl	fwrite
	b	.L25
.L26:
	ldrh	lr, [sp, #36]
	ldr	ip, [sp, #32]
	ldm	r5, {r1, r2, r3}
	str	ip, [sp]
	strh	lr, [sp, #4]	@ movhi
	bl	compress_batch
	add	r0, sp, #40
	ldm	r4, {r1, r2, r3}
	bl	expand_batch
	mov	r3, r8
	add	r0, sp, #40
	ldrb	r2, [sp, #56]	@ zero_extendqisi2
	mov	r1, #2
	bl	fwrite
.L25:
	mov	r3, r7
	mov	r2, #8
	mov	r1, #2
	mov	r0, r5
	bl	fread
	uxtb	r6, r0
	mov	r0, r4
	cmp	r6, #0
	strb	r6, [sp, #36]
	bne	.L26
	mov	r0, r7
	bl	fclose
	mov	r0, r8
	bl	fclose
	mov	r0, r6
.L21:
	add	sp, sp, #104
	@ sp needed
	ldrd	r4, [sp]
	ldrd	r6, [sp, #8]
	ldr	r8, [sp, #16]
	add	sp, sp, #20
	ldr	pc, [sp], #4
.L28:
	movw	r0, #:lower16:.LC1
	movt	r0, #:upper16:.LC1
	bl	perror
	mov	r0, #1
	b	.L21
.L29:
	movw	r0, #:lower16:.LC4
	movt	r0, #:upper16:.LC4
	bl	perror
	mov	r0, #1
	b	.L21
	.size	simd_regular, .-simd_regular
	.align	2
	.global	simd_pipelined
	.syntax unified
	.arm
	.fpu neon
	.type	simd_pipelined, %function
simd_pipelined:
	@ args = 0, pretend = 0, frame = 152
	@ frame_needed = 0, uses_anonymous_args = 0
	movw	r1, #:lower16:.LC0
	strd	r4, [sp, #-36]!
	movt	r1, #:upper16:.LC0
	strd	r6, [sp, #8]
	strd	r8, [sp, #16]
	strd	r10, [sp, #24]
	str	lr, [sp, #32]
	sub	sp, sp, #164
	bl	fopen
	subs	r8, r0, #0
	beq	.L47
	movw	r1, #:lower16:.LC2
	movw	r0, #:lower16:.LC7
	movt	r1, #:upper16:.LC2
	movt	r0, #:upper16:.LC7
	bl	fopen
	subs	r9, r0, #0
	beq	.L48
	mov	r3, r8
	mov	r2, #44
	mov	r1, #1
	add	r0, sp, #116
	bl	fread
	add	r6, sp, #56
	mov	r3, r9
	mov	r2, #44
	mov	r1, #1
	add	r0, sp, #116
	bl	fwrite
	mov	r0, r6
	mov	r3, r8
	mov	r2, #8
	mov	r1, #2
	bl	fread
	uxtb	r0, r0
	cmp	r0, #0
	addeq	r5, sp, #32
	strb	r0, [sp, #72]
	bne	.L49
.L34:
	add	r4, sp, #76
	mov	r3, r8
	mov	r0, r4
	mov	r2, #8
	mov	r1, #2
	bl	fread
	uxtb	r0, r0
	cmp	r0, #0
	addeq	r7, sp, #44
	strb	r0, [sp, #92]
	bne	.L50
.L36:
	add	r0, sp, #8
	ldm	r5, {r1, r2, r3}
	bl	expand_batch
	ldrh	r2, [sp, #24]	@ unaligned
	mov	r3, r9
	mov	r1, #2
	ldr	fp, [sp, #8]	@ unaligned
	add	r0, sp, #96
	ldr	r10, [sp, #12]	@ unaligned
	ldr	lr, [sp, #16]	@ unaligned
	ldr	ip, [sp, #20]	@ unaligned
	str	fp, [sp, #96]
	strh	r2, [sp, #112]	@ movhi
	uxtb	r2, r2
	str	r10, [sp, #100]
	str	lr, [sp, #104]
	str	ip, [sp, #108]
	bl	fwrite
	ldrd	r10, [r4]
	mov	r3, r8
	mov	r2, #8
	vldr.64	d16, [r4, #8]	@ int
	mov	r1, #2
	mov	r0, r4
	ldrh	lr, [r4, #16]
	ldrb	ip, [r7, #8]	@ zero_extendqisi2
	strd	r10, [r6]
	ldrd	r10, [r7]
	vstr.64	d16, [r6, #8]	@ int
	strd	r10, [r5]
	strb	ip, [r5, #8]
	strh	lr, [r6, #16]	@ movhi
	bl	fread
	uxtb	r0, r0
	cmp	r0, #0
	strb	r0, [sp, #92]
	bne	.L51
	ldrb	r3, [sp, #72]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L36
.L39:
	mov	r0, r8
	bl	fclose
	mov	r0, r9
	bl	fclose
	mov	r0, #0
.L30:
	add	sp, sp, #164
	@ sp needed
	ldrd	r4, [sp]
	ldrd	r6, [sp, #8]
	ldrd	r8, [sp, #16]
	ldrd	r10, [sp, #24]
	add	sp, sp, #32
	ldr	pc, [sp], #4
.L51:
	ldrh	lr, [sp, #92]
	mov	r0, r7
	ldr	ip, [sp, #88]
	ldm	r4, {r1, r2, r3}
	str	ip, [sp]
	strh	lr, [sp, #4]	@ movhi
	bl	compress_batch
	ldrb	r3, [sp, #72]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L36
	b	.L39
.L50:
	ldrh	lr, [sp, #92]
	add	r7, sp, #44
	ldr	ip, [sp, #88]
	mov	r0, r7
	ldm	r4, {r1, r2, r3}
	str	ip, [sp]
	strh	lr, [sp, #4]	@ movhi
	bl	compress_batch
	b	.L36
.L49:
	ldrh	lr, [sp, #72]
	add	r5, sp, #32
	ldr	ip, [sp, #68]
	mov	r0, r5
	ldm	r6, {r1, r2, r3}
	str	ip, [sp]
	strh	lr, [sp, #4]	@ movhi
	bl	compress_batch
	b	.L34
.L47:
	movw	r0, #:lower16:.LC1
	movt	r0, #:upper16:.LC1
	bl	perror
	mov	r0, #1
	b	.L30
.L48:
	movw	r0, #:lower16:.LC4
	movt	r0, #:upper16:.LC4
	bl	perror
	mov	r0, #1
	b	.L30
	.size	simd_pipelined, .-simd_pipelined
	.align	2
	.global	lookup_compander_regular
	.syntax unified
	.arm
	.fpu neon
	.type	lookup_compander_regular, %function
lookup_compander_regular:
	@ args = 0, pretend = 0, frame = 48
	@ frame_needed = 0, uses_anonymous_args = 0
	movw	r1, #:lower16:.LC0
	strd	r4, [sp, #-16]!
	movt	r1, #:upper16:.LC0
	str	r6, [sp, #8]
	str	lr, [sp, #12]
	sub	sp, sp, #48
	bl	fopen
	subs	r5, r0, #0
	beq	.L59
	movw	r1, #:lower16:.LC2
	movw	r0, #:lower16:.LC8
	movt	r1, #:upper16:.LC2
	movt	r0, #:upper16:.LC8
	bl	fopen
	subs	r6, r0, #0
	beq	.L60
	mov	r3, r5
	add	r0, sp, #4
	mov	r2, #44
	mov	r1, #1
	bl	fread
	mov	r3, r6
	add	r0, sp, #4
	mov	r2, #44
	mov	r1, #1
	bl	fwrite
	b	.L56
.L57:
	ldrsh	r0, [sp]
	bl	compress_lookup
	bl	expand_lookup
	mov	r1, #2
	mov	r2, r4
	strh	r0, [sp, #2]	@ movhi
	mov	r3, r6
	add	r0, sp, r1
	bl	fwrite
.L56:
	mov	r3, r5
	mov	r2, #1
	mov	r1, #2
	mov	r0, sp
	bl	fread
	cmp	r0, #1
	mov	r4, r0
	beq	.L57
	mov	r0, r5
	bl	fclose
	mov	r0, r6
	bl	fclose
	mov	r0, #0
.L52:
	add	sp, sp, #48
	@ sp needed
	ldrd	r4, [sp]
	ldr	r6, [sp, #8]
	add	sp, sp, #12
	ldr	pc, [sp], #4
.L59:
	movw	r0, #:lower16:.LC1
	movt	r0, #:upper16:.LC1
	bl	perror
	mov	r0, #1
	b	.L52
.L60:
	movw	r0, #:lower16:.LC4
	movt	r0, #:upper16:.LC4
	bl	perror
	mov	r0, r5
	bl	fclose
	mov	r0, #1
	b	.L52
	.size	lookup_compander_regular, .-lookup_compander_regular
	.align	2
	.global	lookup_compander_pipelined
	.syntax unified
	.arm
	.fpu neon
	.type	lookup_compander_pipelined, %function
lookup_compander_pipelined:
	@ args = 0, pretend = 0, frame = 56
	@ frame_needed = 0, uses_anonymous_args = 0
	movw	r1, #:lower16:.LC0
	strd	r4, [sp, #-20]!
	movt	r1, #:upper16:.LC0
	strd	r6, [sp, #8]
	str	lr, [sp, #16]
	sub	sp, sp, #60
	bl	fopen
	subs	r5, r0, #0
	beq	.L70
	movw	r1, #:lower16:.LC2
	movw	r0, #:lower16:.LC9
	movt	r1, #:upper16:.LC2
	movt	r0, #:upper16:.LC9
	bl	fopen
	subs	r7, r0, #0
	beq	.L71
	mov	r3, r5
	mov	r2, #44
	mov	r1, #1
	add	r0, sp, #12
	bl	fread
	mov	r3, r7
	mov	r2, #44
	mov	r1, #1
	add	r0, sp, #12
	bl	fwrite
	mov	r3, r5
	mov	r2, #1
	mov	r1, #2
	add	r0, sp, #6
	bl	fread
	cmp	r0, #1
	bne	.L69
	ldrsh	r0, [sp, #6]
	bl	compress_lookup
	bl	expand_lookup
	strh	r0, [sp, #10]	@ movhi
	b	.L66
.L67:
	ldrsh	r0, [sp, #8]
	bl	compress_lookup
	mov	r6, r0
	mov	r3, r7
	mov	r2, r4
	mov	r1, #2
	add	r0, sp, #10
	bl	fwrite
	mov	r0, r6
	bl	expand_lookup
	strh	r0, [sp, #10]	@ movhi
.L66:
	mov	r3, r5
	mov	r2, #1
	mov	r1, #2
	add	r0, sp, #8
	bl	fread
	cmp	r0, #1
	mov	r4, r0
	beq	.L67
	add	r0, sp, #10
	mov	r3, r7
	mov	r2, #1
	mov	r1, #2
	bl	fwrite
.L69:
	mov	r0, r5
	bl	fclose
	mov	r0, r7
	bl	fclose
	mov	r0, #0
.L61:
	add	sp, sp, #60
	@ sp needed
	ldrd	r4, [sp]
	ldrd	r6, [sp, #8]
	add	sp, sp, #16
	ldr	pc, [sp], #4
.L70:
	movw	r0, #:lower16:.LC1
	movt	r0, #:upper16:.LC1
	bl	perror
	mov	r0, #1
	b	.L61
.L71:
	movw	r0, #:lower16:.LC4
	movt	r0, #:upper16:.LC4
	bl	perror
	mov	r0, r5
	bl	fclose
	mov	r0, #1
	b	.L61
	.size	lookup_compander_pipelined, .-lookup_compander_pipelined
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu neon
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	cmp	r0, #2
	strd	r4, [sp, #-24]!
	mov	r4, r1
	strd	r6, [sp, #8]
	str	r8, [sp, #16]
	str	lr, [sp, #20]
	vpush.64	{d8, d9}
	sub	sp, sp, #8
	beq	.L73
	movw	r0, #:lower16:.LC10
	ldr	r1, [r1]
	movt	r0, #:upper16:.LC10
	bl	printf
	mov	r0, #1
.L72:
	add	sp, sp, #8
	@ sp needed
	vldm	sp!, {d8-d9}
	ldrd	r4, [sp]
	ldrd	r6, [sp, #8]
	ldr	r8, [sp, #16]
	add	sp, sp, #20
	ldr	pc, [sp], #4
.L73:
	bl	load_lookup_tables
	movw	r1, #:lower16:.LC11
	movw	r0, #:lower16:.LC12
	movt	r1, #:upper16:.LC11
	movt	r0, #:upper16:.LC12
	bl	fopen
	subs	r6, r0, #0
	beq	.L89
	movw	r0, #:lower16:.LC14
	mov	r3, r6
	mov	r2, #77
	mov	r1, #1
	movt	r0, #:upper16:.LC14
	mov	r5, #5
	bl	fwrite
	movw	r0, #:lower16:.LC15
	movt	r0, #:upper16:.LC15
	bl	puts
	bl	clock
	mov	r7, r0
	bl	clock
	mov	r8, r0
.L76:
	ldr	r0, [r4, #4]
	bl	lookup_compander_regular
	subs	r5, r5, #1
	bne	.L76
	bl	clock
	sub	r0, r0, r8
	vldr.64	d20, .L90
	vmov.f64	d18, #5.0e+0
	vldr.64	d19, .L90+8
	movw	r2, #:lower16:.LC16
	movw	r1, #:lower16:.LC17
	vmov	s15, r0	@ int
	movt	r2, #:upper16:.LC16
	movt	r1, #:upper16:.LC17
	mov	r0, r6
	mov	r5, #5
	vcvt.f64.s32	d16, s15
	vdiv.f64	d17, d16, d20
	vmul.f64	d17, d17, d19
	vdiv.f64	d8, d17, d18
	vstr.64	d8, [sp]
	bl	fprintf
	movw	r1, #:lower16:.LC16
	movw	r0, #:lower16:.LC17
	vmov	r2, r3, d8
	movt	r1, #:upper16:.LC16
	movt	r0, #:upper16:.LC17
	bl	printf
	bl	clock
	mov	r8, r0
.L77:
	ldr	r0, [r4, #4]
	bl	lookup_compander_pipelined
	subs	r5, r5, #1
	bne	.L77
	bl	clock
	sub	r0, r0, r8
	vldr.64	d20, .L90
	vmov.f64	d18, #5.0e+0
	vldr.64	d19, .L90+8
	movw	r2, #:lower16:.LC18
	movw	r1, #:lower16:.LC17
	vmov	s15, r0	@ int
	movt	r2, #:upper16:.LC18
	movt	r1, #:upper16:.LC17
	mov	r0, r6
	mov	r5, #5
	vcvt.f64.s32	d16, s15
	vdiv.f64	d17, d16, d20
	vmul.f64	d17, d17, d19
	vdiv.f64	d8, d17, d18
	vstr.64	d8, [sp]
	bl	fprintf
	movw	r1, #:lower16:.LC18
	movw	r0, #:lower16:.LC17
	vmov	r2, r3, d8
	movt	r1, #:upper16:.LC18
	movt	r0, #:upper16:.LC17
	bl	printf
	bl	clock
	mov	r8, r0
.L78:
	ldr	r0, [r4, #4]
	bl	scalar_regular
	subs	r5, r5, #1
	bne	.L78
	bl	clock
	sub	r0, r0, r8
	vldr.64	d20, .L90
	vmov.f64	d18, #5.0e+0
	vldr.64	d19, .L90+8
	movw	r2, #:lower16:.LC19
	movw	r1, #:lower16:.LC17
	vmov	s15, r0	@ int
	movt	r2, #:upper16:.LC19
	movt	r1, #:upper16:.LC17
	mov	r0, r6
	mov	r5, #5
	vcvt.f64.s32	d16, s15
	vdiv.f64	d17, d16, d20
	vmul.f64	d17, d17, d19
	vdiv.f64	d8, d17, d18
	vstr.64	d8, [sp]
	bl	fprintf
	movw	r1, #:lower16:.LC19
	movw	r0, #:lower16:.LC17
	vmov	r2, r3, d8
	movt	r1, #:upper16:.LC19
	movt	r0, #:upper16:.LC17
	bl	printf
	bl	clock
	mov	r8, r0
.L79:
	ldr	r0, [r4, #4]
	bl	scalar_pipelined
	subs	r5, r5, #1
	bne	.L79
	bl	clock
	sub	r0, r0, r8
	vldr.64	d20, .L90
	vmov.f64	d18, #5.0e+0
	vldr.64	d19, .L90+8
	movw	r2, #:lower16:.LC20
	movw	r1, #:lower16:.LC17
	vmov	s15, r0	@ int
	movt	r2, #:upper16:.LC20
	movt	r1, #:upper16:.LC17
	mov	r0, r6
	mov	r5, #5
	vcvt.f64.s32	d16, s15
	vdiv.f64	d17, d16, d20
	vmul.f64	d17, d17, d19
	vdiv.f64	d8, d17, d18
	vstr.64	d8, [sp]
	bl	fprintf
	movw	r1, #:lower16:.LC20
	movw	r0, #:lower16:.LC17
	vmov	r2, r3, d8
	movt	r1, #:upper16:.LC20
	movt	r0, #:upper16:.LC17
	bl	printf
	bl	clock
	mov	r8, r0
.L80:
	ldr	r0, [r4, #4]
	bl	simd_regular
	subs	r5, r5, #1
	bne	.L80
	bl	clock
	sub	r0, r0, r8
	vldr.64	d20, .L90
	vmov.f64	d18, #5.0e+0
	vldr.64	d19, .L90+8
	movw	r2, #:lower16:.LC21
	movw	r1, #:lower16:.LC17
	vmov	s15, r0	@ int
	movt	r2, #:upper16:.LC21
	movt	r1, #:upper16:.LC17
	mov	r0, r6
	mov	r5, #5
	vcvt.f64.s32	d16, s15
	vdiv.f64	d17, d16, d20
	vmul.f64	d17, d17, d19
	vdiv.f64	d8, d17, d18
	vstr.64	d8, [sp]
	bl	fprintf
	movw	r1, #:lower16:.LC21
	movw	r0, #:lower16:.LC17
	vmov	r2, r3, d8
	movt	r1, #:upper16:.LC21
	movt	r0, #:upper16:.LC17
	bl	printf
	bl	clock
	mov	r8, r0
.L81:
	ldr	r0, [r4, #4]
	bl	simd_pipelined
	subs	r5, r5, #1
	bne	.L81
	bl	clock
	sub	r0, r0, r8
	vldr.64	d9, .L90
	vmov.f64	d18, #5.0e+0
	vldr.64	d19, .L90+8
	movw	r2, #:lower16:.LC22
	movw	r1, #:lower16:.LC17
	vmov	s15, r0	@ int
	movt	r2, #:upper16:.LC22
	movt	r1, #:upper16:.LC17
	mov	r0, r6
	vcvt.f64.s32	d16, s15
	vdiv.f64	d17, d16, d9
	vmul.f64	d17, d17, d19
	vdiv.f64	d8, d17, d18
	vstr.64	d8, [sp]
	bl	fprintf
	movw	r1, #:lower16:.LC22
	movw	r0, #:lower16:.LC17
	vmov	r2, r3, d8
	movt	r1, #:upper16:.LC22
	movt	r0, #:upper16:.LC17
	bl	printf
	bl	clock
	sub	r0, r0, r7
	movw	r2, #:lower16:.LC23
	movw	r1, #:lower16:.LC24
	movt	r2, #:upper16:.LC23
	vmov	s15, r0	@ int
	movt	r1, #:upper16:.LC24
	mov	r0, r6
	vcvt.f64.s32	d16, s15
	vdiv.f64	d8, d16, d9
	vstr.64	d8, [sp]
	bl	fprintf
	movw	r1, #:lower16:.LC23
	movw	r0, #:lower16:.LC25
	vmov	r2, r3, d8
	movt	r1, #:upper16:.LC23
	movt	r0, #:upper16:.LC25
	bl	printf
	mov	r0, r6
	bl	fclose
	mov	r0, r5
	b	.L72
.L89:
	movw	r0, #:lower16:.LC13
	movt	r0, #:upper16:.LC13
	bl	perror
	mov	r0, #1
	b	.L72
.L91:
	.align	3
.L90:
	.word	0
	.word	1093567616
	.word	0
	.word	1083129856
	.size	main, .-main
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"rb\000"
	.space	1
.LC1:
	.ascii	"input file failed to open\000"
	.space	2
.LC2:
	.ascii	"wb\000"
	.space	1
.LC3:
	.ascii	"outputs/scalar_output.wav\000"
	.space	2
.LC4:
	.ascii	"output file failed to open\000"
	.space	1
.LC5:
	.ascii	"outputs/scalar_pipelined_output.wav\000"
.LC6:
	.ascii	"outputs/simd_output.wav\000"
.LC7:
	.ascii	"outputs/simd_pipelined_output.wav\000"
	.space	2
.LC8:
	.ascii	"outputs/lookup_regular.wav\000"
	.space	1
.LC9:
	.ascii	"outputs/lookup_pipelined.wav\000"
	.space	3
.LC10:
	.ascii	"Incorrect arguments, please use: %s input_file.wav\012"
	.ascii	"\000"
.LC11:
	.ascii	"w\000"
	.space	2
.LC12:
	.ascii	"statistics.txt\000"
	.space	1
.LC13:
	.ascii	"error opening statistics.txt\000"
	.space	3
.LC14:
	.ascii	"A-Law Audio Compression and Expansion Test Results "
	.ascii	"(average execution time)\012\012\000"
	.space	2
.LC15:
	.ascii	"\012A-Law Audio Compression and Expansion Test Resu"
	.ascii	"lts (average execution time)\012\000"
	.space	2
.LC16:
	.ascii	"Lookup Table Compander Regular\000"
	.space	1
.LC17:
	.ascii	"%-35s : %10.0f ms\012\000"
	.space	1
.LC18:
	.ascii	"Lookup Table Compander Pipelined\000"
	.space	3
.LC19:
	.ascii	"Scalar Compander Regular\000"
	.space	3
.LC20:
	.ascii	"Scalar Compander Pipelined\000"
	.space	1
.LC21:
	.ascii	"SIMD Compander Regular\000"
	.space	1
.LC22:
	.ascii	"SIMD Compander Pipelined\000"
	.space	3
.LC23:
	.ascii	"Total Test-Bench Execution Time\000"
.LC24:
	.ascii	"%-35s : %10.0f s\012\000"
	.space	2
.LC25:
	.ascii	"%-35s : %10.0f s\012\012\000"
	.ident	"GCC: (GNU) 8.2.1 20180801 (Red Hat 8.2.1-2)"
	.section	.note.GNU-stack,"",%progbits

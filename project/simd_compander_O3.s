	.arch armv7-a
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
	.file	"simd_compander.c"
	.text
	.align	2
	.global	compress_batch
	.arch armv7-a
	.syntax unified
	.arm
	.fpu neon
	.type	compress_batch, %function
compress_batch:
	@ args = 24, pretend = 16, frame = 80
	@ frame_needed = 0, uses_anonymous_args = 0
	sub	sp, sp, #16
	push	{r4, r5, r6, lr}
	mov	r4, #0
	sub	sp, sp, #80
	ldrb	r5, [sp, #116]	@ zero_extendqisi2
	add	ip, sp, #100
	stm	ip, {r1, r2, r3}
	mov	r6, r0
	mov	r1, ip
	add	r0, sp, #64
	lsl	r2, r5, #1
	str	r4, [sp, #64]
	str	r4, [sp, #68]
	str	r4, [sp, #72]
	str	r4, [sp, #76]
	bl	memcpy
	add	r3, sp, #64
	vld1.16	{d16-d17}, [r3:64]
	vabs.s16	q12, q8
	vshr.u16	q12, q12, #3
	vmov.i16	q11, #11  @ v8hi
	vclz.i16	q9, q12
	vshr.u16	q8, q8, #15
	vqsub.u16	q11, q11, q9
	vshl.i16	q10, q8, #7
	vshl.i16	q9, q11, #4
	add	r3, sp, #16
	vst1.16	{d24-d25}, [r3:64]
	cmp	r5, r4
	add	r3, sp, #32
	str	r4, [sp, #48]
	vmovn.i16	d20, q10
	vst1.16	{d22-d23}, [r3:64]
	vmovn.i16	d18, q9
	str	r4, [sp, #52]
	str	r4, [sp, #56]
	str	r4, [sp, #60]
	beq	.L2
	sub	r3, r5, #1
	cmp	r3, #6
	bls	.L5
	vldr	d22, [sp, #32]
	vldr	d23, [sp, #40]
	vmov.i32	q12, #0  @ v8hi
	vmov.i16	q13, #1  @ v8hi
	vceq.i16	q8, q11, q12
	vbsl	q8, q13, q12
	vmovl.u16 q12, d16
	vmovl.u16 q8, d17
	vaddw.u16	q12, q12, d22
	vaddw.u16	q8, q8, d23
	vldr	d22, [sp, #16]
	vldr	d23, [sp, #24]
	vneg.s32	q12, q12
	vmovl.u16 q13, d22
	vneg.s32	q8, q8
	vmovl.u16 q11, d23
	vshl.s32	q12, q13, q12
	vshl.s32	q8, q11, q8
	vmov.i16	q13, #15  @ v8hi
	vmovn.i32	d22, q12
	vmovn.i32	d23, q8
	vand	q11, q11, q13
	and	r3, r5, #248
	cmp	r5, r3
	vstr	d22, [sp, #48]
	vstr	d23, [sp, #56]
	beq	.L2
.L3:
	add	r2, sp, #80
	add	ip, r2, r3, lsl #1
	ldrh	r2, [ip, #-48]
	ldrh	r1, [ip, #-64]
	cmp	r2, #0
	movne	r0, r2
	addeq	r0, r2, #1
	add	r2, r3, #1
	asr	r1, r1, r0
	uxtb	r2, r2
	and	r1, r1, #15
	cmp	r5, r2
	strh	r1, [ip, #-32]	@ movhi
	bls	.L2
	add	r1, sp, #80
	add	r2, r1, r2, lsl #1
	ldrh	r1, [r2, #-48]
	ldrh	r0, [r2, #-64]
	cmp	r1, #0
	movne	ip, r1
	addeq	ip, r1, #1
	add	r1, r3, #2
	asr	r0, r0, ip
	uxtb	r1, r1
	and	r0, r0, #15
	cmp	r5, r1
	strh	r0, [r2, #-32]	@ movhi
	bls	.L2
	add	r2, sp, #80
	add	r2, r2, r1, lsl #1
	ldrh	r1, [r2, #-48]
	ldrh	r0, [r2, #-64]
	cmp	r1, #0
	movne	ip, r1
	addeq	ip, r1, #1
	add	r1, r3, #3
	asr	r0, r0, ip
	uxtb	r1, r1
	and	r0, r0, #15
	cmp	r5, r1
	strh	r0, [r2, #-32]	@ movhi
	bls	.L2
	add	r2, sp, #80
	add	r2, r2, r1, lsl #1
	ldrh	r1, [r2, #-48]
	ldrh	r0, [r2, #-64]
	cmp	r1, #0
	movne	ip, r1
	addeq	ip, r1, #1
	add	r1, r3, #4
	asr	r0, r0, ip
	uxtb	r1, r1
	and	r0, r0, #15
	cmp	r5, r1
	strh	r0, [r2, #-32]	@ movhi
	bls	.L2
	add	r2, sp, #80
	add	r2, r2, r1, lsl #1
	ldrh	r1, [r2, #-48]
	ldrh	r0, [r2, #-64]
	cmp	r1, #0
	movne	ip, r1
	addeq	ip, r1, #1
	add	r1, r3, #5
	asr	r0, r0, ip
	uxtb	r1, r1
	and	r0, r0, #15
	cmp	r5, r1
	strh	r0, [r2, #-32]	@ movhi
	bls	.L2
	add	r2, sp, #80
	add	r2, r2, r1, lsl #1
	ldrh	r0, [r2, #-48]
	ldrh	r1, [r2, #-64]
	cmp	r0, #0
	addeq	r0, r0, #1
	add	r3, r3, #6
	uxtb	r3, r3
	asr	r1, r1, r0
	and	r1, r1, #15
	cmp	r5, r3
	strh	r1, [r2, #-32]	@ movhi
	bls	.L2
	add	r2, sp, #80
	add	r3, r2, r3, lsl #1
	ldrh	r1, [r3, #-48]
	ldrh	r2, [r3, #-64]
	cmp	r1, #0
	addeq	r1, r1, #1
	asr	r2, r2, r1
	and	r2, r2, #15
	strh	r2, [r3, #-32]	@ movhi
.L2:
	add	r3, sp, #48
	vld1.16	{d22-d23}, [r3:64]
	vorr	d16, d18, d20
	vmovn.i16	d22, q11
	vmov.i8	d17, #0x55  @ v8qi
	vorr	d16, d16, d22
	veor	d16, d16, d17
	add	r3, sp, #4
	vst1.8	{d16}, [r3]
	ldmia	r3!, {r0, r1}
	str	r0, [r6]	@ unaligned
	mov	r0, r6
	strb	r5, [r6, #8]
	str	r1, [r6, #4]	@ unaligned
	add	sp, sp, #80
	@ sp needed
	pop	{r4, r5, r6, lr}
	add	sp, sp, #16
	bx	lr
.L5:
	mov	r3, r4
	b	.L3
	.size	compress_batch, .-compress_batch
	.align	2
	.global	expand_batch
	.syntax unified
	.arm
	.fpu neon
	.type	expand_batch, %function
expand_batch:
	@ args = 0, pretend = 0, frame = 88
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	mov	r6, #0
	sub	sp, sp, #88
	add	ip, sp, #4
	stm	ip, {r1, r2, r3}
	ldrb	r5, [sp, #12]	@ zero_extendqisi2
	mov	r4, r0
	mov	r1, ip
	mov	r2, r5
	add	r0, sp, #20
	str	r6, [sp, #20]
	str	r6, [sp, #24]
	bl	memcpy
	add	r3, sp, #20
	vld1.8	{d17}, [r3]
	vmov.i8	d16, #0x55  @ v8qi
	veor	d16, d16, d17
	vmov.i8	d18, #0x7  @ v8qi
	vshr.u8	d19, d16, #4
	vmov.i8	d17, #0xf  @ v8qi
	vand	d18, d18, d19
	vshr.u8	d19, d16, #7
	vand	d16, d17, d16
	add	r3, sp, #36
	vst1.8	{d18}, [r3]
	add	r3, sp, #28
	vst1.8	{d19}, [r3]
	cmp	r5, r6
	add	r3, sp, #44
	str	r6, [sp, #52]
	vst1.8	{d16}, [r3]
	str	r6, [sp, #56]
	str	r6, [sp, #60]
	str	r6, [sp, #64]
	beq	.L17
	ldrb	r2, [sp, #36]	@ zero_extendqisi2
	ldrb	r3, [sp, #44]	@ zero_extendqisi2
	cmp	r2, r6
	orrne	r3, r3, #16
	subne	r2, r2, #1
	lslne	r3, r3, r2
	lsleq	r3, r3, #1
	orreq	r3, r3, #1
	uxthne	r3, r3
	ldrb	r2, [sp, #28]	@ zero_extendqisi2
	lsl	r3, r3, #3
	cmp	r2, #0
	uxth	r3, r3
	rsbne	r3, r3, #0
	sxth	r3, r3
	cmp	r5, #1
	strh	r3, [sp, #52]	@ movhi
	bls	.L17
	ldrb	r2, [sp, #37]	@ zero_extendqisi2
	ldrb	r3, [sp, #45]	@ zero_extendqisi2
	cmp	r2, #0
	orrne	r3, r3, #16
	subne	r2, r2, #1
	lslne	r3, r3, r2
	lsleq	r3, r3, #1
	orreq	r3, r3, #1
	uxthne	r3, r3
	ldrb	r2, [sp, #29]	@ zero_extendqisi2
	lsl	r3, r3, #3
	cmp	r2, #0
	uxth	r3, r3
	rsbne	r3, r3, #0
	sxth	r3, r3
	cmp	r5, #2
	strh	r3, [sp, #54]	@ movhi
	beq	.L17
	ldrb	r2, [sp, #38]	@ zero_extendqisi2
	ldrb	r3, [sp, #46]	@ zero_extendqisi2
	cmp	r2, #0
	orrne	r3, r3, #16
	subne	r2, r2, #1
	lslne	r3, r3, r2
	lsleq	r3, r3, #1
	orreq	r3, r3, #1
	uxthne	r3, r3
	ldrb	r2, [sp, #30]	@ zero_extendqisi2
	lsl	r3, r3, #3
	cmp	r2, #0
	uxth	r3, r3
	rsbne	r3, r3, #0
	sxth	r3, r3
	cmp	r5, #3
	strh	r3, [sp, #56]	@ movhi
	beq	.L17
	ldrb	r2, [sp, #39]	@ zero_extendqisi2
	ldrb	r3, [sp, #47]	@ zero_extendqisi2
	cmp	r2, #0
	orrne	r3, r3, #16
	subne	r2, r2, #1
	lslne	r3, r3, r2
	lsleq	r3, r3, #1
	orreq	r3, r3, #1
	uxthne	r3, r3
	ldrb	r2, [sp, #31]	@ zero_extendqisi2
	lsl	r3, r3, #3
	cmp	r2, #0
	uxth	r3, r3
	rsbne	r3, r3, #0
	sxth	r3, r3
	cmp	r5, #4
	strh	r3, [sp, #58]	@ movhi
	beq	.L17
	ldrb	r2, [sp, #40]	@ zero_extendqisi2
	ldrb	r3, [sp, #48]	@ zero_extendqisi2
	cmp	r2, #0
	orrne	r3, r3, #16
	subne	r2, r2, #1
	lslne	r3, r3, r2
	lsleq	r3, r3, #1
	orreq	r3, r3, #1
	uxthne	r3, r3
	ldrb	r2, [sp, #32]	@ zero_extendqisi2
	lsl	r3, r3, #3
	cmp	r2, #0
	uxth	r3, r3
	rsbne	r3, r3, #0
	sxth	r3, r3
	cmp	r5, #5
	strh	r3, [sp, #60]	@ movhi
	beq	.L17
	ldrb	r2, [sp, #41]	@ zero_extendqisi2
	ldrb	r3, [sp, #49]	@ zero_extendqisi2
	cmp	r2, #0
	orrne	r3, r3, #16
	subne	r2, r2, #1
	lslne	r3, r3, r2
	lsleq	r3, r3, #1
	orreq	r3, r3, #1
	uxthne	r3, r3
	ldrb	r2, [sp, #33]	@ zero_extendqisi2
	lsl	r3, r3, #3
	cmp	r2, #0
	uxth	r3, r3
	rsbne	r3, r3, #0
	sxth	r3, r3
	cmp	r5, #6
	strh	r3, [sp, #62]	@ movhi
	beq	.L17
	ldrb	r2, [sp, #42]	@ zero_extendqisi2
	ldrb	r3, [sp, #50]	@ zero_extendqisi2
	cmp	r2, #0
	orrne	r3, r3, #16
	subne	r2, r2, #1
	lslne	r3, r3, r2
	lsleq	r3, r3, #1
	orreq	r3, r3, #1
	uxthne	r3, r3
	ldrb	r2, [sp, #34]	@ zero_extendqisi2
	lsl	r3, r3, #3
	cmp	r2, #0
	uxth	r3, r3
	rsbne	r3, r3, #0
	sxth	r3, r3
	cmp	r5, #7
	strh	r3, [sp, #64]	@ movhi
	beq	.L17
	ldrb	r2, [sp, #43]	@ zero_extendqisi2
	ldrb	r3, [sp, #51]	@ zero_extendqisi2
	cmp	r2, #0
	orrne	r3, r3, #16
	subne	r2, r2, #1
	lslne	r3, r3, r2
	lsleq	r3, r3, #1
	orreq	r3, r3, #1
	uxthne	r3, r3
	ldrb	r2, [sp, #35]	@ zero_extendqisi2
	lsl	r3, r3, #3
	uxth	r3, r3
	cmp	r2, #0
	rsbne	r3, r3, #0
	sxth	r3, r3
	strh	r3, [sp, #66]	@ movhi
.L17:
	add	r3, sp, #52
	vld1.16	{d16-d17}, [r3]
	add	r3, sp, #68
	vst1.16	{d16-d17}, [r3]
	mov	ip, r3
	ldmia	ip!, {r0, r1, r2, r3}
	str	r0, [r4]	@ unaligned
	mov	r0, r4
	strb	r5, [sp, #84]
	ldrh	ip, [ip]	@ unaligned
	str	r1, [r4, #4]	@ unaligned
	strh	ip, [r4, #16]	@ unaligned
	str	r2, [r4, #8]	@ unaligned
	str	r3, [r4, #12]	@ unaligned
	add	sp, sp, #88
	@ sp needed
	pop	{r4, r5, r6, pc}
	.size	expand_batch, .-expand_batch
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu neon
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 96
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, lr}
	cmp	r0, #3
	sub	sp, sp, #104
	mov	r4, r1
	beq	.L67
	movw	r0, #:lower16:.LC0
	ldr	r1, [r1]
	movt	r0, #:upper16:.LC0
	bl	printf
	mov	r0, #1
.L66:
	add	sp, sp, #104
	@ sp needed
	pop	{r4, r5, r6, r7, r8, pc}
.L67:
	movw	r1, #:lower16:.LC1
	ldr	r0, [r4, #4]
	movt	r1, #:upper16:.LC1
	bl	fopen
	subs	r7, r0, #0
	beq	.L74
	movw	r1, #:lower16:.LC3
	ldr	r0, [r4, #8]
	movt	r1, #:upper16:.LC3
	bl	fopen
	subs	r8, r0, #0
	beq	.L75
	mov	r3, r7
	mov	r2, #44
	mov	r1, #1
	add	r0, sp, #60
	bl	fread
	mov	r3, r8
	add	r0, sp, #60
	mov	r2, #44
	mov	r1, #1
	bl	fwrite
	add	r4, sp, #20
	add	r6, sp, #8
	b	.L71
.L72:
	ldm	r3, {r0, r1}
	str	r0, [sp]
	strh	r1, [sp, #4]	@ movhi
	ldm	r4, {r1, r2, r3}
	mov	r0, r6
	bl	compress_batch
	ldm	r6, {r1, r2, r3}
	add	r0, sp, #40
	bl	expand_batch
	mov	r3, r8
	add	r0, sp, #40
	ldrb	r2, [sp, #56]	@ zero_extendqisi2
	mov	r1, #2
	bl	fwrite
.L71:
	mov	r3, r7
	mov	r2, #8
	mov	r1, #2
	mov	r0, r4
	bl	fread
	uxtb	r5, r0
	cmp	r5, #0
	add	r3, sp, #32
	strb	r5, [sp, #36]
	bne	.L72
	mov	r0, r7
	bl	fclose
	mov	r0, r8
	bl	fclose
	mov	r0, r5
	b	.L66
.L74:
	movw	r0, #:lower16:.LC2
	movt	r0, #:upper16:.LC2
	bl	perror
	mov	r0, #1
	b	.L66
.L75:
	movw	r0, #:lower16:.LC4
	movt	r0, #:upper16:.LC4
	bl	perror
	mov	r0, #1
	b	.L66
	.size	main, .-main
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"Incorrect arguments, please use: %s input_file.wav "
	.ascii	"output_file.wav\012\000"
.LC1:
	.ascii	"rb\000"
	.space	1
.LC2:
	.ascii	"input_file failed to open\000"
	.space	2
.LC3:
	.ascii	"wb\000"
	.space	1
.LC4:
	.ascii	"output_file failed to open\000"
	.ident	"GCC: (GNU) 8.2.1 20180801 (Red Hat 8.2.1-2)"
	.section	.note.GNU-stack,"",%progbits

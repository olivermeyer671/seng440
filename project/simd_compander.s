	.arch armv7-a
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
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
	@ args = 24, pretend = 16, frame = 544
	@ frame_needed = 1, uses_anonymous_args = 0
	sub	sp, sp, #16
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #544
	str	r0, [fp, #-544]
	add	r0, fp, #8
	stm	r0, {r1, r2, r3}
	sub	r3, fp, #480
	mov	r2, #0
	str	r2, [r3]
	str	r2, [r3, #4]
	str	r2, [r3, #8]
	str	r2, [r3, #12]
	ldrb	r3, [fp, #24]	@ zero_extendqisi2
	lsl	r2, r3, #1
	add	r1, fp, #8
	sub	r3, fp, #480
	mov	r0, r3
	bl	memcpy
	sub	r3, fp, #480
	str	r3, [fp, #-376]
	ldr	r3, [fp, #-376]
	vld1.16	{d16-d17}, [r3]
	vstr	d16, [fp, #-28]
	vstr	d17, [fp, #-20]
	vldr	d16, [fp, #-28]
	vldr	d17, [fp, #-20]
	vstr	d16, [fp, #-372]
	vstr	d17, [fp, #-364]
	vldr	d16, [fp, #-372]
	vldr	d17, [fp, #-364]
	vstr	d16, [fp, #-356]
	vstr	d17, [fp, #-348]
	vldr	d16, [fp, #-356]
	vldr	d17, [fp, #-348]
	vshr.u16	q8, q8, #15
	vstr	d16, [fp, #-44]
	vstr	d17, [fp, #-36]
	vldr	d16, [fp, #-44]
	vldr	d17, [fp, #-36]
	vstr	d16, [fp, #-340]
	vstr	d17, [fp, #-332]
	vldr	d16, [fp, #-340]
	vldr	d17, [fp, #-332]
	vshl.i16	q8, q8, #7
	vstr	d16, [fp, #-324]
	vstr	d17, [fp, #-316]
	vldr	d16, [fp, #-324]
	vldr	d17, [fp, #-316]
	vmovn.i16	d16, q8
	vstr	d16, [fp, #-52]
	vldr	d16, [fp, #-28]
	vldr	d17, [fp, #-20]
	vstr	d16, [fp, #-308]
	vstr	d17, [fp, #-300]
	vldr	d16, [fp, #-308]
	vldr	d17, [fp, #-300]
	vabs.s16	q8, q8
	vstr	d16, [fp, #-292]
	vstr	d17, [fp, #-284]
	vldr	d16, [fp, #-292]
	vldr	d17, [fp, #-284]
	vstr	d16, [fp, #-276]
	vstr	d17, [fp, #-268]
	vldr	d16, [fp, #-276]
	vldr	d17, [fp, #-268]
	vshr.u16	q8, q8, #3
	vstr	d16, [fp, #-68]
	vstr	d17, [fp, #-60]
	vldr	d16, [fp, #-68]
	vldr	d17, [fp, #-60]
	vstr	d16, [fp, #-260]
	vstr	d17, [fp, #-252]
	vldr	d16, [fp, #-260]
	vldr	d17, [fp, #-252]
	vclz.i16	q8, q8
	vstr	d16, [fp, #-84]
	vstr	d17, [fp, #-76]
	mov	r3, #11
	strh	r3, [fp, #-238]	@ movhi
	ldrsh	r3, [fp, #-238]
	vdup.16	q8, r3
	vstr	d16, [fp, #-220]
	vstr	d17, [fp, #-212]
	vldr	d16, [fp, #-84]
	vldr	d17, [fp, #-76]
	vstr	d16, [fp, #-236]
	vstr	d17, [fp, #-228]
	vldr	d16, [fp, #-220]
	vldr	d17, [fp, #-212]
	vldr	d18, [fp, #-236]
	vldr	d19, [fp, #-228]
	vqsub.u16	q8, q8, q9
	vstr	d16, [fp, #-100]
	vstr	d17, [fp, #-92]
	vldr	d16, [fp, #-100]
	vldr	d17, [fp, #-92]
	vstr	d16, [fp, #-204]
	vstr	d17, [fp, #-196]
	vldr	d16, [fp, #-204]
	vldr	d17, [fp, #-196]
	vshl.i16	q8, q8, #4
	vstr	d16, [fp, #-188]
	vstr	d17, [fp, #-180]
	vldr	d16, [fp, #-188]
	vldr	d17, [fp, #-180]
	vmovn.i16	d16, q8
	vstr	d16, [fp, #-108]
	sub	r3, fp, #496
	mov	r2, #0
	str	r2, [r3]
	str	r2, [r3, #4]
	str	r2, [r3, #8]
	str	r2, [r3, #12]
	sub	r3, fp, #496
	str	r3, [fp, #-152]
	vldr	d16, [fp, #-68]
	vldr	d17, [fp, #-60]
	vstr	d16, [fp, #-172]
	vstr	d17, [fp, #-164]
	vldr	d16, [fp, #-172]
	vldr	d17, [fp, #-164]
	ldr	r3, [fp, #-152]
	vst1.16	{d16-d17}, [r3]
	sub	r3, fp, #512
	mov	r2, #0
	str	r2, [r3]
	str	r2, [r3, #4]
	str	r2, [r3, #8]
	str	r2, [r3, #12]
	sub	r3, fp, #512
	str	r3, [fp, #-128]
	vldr	d16, [fp, #-100]
	vldr	d17, [fp, #-92]
	vstr	d16, [fp, #-148]
	vstr	d17, [fp, #-140]
	vldr	d16, [fp, #-148]
	vldr	d17, [fp, #-140]
	ldr	r3, [fp, #-128]
	vst1.16	{d16-d17}, [r3]
	sub	r3, fp, #528
	mov	r2, #0
	str	r2, [r3]
	str	r2, [r3, #4]
	str	r2, [r3, #8]
	str	r2, [r3, #12]
	mov	r3, #0
	strb	r3, [fp, #-5]
	b	.L15
.L16:
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	sub	r2, fp, #4
	sub	r2, r2, #492
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	mov	r1, r3
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	sub	r2, fp, #4
	sub	r2, r2, #508
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	mov	r0, r3
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	sub	r2, fp, #4
	sub	r2, r2, #508
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r3, [r3]
	cmp	r3, #0
	moveq	r3, #1
	movne	r3, #0
	uxtb	r3, r3
	add	r3, r0, r3
	asr	r3, r1, r3
	uxth	r2, r3
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	and	r2, r2, #15
	uxth	r2, r2
	sub	r1, fp, #4
	sub	r1, r1, #524
	lsl	r3, r3, #1
	add	r3, r1, r3
	strh	r2, [r3]	@ movhi
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	add	r3, r3, #1
	strb	r3, [fp, #-5]
.L15:
	ldrb	r3, [fp, #24]	@ zero_extendqisi2
	ldrb	r2, [fp, #-5]	@ zero_extendqisi2
	cmp	r2, r3
	bcc	.L16
	sub	r3, fp, #528
	str	r3, [fp, #-464]
	ldr	r3, [fp, #-464]
	vld1.16	{d16-d17}, [r3]
	vstr	d16, [fp, #-460]
	vstr	d17, [fp, #-452]
	vldr	d16, [fp, #-460]
	vldr	d17, [fp, #-452]
	vmovn.i16	d16, q8
	vstr	d16, [fp, #-116]
	vldr	d16, [fp, #-108]
	vstr	d16, [fp, #-436]
	vldr	d16, [fp, #-116]
	vstr	d16, [fp, #-444]
	vldr	d17, [fp, #-436]
	vldr	d16, [fp, #-444]
	vorr	d16, d17, d16
	vmov	d17, d16  @ v8qi
	vldr	d16, [fp, #-52]
	vstr	d16, [fp, #-420]
	vstr	d17, [fp, #-428]
	vldr	d17, [fp, #-420]
	vldr	d16, [fp, #-428]
	vorr	d16, d17, d16
	vstr	d16, [fp, #-124]
	mov	r3, #85
	strb	r3, [fp, #-405]
	sub	r3, fp, #404
	sub	r3, r3, #1
	ldrsb	r3, [r3]
	vdup.8	d16, r3
	vmov	d17, d16  @ v8qi
	vldr	d16, [fp, #-124]
	vstr	d16, [fp, #-396]
	vstr	d17, [fp, #-404]
	vldr	d17, [fp, #-396]
	vldr	d16, [fp, #-404]
	veor	d16, d17, d16
	vstr	d16, [fp, #-124]
	sub	r3, fp, #540
	str	r3, [fp, #-380]
	vldr	d16, [fp, #-124]
	vstr	d16, [fp, #-388]
	vldr	d16, [fp, #-388]
	ldr	r3, [fp, #-380]
	vst1.8	{d16}, [r3]
	ldrb	r3, [fp, #24]	@ zero_extendqisi2
	strb	r3, [fp, #-532]
	ldr	r3, [fp, #-544]
	mov	r2, r3
	sub	r3, fp, #540
	ldmia	r3!, {r0, r1}
	str	r0, [r2]	@ unaligned
	str	r1, [r2, #4]	@ unaligned
	ldrb	r3, [r3]
	strb	r3, [r2, #8]
	ldr	r0, [fp, #-544]
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, lr}
	add	sp, sp, #16
	bx	lr
	.size	compress_batch, .-compress_batch
	.align	2
	.global	expand_batch
	.syntax unified
	.arm
	.fpu neon
	.type	expand_batch, %function
expand_batch:
	@ args = 0, pretend = 0, frame = 312
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #312
	str	r0, [fp, #-304]
	sub	r0, fp, #316
	stm	r0, {r1, r2, r3}
	sub	r3, fp, #240
	mov	r2, #0
	str	r2, [r3]
	str	r2, [r3, #4]
	ldrb	r3, [fp, #-308]	@ zero_extendqisi2
	mov	r2, r3
	sub	r1, fp, #316
	sub	r3, fp, #240
	mov	r0, r3
	bl	memcpy
	sub	r3, fp, #240
	str	r3, [fp, #-204]
	ldr	r3, [fp, #-204]
	vld1.8	{d16}, [r3]
	vmov	d17, d16  @ v8qi
	mov	r3, #85
	strb	r3, [fp, #-197]
	ldrsb	r3, [fp, #-197]
	vdup.8	d16, r3
	vstr	d17, [fp, #-188]
	vstr	d16, [fp, #-196]
	vldr	d17, [fp, #-188]
	vldr	d16, [fp, #-196]
	veor	d16, d17, d16
	vstr	d16, [fp, #-20]
	vldr	d16, [fp, #-20]
	vstr	d16, [fp, #-180]
	vldr	d16, [fp, #-180]
	vshr.u8	d16, d16, #7
	vstr	d16, [fp, #-28]
	vldr	d16, [fp, #-20]
	vstr	d16, [fp, #-172]
	vldr	d16, [fp, #-172]
	vshr.u8	d16, d16, #4
	vmov	d17, d16  @ v8qi
	mov	r3, #7
	strb	r3, [fp, #-157]
	ldrsb	r3, [fp, #-157]
	vdup.8	d16, r3
	vstr	d17, [fp, #-148]
	vstr	d16, [fp, #-156]
	vldr	d17, [fp, #-148]
	vldr	d16, [fp, #-156]
	vand	d16, d17, d16
	vstr	d16, [fp, #-36]
	mov	r3, #15
	strb	r3, [fp, #-133]
	ldrsb	r3, [fp, #-133]
	vdup.8	d16, r3
	vmov	d17, d16  @ v8qi
	vldr	d16, [fp, #-20]
	vstr	d16, [fp, #-124]
	vstr	d17, [fp, #-132]
	vldr	d17, [fp, #-124]
	vldr	d16, [fp, #-132]
	vand	d16, d17, d16
	vstr	d16, [fp, #-44]
	sub	r3, fp, #248
	mov	r2, #0
	str	r2, [r3]
	str	r2, [r3, #4]
	sub	r3, fp, #248
	str	r3, [fp, #-104]
	vldr	d16, [fp, #-28]
	vstr	d16, [fp, #-116]
	vldr	d16, [fp, #-116]
	ldr	r3, [fp, #-104]
	vst1.8	{d16}, [r3]
	sub	r3, fp, #256
	mov	r2, #0
	str	r2, [r3]
	str	r2, [r3, #4]
	sub	r3, fp, #256
	str	r3, [fp, #-88]
	vldr	d16, [fp, #-36]
	vstr	d16, [fp, #-100]
	vldr	d16, [fp, #-100]
	ldr	r3, [fp, #-88]
	vst1.8	{d16}, [r3]
	sub	r3, fp, #264
	mov	r2, #0
	str	r2, [r3]
	str	r2, [r3, #4]
	sub	r3, fp, #264
	str	r3, [fp, #-72]
	vldr	d16, [fp, #-44]
	vstr	d16, [fp, #-84]
	vldr	d16, [fp, #-84]
	ldr	r3, [fp, #-72]
	vst1.8	{d16}, [r3]
	sub	r3, fp, #280
	mov	r2, #0
	str	r2, [r3]
	str	r2, [r3, #4]
	str	r2, [r3, #8]
	str	r2, [r3, #12]
	mov	r3, #0
	strb	r3, [fp, #-5]
	b	.L34
.L39:
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	sub	r2, fp, #4
	add	r3, r2, r3
	ldrb	r3, [r3, #-252]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L35
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	sub	r2, fp, #4
	add	r3, r2, r3
	ldrb	r3, [r3, #-260]	@ zero_extendqisi2
	lsl	r3, r3, #1
	sxth	r3, r3
	orr	r3, r3, #1
	sxth	r3, r3
	uxth	r3, r3
	b	.L36
.L35:
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	sub	r2, fp, #4
	add	r3, r2, r3
	ldrb	r3, [r3, #-260]	@ zero_extendqisi2
	orr	r3, r3, #16
	uxtb	r3, r3
	mov	r2, r3
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	sub	r1, fp, #4
	add	r3, r1, r3
	ldrb	r3, [r3, #-252]	@ zero_extendqisi2
	sub	r3, r3, #1
	lsl	r3, r2, r3
	uxth	r3, r3
.L36:
	strh	r3, [fp, #-46]	@ movhi
	ldrh	r3, [fp, #-46]	@ movhi
	lsl	r3, r3, #3
	strh	r3, [fp, #-46]	@ movhi
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	sub	r2, fp, #4
	add	r3, r2, r3
	ldrb	r3, [r3, #-244]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L37
	ldrh	r3, [fp, #-46]	@ movhi
	rsb	r3, r3, #0
	uxth	r3, r3
	sxth	r3, r3
	b	.L38
.L37:
	ldrsh	r3, [fp, #-46]
.L38:
	strh	r3, [fp, #-48]	@ movhi
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	sub	r2, fp, #4
	sub	r2, r2, #276
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrh	r2, [fp, #-48]	@ movhi
	strh	r2, [r3]	@ movhi
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	add	r3, r3, #1
	strb	r3, [fp, #-5]
.L34:
	ldrb	r3, [fp, #-308]	@ zero_extendqisi2
	ldrb	r2, [fp, #-5]	@ zero_extendqisi2
	cmp	r2, r3
	bcc	.L39
	sub	r3, fp, #280
	str	r3, [fp, #-232]
	ldr	r3, [fp, #-232]
	vld1.16	{d16-d17}, [r3]
	vstr	d16, [fp, #-68]
	vstr	d17, [fp, #-60]
	sub	r3, fp, #300
	str	r3, [fp, #-208]
	vldr	d16, [fp, #-68]
	vldr	d17, [fp, #-60]
	vstr	d16, [fp, #-228]
	vstr	d17, [fp, #-220]
	ldr	r3, [fp, #-208]
	vldr	d16, [fp, #-228]
	vldr	d17, [fp, #-220]
	vst1.16	{d16-d17}, [r3]
	ldrb	r3, [fp, #-308]	@ zero_extendqisi2
	strb	r3, [fp, #-284]
	ldr	r3, [fp, #-304]
	mov	lr, r3
	sub	ip, fp, #300
	ldmia	ip!, {r0, r1, r2, r3}
	str	r0, [lr]	@ unaligned
	str	r1, [lr, #4]	@ unaligned
	str	r2, [lr, #8]	@ unaligned
	str	r3, [lr, #12]	@ unaligned
	ldrh	r3, [ip]	@ unaligned
	strh	r3, [lr, #16]	@ unaligned
	ldr	r0, [fp, #-304]
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	expand_batch, .-expand_batch
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Incorrect arguments, please use: %s input_file.wav "
	.ascii	"output_file.wav\012\000"
	.align	2
.LC1:
	.ascii	"rb\000"
	.align	2
.LC2:
	.ascii	"input_file failed to open\000"
	.align	2
.LC3:
	.ascii	"wb\000"
	.align	2
.LC4:
	.ascii	"output_file failed to open\000"
	.text
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu neon
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 112
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #120
	str	r0, [fp, #-112]
	str	r1, [fp, #-116]
	ldr	r3, [fp, #-112]
	cmp	r3, #3
	beq	.L43
	ldr	r3, [fp, #-116]
	ldr	r3, [r3]
	mov	r1, r3
	movw	r0, #:lower16:.LC0
	movt	r0, #:upper16:.LC0
	bl	printf
	mov	r3, #1
	b	.L49
.L43:
	ldr	r3, [fp, #-116]
	add	r3, r3, #4
	ldr	r3, [r3]
	movw	r1, #:lower16:.LC1
	movt	r1, #:upper16:.LC1
	mov	r0, r3
	bl	fopen
	str	r0, [fp, #-8]
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	bne	.L45
	movw	r0, #:lower16:.LC2
	movt	r0, #:upper16:.LC2
	bl	perror
	mov	r3, #1
	b	.L49
.L45:
	ldr	r3, [fp, #-116]
	add	r3, r3, #8
	ldr	r3, [r3]
	movw	r1, #:lower16:.LC3
	movt	r1, #:upper16:.LC3
	mov	r0, r3
	bl	fopen
	str	r0, [fp, #-12]
	ldr	r3, [fp, #-12]
	cmp	r3, #0
	bne	.L46
	movw	r0, #:lower16:.LC4
	movt	r0, #:upper16:.LC4
	bl	perror
	mov	r3, #1
	b	.L49
.L46:
	sub	r0, fp, #56
	ldr	r3, [fp, #-8]
	mov	r2, #44
	mov	r1, #1
	bl	fread
	sub	r0, fp, #56
	ldr	r3, [fp, #-12]
	mov	r2, #44
	mov	r1, #1
	bl	fwrite
	b	.L47
.L48:
	sub	ip, fp, #88
	mov	r3, sp
	sub	r2, fp, #64
	ldm	r2, {r0, r1}
	str	r0, [r3]
	add	r3, r3, #4
	strh	r1, [r3]	@ movhi
	sub	r3, fp, #76
	ldm	r3, {r1, r2, r3}
	mov	r0, ip
	bl	compress_batch
	sub	r0, fp, #108
	sub	r3, fp, #88
	ldm	r3, {r1, r2, r3}
	bl	expand_batch
	ldrb	r3, [fp, #-92]	@ zero_extendqisi2
	mov	r2, r3
	sub	r0, fp, #108
	ldr	r3, [fp, #-12]
	mov	r1, #2
	bl	fwrite
.L47:
	sub	r0, fp, #76
	ldr	r3, [fp, #-8]
	mov	r2, #8
	mov	r1, #2
	bl	fread
	mov	r3, r0
	uxtb	r3, r3
	strb	r3, [fp, #-60]
	ldrb	r3, [fp, #-60]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L48
	ldr	r0, [fp, #-8]
	bl	fclose
	ldr	r0, [fp, #-12]
	bl	fclose
	mov	r3, #0
.L49:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	main, .-main
	.ident	"GCC: (GNU) 8.2.1 20180801 (Red Hat 8.2.1-2)"
	.section	.note.GNU-stack,"",%progbits

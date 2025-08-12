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
	.file	"simd_compander.c"
	.text
	.align	2
	.global	compress_batch
	.arch armv7ve
	.syntax unified
	.arm
	.fpu neon
	.type	compress_batch, %function
compress_batch:
	@ args = 24, pretend = 16, frame = 32
	@ frame_needed = 0, uses_anonymous_args = 0
	sub	sp, sp, #16
	vmov.i32	q8, #0  @ v16qi
	strd	r4, [sp, #-12]!
	mov	r4, r0
	str	lr, [sp, #8]
	sub	sp, sp, #36
	ldrb	r5, [sp, #68]	@ zero_extendqisi2
	add	ip, sp, #52
	add	r0, sp, #16
	stm	ip, {r1, r2, r3}
	mov	r1, ip
	lsl	r2, r5, #1
	vst1.8	{q8}, [r0:64]
	bl	memcpy
	add	r3, sp, #16
	vmov.i16	q13, #11  @ v8hi
	vmov.i16	q8, #1  @ v8hi
	vmov.i16	q12, #15  @ v8hi
	vmov.i8	d20, #0x55  @ v8qi
	mov	r0, r4
	vld1.16	{d22-d23}, [r3:64]
	add	r3, sp, #4
	strb	r5, [r4, #8]
	vabs.s16	q9, q11
	vshr.u16	q11, q11, #15
	vshl.i16	q11, q11, #7
	vshr.u16	q9, q9, #3
	vmovn.i16	d22, q11
	vclz.i16	q14, q9
	vqsub.u16	q13, q13, q14
	vceq.i16	q15, q13, #0
	vshl.i16	q14, q13, #4
	vmovn.i16	d28, q14
	vand	q8, q8, q15
	vorr	d22, d28, d22
	vadd.i16	q8, q8, q13
	vneg.s16	q8, q8
	vshl.u16	q8, q9, q8
	vand	q8, q12, q8
	vmovn.i16	d16, q8
	vorr	d22, d22, d16
	veor	d20, d22, d20
	vst1.8	{d20}, [r3]
	ldrd	r2, [sp, #4]
	str	r2, [r4]	@ unaligned
	str	r3, [r4, #4]	@ unaligned
	add	sp, sp, #36
	@ sp needed
	ldrd	r4, [sp]
	ldr	lr, [sp, #8]
	add	sp, sp, #12
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
	@ args = 0, pretend = 0, frame = 48
	@ frame_needed = 0, uses_anonymous_args = 0
	strd	r4, [sp, #-12]!
	vmov.i32	d16, #0  @ v8qi
	mov	r4, r0
	str	lr, [sp, #8]
	sub	sp, sp, #52
	add	ip, sp, #4
	add	r0, sp, #20
	stm	ip, {r1, r2, r3}
	mov	r1, ip
	ldrb	r5, [sp, #12]	@ zero_extendqisi2
	vstr	d16, [sp, #20]
	mov	r2, r5
	bl	memcpy
	add	r3, sp, #20
	vmov.i8	d16, #0x55  @ v8qi
	vmov.i8	d18, #0xf  @ v8qi
	vmov.i8	d20, #0x7  @ v8qi
	vmov.i16	q11, #1  @ v8hi
	strb	r5, [sp, #44]
	vld1.8	{d17}, [r3]
	add	r1, sp, #32
	mov	r0, r4
	ldrh	r3, [sp, #44]
	strh	r3, [r4, #16]	@ unaligned
	add	r3, sp, #28
	veor	d16, d16, d17
	vand	d18, d18, d16
	vshr.u8	d17, d16, #4
	vshr.u8	d16, d16, #7
	vmovl.u8	q9, d18
	vand	d20, d20, d17
	vmovl.u8	q8, d16
	vshl.i16	q9, q9, #1
	vmovl.u8	q10, d20
	vceq.i16	q8, q8, q11
	vorr	q9, q11, q9
	vqsub.u16	q11, q10, q11
	vceq.i16	q10, q10, #0
	vmov	q12, q9  @ v8hi
	vorr.i16	q12, #32
	vshl.u16	q11, q12, q11
	vbif	q9, q11, q10
	vshl.i16	q9, q9, #3
	vneg.s16	q10, q9
	vbsl	q8, q10, q9
	vst1.16	{d16-d17}, [r3]
	ldm	r1, {r1, r2, r3}
	ldr	ip, [sp, #28]
	str	ip, [r4]	@ unaligned
	str	r1, [r4, #4]	@ unaligned
	str	r2, [r4, #8]	@ unaligned
	str	r3, [r4, #12]	@ unaligned
	add	sp, sp, #52
	@ sp needed
	ldrd	r4, [sp]
	add	sp, sp, #8
	ldr	pc, [sp], #4
	.size	expand_batch, .-expand_batch
	.ident	"GCC: (GNU) 8.2.1 20180801 (Red Hat 8.2.1-2)"
	.section	.note.GNU-stack,"",%progbits

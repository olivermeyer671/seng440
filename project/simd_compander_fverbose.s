	.arch armv7-a
	.eabi_attribute 28, 1	@ Tag_ABI_VFP_args
	.eabi_attribute 20, 1	@ Tag_ABI_FP_denormal
	.eabi_attribute 21, 1	@ Tag_ABI_FP_exceptions
	.eabi_attribute 23, 3	@ Tag_ABI_FP_number_model
	.eabi_attribute 24, 1	@ Tag_ABI_align8_needed
	.eabi_attribute 25, 1	@ Tag_ABI_align8_preserved
	.eabi_attribute 26, 2	@ Tag_ABI_enum_size
	.eabi_attribute 30, 6	@ Tag_ABI_optimization_goals
	.eabi_attribute 34, 1	@ Tag_CPU_unaligned_access
	.eabi_attribute 18, 4	@ Tag_ABI_PCS_wchar_t
	.file	"simd_compander.c"
@ GNU C17 (GCC) version 8.2.1 20180801 (Red Hat 8.2.1-2) (armv7hl-redhat-linux-gnueabi)
@	compiled by GNU C version 8.2.1 20180801 (Red Hat 8.2.1-2), GMP version 6.1.2, MPFR version 3.1.6-p2, MPC version 1.1.0, isl version none
@ GGC heuristics: --param ggc-min-expand=63 --param ggc-min-heapsize=62731
@ options passed:  simd_compander.c -mfpu=neon -mtune=generic-armv7-a
@ -mfloat-abi=hard -mabi=aapcs-linux -mtls-dialect=gnu -marm
@ -march=armv7-a+simd -auxbase-strip simd_compander_fverbose.s
@ -fverbose-asm
@ options enabled:  -faggressive-loop-optimizations -fauto-inc-dec
@ -fchkp-check-incomplete-type -fchkp-check-read -fchkp-check-write
@ -fchkp-instrument-calls -fchkp-narrow-bounds -fchkp-optimize
@ -fchkp-store-bounds -fchkp-use-static-bounds
@ -fchkp-use-static-const-bounds -fchkp-use-wrappers -fcommon
@ -fdelete-null-pointer-checks -fdwarf2-cfi-asm -fearly-inlining
@ -feliminate-unused-debug-types -ffp-int-builtin-inexact -ffunction-cse
@ -fgcse-lm -fgnu-runtime -fgnu-unique -fident -finline-atomics
@ -fira-hoist-pressure -fira-share-save-slots -fira-share-spill-slots
@ -fivopts -fkeep-static-consts -fleading-underscore -flifetime-dse
@ -flto-odr-type-merging -fmath-errno -fmerge-debug-strings -fpeephole
@ -fplt -fprefetch-loop-arrays -freg-struct-return
@ -fsched-critical-path-heuristic -fsched-dep-count-heuristic
@ -fsched-group-heuristic -fsched-interblock -fsched-last-insn-heuristic
@ -fsched-rank-heuristic -fsched-spec -fsched-spec-insn-heuristic
@ -fsched-stalled-insns-dep -fsemantic-interposition -fshow-column
@ -fshrink-wrap-separate -fsigned-zeros -fsplit-ivs-in-unroller
@ -fssa-backprop -fstdarg-opt -fstrict-volatile-bitfields -fsync-libcalls
@ -ftrapping-math -ftree-cselim -ftree-forwprop -ftree-loop-if-convert
@ -ftree-loop-im -ftree-loop-ivcanon -ftree-loop-optimize
@ -ftree-parallelize-loops= -ftree-phiprop -ftree-reassoc -ftree-scev-cprop
@ -funit-at-a-time -fverbose-asm -fzero-initialized-in-bss -marm -mbe32
@ -mglibc -mlittle-endian -mpic-data-is-text-relative -msched-prolog
@ -munaligned-access -mvectorize-with-neon-quad

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
	sub	sp, sp, #16	@,,
	push	{fp, lr}	@
	add	fp, sp, #4	@,,
	sub	sp, sp, #544	@,,
	str	r0, [fp, #-544]	@ .result_ptr, .result_ptr
	add	r0, fp, #8	@ tmp205,,
	stm	r0, {r1, r2, r3}	@ tmp205,,,
@ simd_compander.c:54:     int16_t sample_array[8] = {0};
	sub	r3, fp, #480	@ tmp206,,
	mov	r2, #0	@ tmp207,
	str	r2, [r3]	@ tmp207, sample_array
	str	r2, [r3, #4]	@ tmp207, sample_array
	str	r2, [r3, #8]	@ tmp207, sample_array
	str	r2, [r3, #12]	@ tmp207, sample_array
@ simd_compander.c:55:     memcpy(sample_array, input_batch.data, input_batch.count*sizeof(int16_t));
	ldrb	r3, [fp, #24]	@ zero_extendqisi2	@ _1, input_batch.count
@ simd_compander.c:55:     memcpy(sample_array, input_batch.data, input_batch.count*sizeof(int16_t));
	lsl	r2, r3, #1	@ _3, _2,
	add	r1, fp, #8	@ tmp208,,
	sub	r3, fp, #480	@ tmp209,,
	mov	r0, r3	@, tmp209
	bl	memcpy		@
	sub	r3, fp, #480	@ tmp210,,
	str	r3, [fp, #-376]	@ tmp210, __a
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:10364:   return (int16x8_t)__builtin_neon_vld1v8hi ((const __builtin_neon_hi *) __a);
	ldr	r3, [fp, #-376]	@ tmp211, __a
	vld1.16	{d16-d17}, [r3]	@ _110, MEM[(const short int[8] *)__a_109]
@ simd_compander.c:58:     int16x8_t samples = vld1q_s16(sample_array);
	vstr	d16, [fp, #-28]	@, samples
	vstr	d17, [fp, #-20]	@, samples
	vldr	d16, [fp, #-28]	@, samples
	vldr	d17, [fp, #-20]	@, samples
	vstr	d16, [fp, #-372]	@, __a
	vstr	d17, [fp, #-364]	@, __a
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:16721:   return (uint16x8_t)__a;
	vldr	d16, [fp, #-372]	@, __a
	vldr	d17, [fp, #-364]	@, __a
	vstr	d16, [fp, #-356]	@, __a
	vstr	d17, [fp, #-348]	@, __a
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:4394:   return (uint16x8_t)__builtin_neon_vshru_nv8hi ((int16x8_t) __a, __b);
	vldr	d16, [fp, #-356]	@, __a
	vldr	d17, [fp, #-348]	@, __a
	vshr.u16	q8, q8, #15	@ _105, _104,
@ simd_compander.c:61:     uint16x8_t signs = vshrq_n_u16(vreinterpretq_u16_s16(samples), 15);
	vstr	d16, [fp, #-44]	@, signs
	vstr	d17, [fp, #-36]	@, signs
	vldr	d16, [fp, #-44]	@, signs
	vldr	d17, [fp, #-36]	@, signs
	vstr	d16, [fp, #-340]	@, __a
	vstr	d17, [fp, #-332]	@, __a
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:4828:   return (uint16x8_t)__builtin_neon_vshl_nv8hi ((int16x8_t) __a, __b);
	vldr	d16, [fp, #-340]	@, __a
	vldr	d17, [fp, #-332]	@, __a
	vshl.i16	q8, q8, #7	@ _101, _100,
	vstr	d16, [fp, #-324]	@, __a
	vstr	d17, [fp, #-316]	@, __a
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:7568:   return (uint8x8_t)__builtin_neon_vmovnv8hi ((int16x8_t) __a);
	vldr	d16, [fp, #-324]	@, __a
	vldr	d17, [fp, #-316]	@, __a
	vmovn.i16	d16, q8	@ _97, _96
@ simd_compander.c:62:     uint8x8_t signs_8bit = vmovn_u16(vshlq_n_u16(signs, 7)); //shift operations on 16-bit lanes is more efficient
	vstr	d16, [fp, #-52]	@, signs_8bit
	vldr	d16, [fp, #-28]	@, samples
	vldr	d17, [fp, #-20]	@, samples
	vstr	d16, [fp, #-308]	@, __a
	vstr	d17, [fp, #-300]	@, __a
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:5638:   return (int16x8_t)__builtin_neon_vabsv8hi (__a);
	vldr	d16, [fp, #-308]	@, __a
	vldr	d17, [fp, #-300]	@, __a
	vabs.s16	q8, q8	@ _94, tmp215
	vstr	d16, [fp, #-292]	@, __a
	vstr	d17, [fp, #-284]	@, __a
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:16721:   return (uint16x8_t)__a;
	vldr	d16, [fp, #-292]	@, __a
	vldr	d17, [fp, #-284]	@, __a
	vstr	d16, [fp, #-276]	@, __a
	vstr	d17, [fp, #-268]	@, __a
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:4394:   return (uint16x8_t)__builtin_neon_vshru_nv8hi ((int16x8_t) __a, __b);
	vldr	d16, [fp, #-276]	@, __a
	vldr	d17, [fp, #-268]	@, __a
	vshr.u16	q8, q8, #3	@ _89, _88,
@ simd_compander.c:65:     uint16x8_t absolutes = vshrq_n_u16(vreinterpretq_u16_s16(vabsq_s16(samples)), 3);
	vstr	d16, [fp, #-68]	@, absolutes
	vstr	d17, [fp, #-60]	@, absolutes
	vldr	d16, [fp, #-68]	@, absolutes
	vldr	d17, [fp, #-60]	@, absolutes
	vstr	d16, [fp, #-260]	@, __a
	vstr	d17, [fp, #-252]	@, __a
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:6009:   return (uint16x8_t)__builtin_neon_vclzv8hi ((int16x8_t) __a);
	vldr	d16, [fp, #-260]	@, __a
	vldr	d17, [fp, #-252]	@, __a
	vclz.i16	q8, q8	@ _85, _84
@ simd_compander.c:68:     uint16x8_t leading_zeros = vclzq_u16(absolutes);
	vstr	d16, [fp, #-84]	@, leading_zeros
	vstr	d17, [fp, #-76]	@, leading_zeros
	mov	r3, #11	@ tmp218,
	strh	r3, [fp, #-238]	@ movhi	@ tmp217, __a
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:6756:   return (uint16x8_t)__builtin_neon_vdup_nv8hi ((__builtin_neon_hi) __a);
	ldrsh	r3, [fp, #-238]	@ __a.1_80, __a
	vdup.16	q8, r3	@ _81, __a.1_80
	vstr	d16, [fp, #-220]	@, __a
	vstr	d17, [fp, #-212]	@, __a
	vldr	d16, [fp, #-84]	@, leading_zeros
	vldr	d17, [fp, #-76]	@, leading_zeros
	vstr	d16, [fp, #-236]	@, __b
	vstr	d17, [fp, #-228]	@, __b
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:2241:   return (uint16x8_t)__builtin_neon_vqsubuv8hi ((int16x8_t) __a, (int16x8_t) __b);
	vldr	d16, [fp, #-220]	@, __a
	vldr	d17, [fp, #-212]	@, __a
	vldr	d18, [fp, #-236]	@, __b
	vldr	d19, [fp, #-228]	@, __b
	vqsub.u16	q8, q8, q9	@ _77, _75, _76
@ simd_compander.c:69:     uint16x8_t chords = vqsubq_u16(vdupq_n_u16(11), leading_zeros); // range [0,7] (if clz=3,2,1, chord could be 8,9,10 -> should not happen since 13-bit positive integer)
	vstr	d16, [fp, #-100]	@, chords
	vstr	d17, [fp, #-92]	@, chords
	vldr	d16, [fp, #-100]	@, chords
	vldr	d17, [fp, #-92]	@, chords
	vstr	d16, [fp, #-204]	@, __a
	vstr	d17, [fp, #-196]	@, __a
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:4828:   return (uint16x8_t)__builtin_neon_vshl_nv8hi ((int16x8_t) __a, __b);
	vldr	d16, [fp, #-204]	@, __a
	vldr	d17, [fp, #-196]	@, __a
	vshl.i16	q8, q8, #4	@ _71, _70,
	vstr	d16, [fp, #-188]	@, __a
	vstr	d17, [fp, #-180]	@, __a
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:7568:   return (uint8x8_t)__builtin_neon_vmovnv8hi ((int16x8_t) __a);
	vldr	d16, [fp, #-188]	@, __a
	vldr	d17, [fp, #-180]	@, __a
	vmovn.i16	d16, q8	@ _67, _66
@ simd_compander.c:70:     uint8x8_t chords_8bit = vmovn_u16(vshlq_n_u16(chords, 4));
	vstr	d16, [fp, #-108]	@, chords_8bit
@ simd_compander.c:73:     uint16_t absolutes_array[8] = {0};
	sub	r3, fp, #496	@ tmp221,,
	mov	r2, #0	@ tmp222,
	str	r2, [r3]	@ tmp222, absolutes_array
	str	r2, [r3, #4]	@ tmp222, absolutes_array
	str	r2, [r3, #8]	@ tmp222, absolutes_array
	str	r2, [r3, #12]	@ tmp222, absolutes_array
	sub	r3, fp, #496	@ tmp223,,
	str	r3, [fp, #-152]	@ tmp223, __a
	vldr	d16, [fp, #-68]	@, absolutes
	vldr	d17, [fp, #-60]	@, absolutes
	vstr	d16, [fp, #-172]	@, __b
	vstr	d17, [fp, #-164]	@, __b
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:10986:   __builtin_neon_vst1v8hi ((__builtin_neon_hi *) __a, (int16x8_t) __b);
	vldr	d16, [fp, #-172]	@, __b
	vldr	d17, [fp, #-164]	@, __b
	ldr	r3, [fp, #-152]	@ tmp225, __a
	vst1.16	{d16-d17}, [r3]	@ _64, MEM[(short int[8] *)__a_62]
@ simd_compander.c:75:     uint16_t chords_array[8] = {0};
	sub	r3, fp, #512	@ tmp226,,
	mov	r2, #0	@ tmp227,
	str	r2, [r3]	@ tmp227, chords_array
	str	r2, [r3, #4]	@ tmp227, chords_array
	str	r2, [r3, #8]	@ tmp227, chords_array
	str	r2, [r3, #12]	@ tmp227, chords_array
	sub	r3, fp, #512	@ tmp228,,
	str	r3, [fp, #-128]	@ tmp228, __a
	vldr	d16, [fp, #-100]	@, chords
	vldr	d17, [fp, #-92]	@, chords
	vstr	d16, [fp, #-148]	@, __b
	vstr	d17, [fp, #-140]	@, __b
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:10986:   __builtin_neon_vst1v8hi ((__builtin_neon_hi *) __a, (int16x8_t) __b);
	vldr	d16, [fp, #-148]	@, __b
	vldr	d17, [fp, #-140]	@, __b
	ldr	r3, [fp, #-128]	@ tmp230, __a
	vst1.16	{d16-d17}, [r3]	@ _61, MEM[(short int[8] *)__a_59]
@ simd_compander.c:77:     uint16_t steps_array[8] = {0};
	sub	r3, fp, #528	@ tmp231,,
	mov	r2, #0	@ tmp232,
	str	r2, [r3]	@ tmp232, steps_array
	str	r2, [r3, #4]	@ tmp232, steps_array
	str	r2, [r3, #8]	@ tmp232, steps_array
	str	r2, [r3, #12]	@ tmp232, steps_array
@ simd_compander.c:78:     for (uint8_t i = 0; i < input_batch.count; i++) {
	mov	r3, #0	@ tmp233,
	strb	r3, [fp, #-5]	@ tmp234, i
@ simd_compander.c:78:     for (uint8_t i = 0; i < input_batch.count; i++) {
	b	.L15		@
.L16:
@ simd_compander.c:79:         steps_array[i] = ((absolutes_array[i] >> (chords_array[i] + (chords_array[i] == 0))) & 0x0F);
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2	@ _10, i
	sub	r2, fp, #4	@ tmp235,,
	sub	r2, r2, #492	@ tmp237, tmp235,
	lsl	r3, r3, #1	@ tmp238, _10,
	add	r3, r2, r3	@ tmp239, tmp237, tmp238
	ldrh	r3, [r3]	@ _11, absolutes_array
	mov	r1, r3	@ _12, _11
@ simd_compander.c:79:         steps_array[i] = ((absolutes_array[i] >> (chords_array[i] + (chords_array[i] == 0))) & 0x0F);
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2	@ _13, i
	sub	r2, fp, #4	@ tmp240,,
	sub	r2, r2, #508	@ tmp242, tmp240,
	lsl	r3, r3, #1	@ tmp243, _13,
	add	r3, r2, r3	@ tmp244, tmp242, tmp243
	ldrh	r3, [r3]	@ _14, chords_array
	mov	r0, r3	@ _15, _14
@ simd_compander.c:79:         steps_array[i] = ((absolutes_array[i] >> (chords_array[i] + (chords_array[i] == 0))) & 0x0F);
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2	@ _16, i
	sub	r2, fp, #4	@ tmp245,,
	sub	r2, r2, #508	@ tmp247, tmp245,
	lsl	r3, r3, #1	@ tmp248, _16,
	add	r3, r2, r3	@ tmp249, tmp247, tmp248
	ldrh	r3, [r3]	@ _17, chords_array
@ simd_compander.c:79:         steps_array[i] = ((absolutes_array[i] >> (chords_array[i] + (chords_array[i] == 0))) & 0x0F);
	cmp	r3, #0	@ _17,
	moveq	r3, #1	@ tmp251,
	movne	r3, #0	@ tmp251,
	uxtb	r3, r3	@ _18, tmp250
@ simd_compander.c:79:         steps_array[i] = ((absolutes_array[i] >> (chords_array[i] + (chords_array[i] == 0))) & 0x0F);
	add	r3, r0, r3	@ _20, _15, _19
@ simd_compander.c:79:         steps_array[i] = ((absolutes_array[i] >> (chords_array[i] + (chords_array[i] == 0))) & 0x0F);
	asr	r3, r1, r3	@ _21, _12, _20
@ simd_compander.c:79:         steps_array[i] = ((absolutes_array[i] >> (chords_array[i] + (chords_array[i] == 0))) & 0x0F);
	uxth	r2, r3	@ _22, _21
@ simd_compander.c:79:         steps_array[i] = ((absolutes_array[i] >> (chords_array[i] + (chords_array[i] == 0))) & 0x0F);
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2	@ _23, i
@ simd_compander.c:79:         steps_array[i] = ((absolutes_array[i] >> (chords_array[i] + (chords_array[i] == 0))) & 0x0F);
	and	r2, r2, #15	@ tmp252, _22,
	uxth	r2, r2	@ _24, tmp252
@ simd_compander.c:79:         steps_array[i] = ((absolutes_array[i] >> (chords_array[i] + (chords_array[i] == 0))) & 0x0F);
	sub	r1, fp, #4	@ tmp253,,
	sub	r1, r1, #524	@ tmp255, tmp253,
	lsl	r3, r3, #1	@ tmp256, _23,
	add	r3, r1, r3	@ tmp257, tmp255, tmp256
	strh	r2, [r3]	@ movhi	@ _24, steps_array
@ simd_compander.c:78:     for (uint8_t i = 0; i < input_batch.count; i++) {
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2	@ i.0_25, i
	add	r3, r3, #1	@ tmp258, i.0_25,
	strb	r3, [fp, #-5]	@ tmp259, i
.L15:
@ simd_compander.c:78:     for (uint8_t i = 0; i < input_batch.count; i++) {
	ldrb	r3, [fp, #24]	@ zero_extendqisi2	@ _26, input_batch.count
@ simd_compander.c:78:     for (uint8_t i = 0; i < input_batch.count; i++) {
	ldrb	r2, [fp, #-5]	@ zero_extendqisi2	@ tmp260, i
	cmp	r2, r3	@ tmp260, _26
	bcc	.L16		@,
	sub	r3, fp, #528	@ tmp261,,
	str	r3, [fp, #-464]	@ tmp261, __a
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:10408:   return (uint16x8_t)__builtin_neon_vld1v8hi ((const __builtin_neon_hi *) __a);
	ldr	r3, [fp, #-464]	@ tmp262, __a
	vld1.16	{d16-d17}, [r3]	@ _132, MEM[(const short int[8] *)__a_131]
	vstr	d16, [fp, #-460]	@, __a
	vstr	d17, [fp, #-452]	@, __a
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:7568:   return (uint8x8_t)__builtin_neon_vmovnv8hi ((int16x8_t) __a);
	vldr	d16, [fp, #-460]	@, __a
	vldr	d17, [fp, #-452]	@, __a
	vmovn.i16	d16, q8	@ _129, _128
@ simd_compander.c:81:     uint8x8_t steps_8bit = vmovn_u16(vld1q_u16(steps_array));
	vstr	d16, [fp, #-116]	@, steps_8bit
	vldr	d16, [fp, #-108]	@, chords_8bit
	vstr	d16, [fp, #-436]	@, __a
	vldr	d16, [fp, #-116]	@, steps_8bit
	vstr	d16, [fp, #-444]	@, __b
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:13871:   return __a | __b;
	vldr	d17, [fp, #-436]	@, __a
	vldr	d16, [fp, #-444]	@, __b
	vorr	d16, d17, d16	@ _126, tmp265, tmp266
@ simd_compander.c:84:     uint8x8_t codewords = vorr_u8(signs_8bit, vorr_u8(chords_8bit, steps_8bit));
	vmov	d17, d16  @ v8qi	@ _28, D.16448
	vldr	d16, [fp, #-52]	@, signs_8bit
	vstr	d16, [fp, #-420]	@, __a
	vstr	d17, [fp, #-428]	@, __b
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:13871:   return __a | __b;
	vldr	d17, [fp, #-420]	@, __a
	vldr	d16, [fp, #-428]	@, __b
	vorr	d16, d17, d16	@ _123, tmp268, tmp269
@ simd_compander.c:84:     uint8x8_t codewords = vorr_u8(signs_8bit, vorr_u8(chords_8bit, steps_8bit));
	vstr	d16, [fp, #-124]	@, codewords
	mov	r3, #85	@ tmp270,
	strb	r3, [fp, #-405]	@ tmp271, __a
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:6652:   return (uint8x8_t)__builtin_neon_vdup_nv8qi ((__builtin_neon_qi) __a);
	sub	r3, fp, #404	@ tmp272,,
	sub	r3, r3, #1	@ tmp272, tmp272,
	ldrsb	r3, [r3]	@ __a.2_118, __a
	vdup.8	d16, r3	@ _119, __a.2_118
@ simd_compander.c:87:     codewords = veor_u8(codewords, vdup_n_u8(0x55));
	vmov	d17, d16  @ v8qi	@ _29, D.16438
	vldr	d16, [fp, #-124]	@, codewords
	vstr	d16, [fp, #-396]	@, __a
	vstr	d17, [fp, #-404]	@, __b
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:13983:   return __a ^ __b;
	vldr	d17, [fp, #-396]	@, __a
	vldr	d16, [fp, #-404]	@, __b
	veor	d16, d17, d16	@ _116, tmp274, tmp275
@ simd_compander.c:87:     codewords = veor_u8(codewords, vdup_n_u8(0x55));
	vstr	d16, [fp, #-124]	@, codewords
	sub	r3, fp, #540	@ tmp276,,
	str	r3, [fp, #-380]	@ tmp276, __a
	vldr	d16, [fp, #-124]	@, codewords
	vstr	d16, [fp, #-388]	@, __b
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:10883:   __builtin_neon_vst1v8qi ((__builtin_neon_qi *) __a, (int8x8_t) __b);
	vldr	d16, [fp, #-388]	@, __b
	ldr	r3, [fp, #-380]	@ tmp278, __a
	vst1.8	{d16}, [r3]	@ _113, MEM[(signed char[8] *)__a_111]
@ simd_compander.c:92:     output.count = input_batch.count;
	ldrb	r3, [fp, #24]	@ zero_extendqisi2	@ _30, input_batch.count
@ simd_compander.c:92:     output.count = input_batch.count;
	strb	r3, [fp, #-532]	@ tmp279, output.count
@ simd_compander.c:95:     return output;
	ldr	r3, [fp, #-544]	@ tmp280, .result_ptr
	mov	r2, r3	@ tmp281, tmp280
	sub	r3, fp, #540	@ tmp282,,
	ldmia	r3!, {r0, r1}	@ tmp282,,
	str	r0, [r2]	@ unaligned	@, <retval>
	str	r1, [r2, #4]	@ unaligned	@, <retval>
	ldrb	r3, [r3]	@ tmp283, output
	strb	r3, [r2, #8]	@ tmp284, <retval>
@ simd_compander.c:97: }
	ldr	r0, [fp, #-544]	@, .result_ptr
	sub	sp, fp, #4	@,,
	@ sp needed	@
	pop	{fp, lr}	@
	add	sp, sp, #16	@,,
	bx	lr	@
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
	push	{fp, lr}	@
	add	fp, sp, #4	@,,
	sub	sp, sp, #312	@,,
	str	r0, [fp, #-304]	@ .result_ptr, .result_ptr
	sub	r0, fp, #316	@ tmp177,,
	stm	r0, {r1, r2, r3}	@ tmp177,,,
@ simd_compander.c:102:     uint8_t codeword_array[8] = {0};
	sub	r3, fp, #240	@ tmp178,,
	mov	r2, #0	@ tmp179,
	str	r2, [r3]	@ tmp179, codeword_array
	str	r2, [r3, #4]	@ tmp179, codeword_array
@ simd_compander.c:103:     memcpy(codeword_array, input_batch.data, input_batch.count*sizeof(uint8_t));
	ldrb	r3, [fp, #-308]	@ zero_extendqisi2	@ _1, input_batch.count
@ simd_compander.c:103:     memcpy(codeword_array, input_batch.data, input_batch.count*sizeof(uint8_t));
	mov	r2, r3	@ _2, _1
	sub	r1, fp, #316	@ tmp180,,
	sub	r3, fp, #240	@ tmp181,,
	mov	r0, r3	@, tmp181
	bl	memcpy		@
	sub	r3, fp, #240	@ tmp182,,
	str	r3, [fp, #-204]	@ tmp182, __a
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:10305:   return (uint8x8_t)__builtin_neon_vld1v8qi ((const __builtin_neon_qi *) __a);
	ldr	r3, [fp, #-204]	@ tmp183, __a
	vld1.8	{d16}, [r3]	@ _105, MEM[(const signed char[8] *)__a_104]
@ simd_compander.c:106:     uint8x8_t codewords = veor_u8(vld1_u8(codeword_array), vdup_n_u8(0x55));
	vmov	d17, d16  @ v8qi	@ _3, D.16503
	mov	r3, #85	@ tmp184,
	strb	r3, [fp, #-197]	@ tmp185, __a
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:6652:   return (uint8x8_t)__builtin_neon_vdup_nv8qi ((__builtin_neon_qi) __a);
	ldrsb	r3, [fp, #-197]	@ __a.2_101, __a
	vdup.8	d16, r3	@ _102, __a.2_101
	vstr	d17, [fp, #-188]	@, __a
	vstr	d16, [fp, #-196]	@, __b
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:13983:   return __a ^ __b;
	vldr	d17, [fp, #-188]	@, __a
	vldr	d16, [fp, #-196]	@, __b
	veor	d16, d17, d16	@ _99, tmp186, tmp187
@ simd_compander.c:106:     uint8x8_t codewords = veor_u8(vld1_u8(codeword_array), vdup_n_u8(0x55));
	vstr	d16, [fp, #-20]	@, codewords
	vldr	d16, [fp, #-20]	@, codewords
	vstr	d16, [fp, #-180]	@, __a
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:4331:   return (uint8x8_t)__builtin_neon_vshru_nv8qi ((int8x8_t) __a, __b);
	vldr	d16, [fp, #-180]	@, __a
	vshr.u8	d16, d16, #7	@ _95, _94,
@ simd_compander.c:109:     uint8x8_t signs = vshr_n_u8(codewords, 7); // unsigned right-shift of all bits, will be zero-padded so does not need masking
	vstr	d16, [fp, #-28]	@, signs
	vldr	d16, [fp, #-20]	@, codewords
	vstr	d16, [fp, #-172]	@, __a
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:4331:   return (uint8x8_t)__builtin_neon_vshru_nv8qi ((int8x8_t) __a, __b);
	vldr	d16, [fp, #-172]	@, __a
	vshr.u8	d16, d16, #4	@ _91, _90,
@ simd_compander.c:110:     uint8x8_t chords = vand_u8(vshr_n_u8(codewords, 4), vdup_n_u8(0x07));
	vmov	d17, d16  @ v8qi	@ _5, D.16485
	mov	r3, #7	@ tmp190,
	strb	r3, [fp, #-157]	@ tmp191, __a
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:6652:   return (uint8x8_t)__builtin_neon_vdup_nv8qi ((__builtin_neon_qi) __a);
	ldrsb	r3, [fp, #-157]	@ __a.2_86, __a
	vdup.8	d16, r3	@ _87, __a.2_86
	vstr	d17, [fp, #-148]	@, __a
	vstr	d16, [fp, #-156]	@, __b
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:13759:   return __a & __b;
	vldr	d17, [fp, #-148]	@, __a
	vldr	d16, [fp, #-156]	@, __b
	vand	d16, d17, d16	@ _84, tmp192, tmp193
@ simd_compander.c:110:     uint8x8_t chords = vand_u8(vshr_n_u8(codewords, 4), vdup_n_u8(0x07));
	vstr	d16, [fp, #-36]	@, chords
	mov	r3, #15	@ tmp194,
	strb	r3, [fp, #-133]	@ tmp195, __a
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:6652:   return (uint8x8_t)__builtin_neon_vdup_nv8qi ((__builtin_neon_qi) __a);
	ldrsb	r3, [fp, #-133]	@ __a.2_79, __a
	vdup.8	d16, r3	@ _80, __a.2_79
@ simd_compander.c:111:     uint8x8_t steps = vand_u8(codewords, vdup_n_u8(0x0F));
	vmov	d17, d16  @ v8qi	@ _7, D.16471
	vldr	d16, [fp, #-20]	@, codewords
	vstr	d16, [fp, #-124]	@, __a
	vstr	d17, [fp, #-132]	@, __b
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:13759:   return __a & __b;
	vldr	d17, [fp, #-124]	@, __a
	vldr	d16, [fp, #-132]	@, __b
	vand	d16, d17, d16	@ _77, tmp197, tmp198
@ simd_compander.c:111:     uint8x8_t steps = vand_u8(codewords, vdup_n_u8(0x0F));
	vstr	d16, [fp, #-44]	@, steps
@ simd_compander.c:114:     uint8_t signs_array[8] = {0};
	sub	r3, fp, #248	@ tmp199,,
	mov	r2, #0	@ tmp200,
	str	r2, [r3]	@ tmp200, signs_array
	str	r2, [r3, #4]	@ tmp200, signs_array
	sub	r3, fp, #248	@ tmp201,,
	str	r3, [fp, #-104]	@ tmp201, __a
	vldr	d16, [fp, #-28]	@, signs
	vstr	d16, [fp, #-116]	@, __b
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:10883:   __builtin_neon_vst1v8qi ((__builtin_neon_qi *) __a, (int8x8_t) __b);
	vldr	d16, [fp, #-116]	@, __b
	ldr	r3, [fp, #-104]	@ tmp203, __a
	vst1.8	{d16}, [r3]	@ _74, MEM[(signed char[8] *)__a_72]
@ simd_compander.c:116:     uint8_t chords_array[8] = {0};
	sub	r3, fp, #256	@ tmp204,,
	mov	r2, #0	@ tmp205,
	str	r2, [r3]	@ tmp205, chords_array
	str	r2, [r3, #4]	@ tmp205, chords_array
	sub	r3, fp, #256	@ tmp206,,
	str	r3, [fp, #-88]	@ tmp206, __a
	vldr	d16, [fp, #-36]	@, chords
	vstr	d16, [fp, #-100]	@, __b
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:10883:   __builtin_neon_vst1v8qi ((__builtin_neon_qi *) __a, (int8x8_t) __b);
	vldr	d16, [fp, #-100]	@, __b
	ldr	r3, [fp, #-88]	@ tmp208, __a
	vst1.8	{d16}, [r3]	@ _71, MEM[(signed char[8] *)__a_69]
@ simd_compander.c:118:     uint8_t steps_array[8] = {0};
	sub	r3, fp, #264	@ tmp209,,
	mov	r2, #0	@ tmp210,
	str	r2, [r3]	@ tmp210, steps_array
	str	r2, [r3, #4]	@ tmp210, steps_array
	sub	r3, fp, #264	@ tmp211,,
	str	r3, [fp, #-72]	@ tmp211, __a
	vldr	d16, [fp, #-44]	@, steps
	vstr	d16, [fp, #-84]	@, __b
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:10883:   __builtin_neon_vst1v8qi ((__builtin_neon_qi *) __a, (int8x8_t) __b);
	vldr	d16, [fp, #-84]	@, __b
	ldr	r3, [fp, #-72]	@ tmp213, __a
	vst1.8	{d16}, [r3]	@ _68, MEM[(signed char[8] *)__a_66]
@ simd_compander.c:120:     int16_t output_array[8] = {0};
	sub	r3, fp, #280	@ tmp214,,
	mov	r2, #0	@ tmp215,
	str	r2, [r3]	@ tmp215, output_array
	str	r2, [r3, #4]	@ tmp215, output_array
	str	r2, [r3, #8]	@ tmp215, output_array
	str	r2, [r3, #12]	@ tmp215, output_array
@ simd_compander.c:121:     for (uint8_t i = 0; i < input_batch.count; i++) {
	mov	r3, #0	@ tmp216,
	strb	r3, [fp, #-5]	@ tmp217, i
@ simd_compander.c:121:     for (uint8_t i = 0; i < input_batch.count; i++) {
	b	.L34		@
.L39:
@ simd_compander.c:122:         uint16_t decompressed_absolute = (chords_array[i] == 0) ? ((steps_array[i] << 1) | 1) : (0x10 | steps_array[i]) << (chords_array[i] - 1);
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2	@ _8, i
	sub	r2, fp, #4	@ tmp249,,
	add	r3, r2, r3	@ tmp218, tmp249, _8
	ldrb	r3, [r3, #-252]	@ zero_extendqisi2	@ _9, chords_array
@ simd_compander.c:122:         uint16_t decompressed_absolute = (chords_array[i] == 0) ? ((steps_array[i] << 1) | 1) : (0x10 | steps_array[i]) << (chords_array[i] - 1);
	cmp	r3, #0	@ _9,
	bne	.L35		@,
@ simd_compander.c:122:         uint16_t decompressed_absolute = (chords_array[i] == 0) ? ((steps_array[i] << 1) | 1) : (0x10 | steps_array[i]) << (chords_array[i] - 1);
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2	@ _10, i
	sub	r2, fp, #4	@ tmp250,,
	add	r3, r2, r3	@ tmp219, tmp250, _10
	ldrb	r3, [r3, #-260]	@ zero_extendqisi2	@ _11, steps_array
@ simd_compander.c:122:         uint16_t decompressed_absolute = (chords_array[i] == 0) ? ((steps_array[i] << 1) | 1) : (0x10 | steps_array[i]) << (chords_array[i] - 1);
	lsl	r3, r3, #1	@ _13, _12,
@ simd_compander.c:122:         uint16_t decompressed_absolute = (chords_array[i] == 0) ? ((steps_array[i] << 1) | 1) : (0x10 | steps_array[i]) << (chords_array[i] - 1);
	sxth	r3, r3	@ _14, _13
	orr	r3, r3, #1	@ tmp220, _14,
	sxth	r3, r3	@ _15, tmp220
@ simd_compander.c:122:         uint16_t decompressed_absolute = (chords_array[i] == 0) ? ((steps_array[i] << 1) | 1) : (0x10 | steps_array[i]) << (chords_array[i] - 1);
	uxth	r3, r3	@ iftmp.3_33, _15
	b	.L36		@
.L35:
@ simd_compander.c:122:         uint16_t decompressed_absolute = (chords_array[i] == 0) ? ((steps_array[i] << 1) | 1) : (0x10 | steps_array[i]) << (chords_array[i] - 1);
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2	@ _16, i
	sub	r2, fp, #4	@ tmp251,,
	add	r3, r2, r3	@ tmp221, tmp251, _16
	ldrb	r3, [r3, #-260]	@ zero_extendqisi2	@ _17, steps_array
@ simd_compander.c:122:         uint16_t decompressed_absolute = (chords_array[i] == 0) ? ((steps_array[i] << 1) | 1) : (0x10 | steps_array[i]) << (chords_array[i] - 1);
	orr	r3, r3, #16	@ tmp222, _17,
	uxtb	r3, r3	@ _18, tmp222
	mov	r2, r3	@ _19, _18
@ simd_compander.c:122:         uint16_t decompressed_absolute = (chords_array[i] == 0) ? ((steps_array[i] << 1) | 1) : (0x10 | steps_array[i]) << (chords_array[i] - 1);
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2	@ _20, i
	sub	r1, fp, #4	@ tmp252,,
	add	r3, r1, r3	@ tmp223, tmp252, _20
	ldrb	r3, [r3, #-252]	@ zero_extendqisi2	@ _21, chords_array
@ simd_compander.c:122:         uint16_t decompressed_absolute = (chords_array[i] == 0) ? ((steps_array[i] << 1) | 1) : (0x10 | steps_array[i]) << (chords_array[i] - 1);
	sub	r3, r3, #1	@ _23, _22,
@ simd_compander.c:122:         uint16_t decompressed_absolute = (chords_array[i] == 0) ? ((steps_array[i] << 1) | 1) : (0x10 | steps_array[i]) << (chords_array[i] - 1);
	lsl	r3, r2, r3	@ _24, _19, _23
@ simd_compander.c:122:         uint16_t decompressed_absolute = (chords_array[i] == 0) ? ((steps_array[i] << 1) | 1) : (0x10 | steps_array[i]) << (chords_array[i] - 1);
	uxth	r3, r3	@ iftmp.3_33, _24
.L36:
@ simd_compander.c:122:         uint16_t decompressed_absolute = (chords_array[i] == 0) ? ((steps_array[i] << 1) | 1) : (0x10 | steps_array[i]) << (chords_array[i] - 1);
	strh	r3, [fp, #-46]	@ movhi	@ iftmp.3_33, decompressed_absolute
@ simd_compander.c:123:         decompressed_absolute <<= 3;
	ldrh	r3, [fp, #-46]	@ movhi	@ tmp224, decompressed_absolute
	lsl	r3, r3, #3	@ tmp225, tmp224,
	strh	r3, [fp, #-46]	@ movhi	@ tmp225, decompressed_absolute
@ simd_compander.c:124:         int16_t decompressed_sample = signs_array[i] ? -(int16_t)decompressed_absolute : (int16_t)decompressed_absolute;
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2	@ _25, i
	sub	r2, fp, #4	@ tmp253,,
	add	r3, r2, r3	@ tmp226, tmp253, _25
	ldrb	r3, [r3, #-244]	@ zero_extendqisi2	@ _26, signs_array
@ simd_compander.c:124:         int16_t decompressed_sample = signs_array[i] ? -(int16_t)decompressed_absolute : (int16_t)decompressed_absolute;
	cmp	r3, #0	@ _26,
	beq	.L37		@,
@ simd_compander.c:124:         int16_t decompressed_sample = signs_array[i] ? -(int16_t)decompressed_absolute : (int16_t)decompressed_absolute;
	ldrh	r3, [fp, #-46]	@ movhi	@ tmp227, decompressed_absolute
	rsb	r3, r3, #0	@ tmp228, tmp227
	uxth	r3, r3	@ _27, tmp228
	sxth	r3, r3	@ iftmp.4_34, _27
	b	.L38		@
.L37:
@ simd_compander.c:124:         int16_t decompressed_sample = signs_array[i] ? -(int16_t)decompressed_absolute : (int16_t)decompressed_absolute;
	ldrsh	r3, [fp, #-46]	@ iftmp.4_34, decompressed_absolute
.L38:
@ simd_compander.c:124:         int16_t decompressed_sample = signs_array[i] ? -(int16_t)decompressed_absolute : (int16_t)decompressed_absolute;
	strh	r3, [fp, #-48]	@ movhi	@ iftmp.4_34, decompressed_sample
@ simd_compander.c:125:         output_array[i] = decompressed_sample;
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2	@ _28, i
@ simd_compander.c:125:         output_array[i] = decompressed_sample;
	sub	r2, fp, #4	@ tmp229,,
	sub	r2, r2, #276	@ tmp231, tmp229,
	lsl	r3, r3, #1	@ tmp232, _28,
	add	r3, r2, r3	@ tmp233, tmp231, tmp232
	ldrh	r2, [fp, #-48]	@ movhi	@ tmp234, decompressed_sample
	strh	r2, [r3]	@ movhi	@ tmp234, output_array
@ simd_compander.c:121:     for (uint8_t i = 0; i < input_batch.count; i++) {
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2	@ i.5_29, i
	add	r3, r3, #1	@ tmp235, i.5_29,
	strb	r3, [fp, #-5]	@ tmp236, i
.L34:
@ simd_compander.c:121:     for (uint8_t i = 0; i < input_batch.count; i++) {
	ldrb	r3, [fp, #-308]	@ zero_extendqisi2	@ _30, input_batch.count
@ simd_compander.c:121:     for (uint8_t i = 0; i < input_batch.count; i++) {
	ldrb	r2, [fp, #-5]	@ zero_extendqisi2	@ tmp237, i
	cmp	r2, r3	@ tmp237, _30
	bcc	.L39		@,
	sub	r3, fp, #280	@ tmp238,,
	str	r3, [fp, #-232]	@ tmp238, __a
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:10364:   return (int16x8_t)__builtin_neon_vld1v8hi ((const __builtin_neon_hi *) __a);
	ldr	r3, [fp, #-232]	@ tmp239, __a
	vld1.16	{d16-d17}, [r3]	@ _110, MEM[(const short int[8] *)__a_109]
@ simd_compander.c:127:     int16x8_t output_samples = vld1q_s16(output_array);
	vstr	d16, [fp, #-68]	@, output_samples
	vstr	d17, [fp, #-60]	@, output_samples
	sub	r3, fp, #300	@ tmp240,,
	str	r3, [fp, #-208]	@ tmp240, __a
	vldr	d16, [fp, #-68]	@, output_samples
	vldr	d17, [fp, #-60]	@, output_samples
	vstr	d16, [fp, #-228]	@, __b
	vstr	d17, [fp, #-220]	@, __b
@ /usr/lib/gcc/armv7hl-redhat-linux-gnueabi/8/include/arm_neon.h:10942:   __builtin_neon_vst1v8hi ((__builtin_neon_hi *) __a, __b);
	ldr	r3, [fp, #-208]	@ tmp242, __a
	vldr	d16, [fp, #-228]	@, __b
	vldr	d17, [fp, #-220]	@, __b
	vst1.16	{d16-d17}, [r3]	@ tmp243, MEM[(short int[8] *)__a_107]
@ simd_compander.c:132:     output.count = input_batch.count;
	ldrb	r3, [fp, #-308]	@ zero_extendqisi2	@ _31, input_batch.count
@ simd_compander.c:132:     output.count = input_batch.count;
	strb	r3, [fp, #-284]	@ tmp244, output.count
@ simd_compander.c:135:     return output;
	ldr	r3, [fp, #-304]	@ tmp245, .result_ptr
	mov	lr, r3	@ tmp246, tmp245
	sub	ip, fp, #300	@ tmp247,,
	ldmia	ip!, {r0, r1, r2, r3}	@ tmp247,,,,
	str	r0, [lr]	@ unaligned	@, <retval>
	str	r1, [lr, #4]	@ unaligned	@, <retval>
	str	r2, [lr, #8]	@ unaligned	@, <retval>
	str	r3, [lr, #12]	@ unaligned	@, <retval>
	ldrh	r3, [ip]	@ unaligned	@ tmp248, output
	strh	r3, [lr, #16]	@ unaligned	@ tmp248, <retval>
@ simd_compander.c:136: }
	ldr	r0, [fp, #-304]	@, .result_ptr
	sub	sp, fp, #4	@,,
	@ sp needed	@
	pop	{fp, pc}	@
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
	push	{fp, lr}	@
	add	fp, sp, #4	@,,
	sub	sp, sp, #120	@,,
	str	r0, [fp, #-112]	@ argc, argc
	str	r1, [fp, #-116]	@ argv, argv
@ simd_compander.c:145:     if (argc != 3) {
	ldr	r3, [fp, #-112]	@ tmp122, argc
	cmp	r3, #3	@ tmp122,
	beq	.L43		@,
@ simd_compander.c:146:         printf("Incorrect arguments, please use: %s input_file.wav output_file.wav\n", argv[0]);
	ldr	r3, [fp, #-116]	@ tmp123, argv
	ldr	r3, [r3]	@ _1, *argv_16(D)
	mov	r1, r3	@, _1
	movw	r0, #:lower16:.LC0	@,
	movt	r0, #:upper16:.LC0	@,
	bl	printf		@
@ simd_compander.c:147:         return(1);
	mov	r3, #1	@ _11,
	b	.L49		@
.L43:
@ simd_compander.c:151:     FILE *input_file = fopen(argv[1], "rb");
	ldr	r3, [fp, #-116]	@ tmp124, argv
	add	r3, r3, #4	@ _2, tmp124,
@ simd_compander.c:151:     FILE *input_file = fopen(argv[1], "rb");
	ldr	r3, [r3]	@ _3, *_2
	movw	r1, #:lower16:.LC1	@,
	movt	r1, #:upper16:.LC1	@,
	mov	r0, r3	@, _3
	bl	fopen		@
	str	r0, [fp, #-8]	@, input_file
@ simd_compander.c:152:     if (!input_file) {
	ldr	r3, [fp, #-8]	@ tmp125, input_file
	cmp	r3, #0	@ tmp125,
	bne	.L45		@,
@ simd_compander.c:153:         perror("input_file failed to open");
	movw	r0, #:lower16:.LC2	@,
	movt	r0, #:upper16:.LC2	@,
	bl	perror		@
@ simd_compander.c:154:         return(1);
	mov	r3, #1	@ _11,
	b	.L49		@
.L45:
@ simd_compander.c:156:     FILE *output_file = fopen(argv[2], "wb");
	ldr	r3, [fp, #-116]	@ tmp126, argv
	add	r3, r3, #8	@ _4, tmp126,
@ simd_compander.c:156:     FILE *output_file = fopen(argv[2], "wb");
	ldr	r3, [r3]	@ _5, *_4
	movw	r1, #:lower16:.LC3	@,
	movt	r1, #:upper16:.LC3	@,
	mov	r0, r3	@, _5
	bl	fopen		@
	str	r0, [fp, #-12]	@, output_file
@ simd_compander.c:157:     if (!output_file){
	ldr	r3, [fp, #-12]	@ tmp127, output_file
	cmp	r3, #0	@ tmp127,
	bne	.L46		@,
@ simd_compander.c:158:         perror("output_file failed to open");
	movw	r0, #:lower16:.LC4	@,
	movt	r0, #:upper16:.LC4	@,
	bl	perror		@
@ simd_compander.c:159:         return(1);
	mov	r3, #1	@ _11,
	b	.L49		@
.L46:
@ simd_compander.c:164:     fread(header, 1, 44, input_file);
	sub	r0, fp, #56	@ tmp128,,
	ldr	r3, [fp, #-8]	@, input_file
	mov	r2, #44	@,
	mov	r1, #1	@,
	bl	fread		@
@ simd_compander.c:165:     fwrite(header, 1, 44, output_file);
	sub	r0, fp, #56	@ tmp129,,
	ldr	r3, [fp, #-12]	@, output_file
	mov	r2, #44	@,
	mov	r1, #1	@,
	bl	fwrite		@
@ simd_compander.c:169:     while((input_batch.count = (uint8_t)fread(input_batch.data, sizeof(int16_t), 8, input_file)) > 0) {
	b	.L47		@
.L48:
@ simd_compander.c:170:         Batch8Bit compressed_batch = compress_batch(input_batch);
	sub	ip, fp, #88	@ tmp130,,
	mov	r3, sp	@ tmp131,
	sub	r2, fp, #64	@ tmp132,,
	ldm	r2, {r0, r1}	@ tmp132,,
	str	r0, [r3]	@,
	add	r3, r3, #4	@ tmp131, tmp131,
	strh	r1, [r3]	@ movhi	@,
	sub	r3, fp, #76	@ tmp133,,
	ldm	r3, {r1, r2, r3}	@ tmp133,,,
	mov	r0, ip	@, tmp130
	bl	compress_batch		@
@ simd_compander.c:171:         Batch16Bit decompressed_batch = expand_batch(compressed_batch);
	sub	r0, fp, #108	@ tmp134,,
	sub	r3, fp, #88	@ tmp135,,
	ldm	r3, {r1, r2, r3}	@ tmp135,,,
	bl	expand_batch		@
@ simd_compander.c:172:         fwrite(decompressed_batch.data, sizeof(int16_t), decompressed_batch.count, output_file);
	ldrb	r3, [fp, #-92]	@ zero_extendqisi2	@ _6, decompressed_batch.count
@ simd_compander.c:172:         fwrite(decompressed_batch.data, sizeof(int16_t), decompressed_batch.count, output_file);
	mov	r2, r3	@ _7, _6
	sub	r0, fp, #108	@ tmp136,,
	ldr	r3, [fp, #-12]	@, output_file
	mov	r1, #2	@,
	bl	fwrite		@
.L47:
@ simd_compander.c:169:     while((input_batch.count = (uint8_t)fread(input_batch.data, sizeof(int16_t), 8, input_file)) > 0) {
	sub	r0, fp, #76	@ tmp137,,
	ldr	r3, [fp, #-8]	@, input_file
	mov	r2, #8	@,
	mov	r1, #2	@,
	bl	fread		@
	mov	r3, r0	@ _8,
@ simd_compander.c:169:     while((input_batch.count = (uint8_t)fread(input_batch.data, sizeof(int16_t), 8, input_file)) > 0) {
	uxtb	r3, r3	@ _9, _8
@ simd_compander.c:169:     while((input_batch.count = (uint8_t)fread(input_batch.data, sizeof(int16_t), 8, input_file)) > 0) {
	strb	r3, [fp, #-60]	@ tmp138, input_batch.count
@ simd_compander.c:169:     while((input_batch.count = (uint8_t)fread(input_batch.data, sizeof(int16_t), 8, input_file)) > 0) {
	ldrb	r3, [fp, #-60]	@ zero_extendqisi2	@ _10, input_batch.count
@ simd_compander.c:169:     while((input_batch.count = (uint8_t)fread(input_batch.data, sizeof(int16_t), 8, input_file)) > 0) {
	cmp	r3, #0	@ _10,
	bne	.L48		@,
@ simd_compander.c:176:     fclose(input_file);
	ldr	r0, [fp, #-8]	@, input_file
	bl	fclose		@
@ simd_compander.c:177:     fclose(output_file);
	ldr	r0, [fp, #-12]	@, output_file
	bl	fclose		@
@ simd_compander.c:180:     return 0;
	mov	r3, #0	@ _11,
.L49:
@ simd_compander.c:181: }
	mov	r0, r3	@, <retval>
	sub	sp, fp, #4	@,,
	@ sp needed	@
	pop	{fp, pc}	@
	.size	main, .-main
	.ident	"GCC: (GNU) 8.2.1 20180801 (Red Hat 8.2.1-2)"
	.section	.note.GNU-stack,"",%progbits

	.file	"dgramReceive.c"
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.text
.Ltext0:
	.section	.rodata
.LC0:
	.string	"Opening datagram socket error"
	.align 8
.LC1:
	.string	"Opening datagram socket....OK."
.LC2:
	.string	"Setting SO_REUSEADDR error"
.LC3:
	.string	"Setting SO_REUSEADDR...OK."
.LC4:
	.string	"Binding datagram socket error"
.LC5:
	.string	"Binding datagram socket...OK."
.LC6:
	.string	"226.1.1.1"
.LC7:
	.string	"192.168.40.185"
	.align 8
.LC8:
	.string	"Adding multicast mcastGroup error"
	.align 8
.LC9:
	.string	"Adding multicast mcastGroup...OK."
	.align 8
.LC10:
	.string	"Reading datagram message error"
	.align 8
.LC11:
	.string	"Reading datagram message...OK.\nThe message from multicast server %s:%u is: \"%s\"\n\n"
	.text
.globl main
	.type	main, @function
main:
.LFB0:
	.file 1 "dgramReceive.c"
	.loc 1 18 0
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r12
	pushq	%rbx
	subq	$144, %rsp
	movl	%edi, -148(%rbp)
	movq	%rsi, -160(%rbp)
	.loc 1 24 0
	movl	$0, %edx
	movl	$2, %esi
	movl	$2, %edi
	.cfi_offset 3, -32
	.cfi_offset 12, -24
	call	socket
	movl	%eax, -24(%rbp)
	.loc 1 25 0
	cmpl	$0, -24(%rbp)
	jns	.L2
	movl	$.LC0, %edi
	call	perror
	movl	$1, %edi
	call	exit
.L2:
	.loc 1 26 0
	movl	$.LC1, %edi
	call	puts
	.loc 1 30 0
	movl	$1, -68(%rbp)
	.loc 1 31 0
	leaq	-68(%rbp), %rdx
	movl	-24(%rbp), %eax
	movl	$4, %r8d
	movq	%rdx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movl	%eax, %edi
	call	setsockopt
	testl	%eax, %eax
	jns	.L3
.LBB2:
	.loc 1 32 0
	movl	$.LC2, %edi
	call	perror
	movl	-24(%rbp), %eax
	movl	%eax, %edi
	movl	$0, %eax
	call	close
	movl	$1, %edi
	call	exit
.L3:
.LBE2:
	.loc 1 33 0
	movl	$.LC3, %edi
	call	puts
	.loc 1 37 0
	leaq	-48(%rbp), %rax
	movl	$16, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	memset
	.loc 1 38 0
	movw	$2, -48(%rbp)
	.loc 1 39 0
	movl	$4321, %edi
	call	htons
	movw	%ax, -46(%rbp)
	.loc 1 40 0
	movl	$0, -44(%rbp)
	.loc 1 42 0
	leaq	-48(%rbp), %rdx
	movl	$0, %eax
	movq	%rdx, %rax
	movl	-24(%rbp), %ecx
	movl	$16, %edx
	movq	%rax, %rsi
	movl	%ecx, %edi
	call	bind
	testl	%eax, %eax
	je	.L4
.LBB3:
	.loc 1 43 0
	movl	$.LC4, %edi
	call	perror
	movl	-24(%rbp), %eax
	movl	%eax, %edi
	movl	$0, %eax
	call	close
	movl	$1, %edi
	call	exit
.L4:
.LBE3:
	.loc 1 44 0
	movl	$.LC5, %edi
	call	puts
	.loc 1 50 0
	movl	$.LC6, %edi
	call	inet_addr
	movl	%eax, -64(%rbp)
	.loc 1 51 0
	movl	$.LC7, %edi
	call	inet_addr
	movl	%eax, -60(%rbp)
	.loc 1 52 0
	cmpl	$1, -148(%rbp)
	jle	.L5
	movq	-160(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	inet_addr
	movl	%eax, -60(%rbp)
.L5:
	.loc 1 54 0
	leaq	-64(%rbp), %rdx
	movl	-24(%rbp), %eax
	movl	$8, %r8d
	movq	%rdx, %rcx
	movl	$35, %edx
	movl	$0, %esi
	movl	%eax, %edi
	call	setsockopt
	testl	%eax, %eax
	jns	.L6
.LBB4:
	.loc 1 55 0
	movl	$.LC8, %edi
	call	perror
	movl	-24(%rbp), %eax
	movl	%eax, %edi
	movl	$0, %eax
	call	close
	movl	$1, %edi
	call	exit
.L6:
.LBE4:
	.loc 1 56 0
	movl	$.LC9, %edi
	call	puts
	.loc 1 60 0
	movl	$0, -20(%rbp)
	.loc 1 64 0
	movl	$16, -132(%rbp)
.L8:
	.loc 1 69 0
	leaq	-132(%rbp), %rdx
	leaq	-128(%rbp), %rcx
	movl	$0, %eax
	movq	%rcx, %rax
	leaq	-112(%rbp), %rsi
	movl	-24(%rbp), %ebx
	movq	%rdx, %r9
	movq	%rax, %r8
	movl	$0, %ecx
	movl	$32, %edx
	movl	%ebx, %edi
	call	recvfrom
	movl	%eax, -20(%rbp)
	cmpl	$0, -20(%rbp)
	jg	.L7
.LBB5:
	.loc 1 70 0
	movl	$.LC10, %edi
	call	perror
	movl	-24(%rbp), %eax
	movl	%eax, %edi
	movl	$0, %eax
	call	close
	movl	$1, %edi
	call	exit
.L7:
.LBE5:
	.loc 1 72 0
	movl	-20(%rbp), %eax
	cltq
	movb	$0, -112(%rbp,%rax)
	.loc 1 74 0
	movzwl	-126(%rbp), %eax
	.loc 1 73 0
	movzwl	%ax, %eax
	movl	%eax, %edi
	call	ntohs
	movzwl	%ax, %r12d
	movl	-124(%rbp), %eax
	movl	%eax, %edi
	call	inet_ntoa
	movq	%rax, %rbx
	movl	$.LC11, %eax
	leaq	-112(%rbp), %rdx
	movq	%rdx, %rcx
	movl	%r12d, %edx
	movq	%rbx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf
	.loc 1 75 0
	jmp	.L8
	.cfi_endproc
.LFE0:
	.size	main, .-main
.Letext0:
	.file 2 "/usr/include/bits/socket.h"
	.file 3 "/usr/include/netinet/in.h"
	.file 4 "/usr/include/bits/sockaddr.h"
	.file 5 "/usr/include/stdint.h"
	.file 6 "<built-in>"
	.section	.debug_info
	.long	0x3e6
	.value	0x3
	.long	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.long	.LASF73
	.byte	0x1
	.long	.LASF74
	.long	.LASF75
	.quad	.Ltext0
	.quad	.Letext0
	.long	.Ldebug_line0
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.long	.LASF0
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.long	.LASF1
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.long	.LASF2
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.long	.LASF3
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.long	.LASF4
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.long	.LASF5
	.uleb128 0x3
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.long	.LASF6
	.uleb128 0x4
	.byte	0x8
	.uleb128 0x5
	.byte	0x8
	.long	0x6d
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.long	.LASF7
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.long	.LASF8
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.long	.LASF9
	.uleb128 0x6
	.long	0x6d
	.long	0x92
	.uleb128 0x7
	.long	0x42
	.byte	0x1f
	.byte	0x0
	.uleb128 0x8
	.long	.LASF76
	.byte	0x4
	.byte	0x2
	.byte	0x29
	.long	0xd8
	.uleb128 0x9
	.long	.LASF10
	.sleb128 1
	.uleb128 0x9
	.long	.LASF11
	.sleb128 2
	.uleb128 0x9
	.long	.LASF12
	.sleb128 3
	.uleb128 0x9
	.long	.LASF13
	.sleb128 4
	.uleb128 0x9
	.long	.LASF14
	.sleb128 5
	.uleb128 0x9
	.long	.LASF15
	.sleb128 6
	.uleb128 0x9
	.long	.LASF16
	.sleb128 10
	.uleb128 0x9
	.long	.LASF17
	.sleb128 524288
	.uleb128 0x9
	.long	.LASF18
	.sleb128 2048
	.byte	0x0
	.uleb128 0xa
	.long	.LASF27
	.byte	0x4
	.byte	0x1d
	.long	0x34
	.uleb128 0xb
	.long	.LASF21
	.byte	0x10
	.byte	0x2
	.byte	0xaf
	.long	0x108
	.uleb128 0xc
	.long	.LASF19
	.byte	0x2
	.byte	0xb0
	.long	0xd8
	.sleb128 0
	.uleb128 0xc
	.long	.LASF20
	.byte	0x2
	.byte	0xb1
	.long	0x108
	.sleb128 2
	.byte	0x0
	.uleb128 0x6
	.long	0x6d
	.long	0x118
	.uleb128 0x7
	.long	0x42
	.byte	0xd
	.byte	0x0
	.uleb128 0xb
	.long	.LASF22
	.byte	0x10
	.byte	0x3
	.byte	0xf0
	.long	0x155
	.uleb128 0xc
	.long	.LASF23
	.byte	0x3
	.byte	0xf1
	.long	0xd8
	.sleb128 0
	.uleb128 0xc
	.long	.LASF24
	.byte	0x3
	.byte	0xf2
	.long	0x237
	.sleb128 2
	.uleb128 0xc
	.long	.LASF25
	.byte	0x3
	.byte	0xf3
	.long	0x176
	.sleb128 4
	.uleb128 0xc
	.long	.LASF26
	.byte	0x3
	.byte	0xf6
	.long	0x242
	.sleb128 8
	.byte	0x0
	.uleb128 0xa
	.long	.LASF28
	.byte	0x5
	.byte	0x32
	.long	0x34
	.uleb128 0xa
	.long	.LASF29
	.byte	0x5
	.byte	0x34
	.long	0x3b
	.uleb128 0xa
	.long	.LASF30
	.byte	0x3
	.byte	0x20
	.long	0x160
	.uleb128 0xb
	.long	.LASF31
	.byte	0x4
	.byte	0x3
	.byte	0x22
	.long	0x18f
	.uleb128 0xc
	.long	.LASF32
	.byte	0x3
	.byte	0x23
	.long	0x16b
	.sleb128 0
	.byte	0x0
	.uleb128 0xd
	.byte	0x4
	.byte	0x3
	.byte	0x2b
	.long	0x237
	.uleb128 0x9
	.long	.LASF33
	.sleb128 0
	.uleb128 0x9
	.long	.LASF34
	.sleb128 1
	.uleb128 0x9
	.long	.LASF35
	.sleb128 2
	.uleb128 0x9
	.long	.LASF36
	.sleb128 4
	.uleb128 0x9
	.long	.LASF37
	.sleb128 6
	.uleb128 0x9
	.long	.LASF38
	.sleb128 8
	.uleb128 0x9
	.long	.LASF39
	.sleb128 12
	.uleb128 0x9
	.long	.LASF40
	.sleb128 17
	.uleb128 0x9
	.long	.LASF41
	.sleb128 22
	.uleb128 0x9
	.long	.LASF42
	.sleb128 29
	.uleb128 0x9
	.long	.LASF43
	.sleb128 33
	.uleb128 0x9
	.long	.LASF44
	.sleb128 41
	.uleb128 0x9
	.long	.LASF45
	.sleb128 46
	.uleb128 0x9
	.long	.LASF46
	.sleb128 47
	.uleb128 0x9
	.long	.LASF47
	.sleb128 50
	.uleb128 0x9
	.long	.LASF48
	.sleb128 51
	.uleb128 0x9
	.long	.LASF49
	.sleb128 92
	.uleb128 0x9
	.long	.LASF50
	.sleb128 94
	.uleb128 0x9
	.long	.LASF51
	.sleb128 98
	.uleb128 0x9
	.long	.LASF52
	.sleb128 103
	.uleb128 0x9
	.long	.LASF53
	.sleb128 108
	.uleb128 0x9
	.long	.LASF54
	.sleb128 132
	.uleb128 0x9
	.long	.LASF55
	.sleb128 136
	.uleb128 0x9
	.long	.LASF56
	.sleb128 255
	.uleb128 0x9
	.long	.LASF57
	.sleb128 256
	.byte	0x0
	.uleb128 0xa
	.long	.LASF58
	.byte	0x3
	.byte	0x77
	.long	0x155
	.uleb128 0x6
	.long	0x2d
	.long	0x252
	.uleb128 0x7
	.long	0x42
	.byte	0x7
	.byte	0x0
	.uleb128 0xe
	.long	.LASF59
	.byte	0x8
	.byte	0x3
	.value	0x10b
	.long	0x27a
	.uleb128 0xf
	.long	.LASF60
	.byte	0x3
	.value	0x10d
	.long	0x176
	.sleb128 0
	.uleb128 0xf
	.long	.LASF61
	.byte	0x3
	.value	0x110
	.long	0x176
	.sleb128 4
	.byte	0x0
	.uleb128 0x10
	.byte	0x1
	.long	.LASF77
	.byte	0x1
	.byte	0x11
	.byte	0x1
	.long	0x57
	.quad	.LFB0
	.quad	.LFE0
	.byte	0x1
	.byte	0x9c
	.long	0x3e3
	.uleb128 0x11
	.long	.LASF62
	.byte	0x1
	.byte	0x11
	.long	0x57
	.byte	0x3
	.byte	0x91
	.sleb128 -164
	.uleb128 0x11
	.long	.LASF63
	.byte	0x1
	.byte	0x11
	.long	0x3e3
	.byte	0x3
	.byte	0x91
	.sleb128 -176
	.uleb128 0x12
	.long	.LASF64
	.byte	0x1
	.byte	0x13
	.long	0x118
	.byte	0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x12
	.long	.LASF65
	.byte	0x1
	.byte	0x14
	.long	0x252
	.byte	0x3
	.byte	0x91
	.sleb128 -80
	.uleb128 0x12
	.long	.LASF66
	.byte	0x1
	.byte	0x15
	.long	0x57
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x12
	.long	.LASF67
	.byte	0x1
	.byte	0x1e
	.long	0x57
	.byte	0x3
	.byte	0x91
	.sleb128 -84
	.uleb128 0x13
	.byte	0x1
	.long	.LASF78
	.byte	0x6
	.byte	0x0
	.byte	0x1
	.long	0x65
	.byte	0x1
	.long	0x317
	.uleb128 0x14
	.long	0x65
	.uleb128 0x14
	.long	0x57
	.uleb128 0x14
	.long	0x42
	.byte	0x0
	.uleb128 0x12
	.long	.LASF68
	.byte	0x1
	.byte	0x3b
	.long	0x82
	.byte	0x3
	.byte	0x91
	.sleb128 -128
	.uleb128 0x12
	.long	.LASF69
	.byte	0x1
	.byte	0x3c
	.long	0x57
	.byte	0x2
	.byte	0x91
	.sleb128 -36
	.uleb128 0x12
	.long	.LASF70
	.byte	0x1
	.byte	0x3e
	.long	0x118
	.byte	0x3
	.byte	0x91
	.sleb128 -144
	.uleb128 0x12
	.long	.LASF71
	.byte	0x1
	.byte	0x3f
	.long	0x57
	.byte	0x3
	.byte	0x91
	.sleb128 -148
	.uleb128 0x15
	.quad	.LBB2
	.quad	.LBE2
	.long	0x377
	.uleb128 0x16
	.byte	0x1
	.long	.LASF72
	.byte	0x1
	.byte	0x20
	.long	0x57
	.byte	0x1
	.uleb128 0x17
	.byte	0x0
	.byte	0x0
	.uleb128 0x15
	.quad	.LBB3
	.quad	.LBE3
	.long	0x39c
	.uleb128 0x16
	.byte	0x1
	.long	.LASF72
	.byte	0x1
	.byte	0x20
	.long	0x57
	.byte	0x1
	.uleb128 0x17
	.byte	0x0
	.byte	0x0
	.uleb128 0x15
	.quad	.LBB4
	.quad	.LBE4
	.long	0x3c1
	.uleb128 0x16
	.byte	0x1
	.long	.LASF72
	.byte	0x1
	.byte	0x20
	.long	0x57
	.byte	0x1
	.uleb128 0x17
	.byte	0x0
	.byte	0x0
	.uleb128 0x18
	.quad	.LBB5
	.quad	.LBE5
	.uleb128 0x16
	.byte	0x1
	.long	.LASF72
	.byte	0x1
	.byte	0x20
	.long	0x57
	.byte	0x1
	.uleb128 0x17
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.uleb128 0x5
	.byte	0x8
	.long	0x67
	.byte	0x0
	.section	.debug_abbrev
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x10
	.uleb128 0x6
	.byte	0x0
	.byte	0x0
	.uleb128 0x2
	.uleb128 0x24
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0x0
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0x0
	.byte	0x0
	.uleb128 0x4
	.uleb128 0xf
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x5
	.uleb128 0xf
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x6
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x7
	.uleb128 0x21
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x8
	.uleb128 0x4
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x9
	.uleb128 0x28
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1c
	.uleb128 0xd
	.byte	0x0
	.byte	0x0
	.uleb128 0xa
	.uleb128 0x16
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xb
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xc
	.uleb128 0xd
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xd
	.byte	0x0
	.byte	0x0
	.uleb128 0xd
	.uleb128 0x4
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xe
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xf
	.uleb128 0xd
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xd
	.byte	0x0
	.byte	0x0
	.uleb128 0x10
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0xa
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x11
	.uleb128 0x5
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x12
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x13
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0xc
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x14
	.uleb128 0x5
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x15
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x16
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0x0
	.byte	0x0
	.uleb128 0x17
	.uleb128 0x18
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.uleb128 0x18
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.section	.debug_pubnames,"",@progbits
	.long	0x17
	.value	0x2
	.long	.Ldebug_info0
	.long	0x3ea
	.long	0x27a
	.string	"main"
	.long	0x0
	.section	.debug_pubtypes,"",@progbits
	.long	0x9b
	.value	0x2
	.long	.Ldebug_info0
	.long	0x3ea
	.long	0x92
	.string	"__socket_type"
	.long	0xd8
	.string	"sa_family_t"
	.long	0xe3
	.string	"sockaddr"
	.long	0x155
	.string	"uint16_t"
	.long	0x160
	.string	"uint32_t"
	.long	0x16b
	.string	"in_addr_t"
	.long	0x176
	.string	"in_addr"
	.long	0x237
	.string	"in_port_t"
	.long	0x118
	.string	"sockaddr_in"
	.long	0x252
	.string	"ip_mreq"
	.long	0x0
	.section	.debug_aranges,"",@progbits
	.long	0x2c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x8
	.byte	0x0
	.value	0x0
	.value	0x0
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.quad	0x0
	.quad	0x0
	.section	.debug_str,"MS",@progbits,1
.LASF59:
	.string	"ip_mreq"
.LASF72:
	.string	"close"
.LASF40:
	.string	"IPPROTO_UDP"
.LASF75:
	.string	"/home/e313837/Tutorials/socket_programming/ch04_connectionless_oriented_protocols/multicast/binaryMulticast"
.LASF42:
	.string	"IPPROTO_TP"
.LASF15:
	.string	"SOCK_DCCP"
.LASF45:
	.string	"IPPROTO_RSVP"
.LASF64:
	.string	"localSock"
.LASF5:
	.string	"short int"
.LASF33:
	.string	"IPPROTO_IP"
.LASF50:
	.string	"IPPROTO_BEETPH"
.LASF39:
	.string	"IPPROTO_PUP"
.LASF55:
	.string	"IPPROTO_UDPLITE"
.LASF77:
	.string	"main"
.LASF14:
	.string	"SOCK_SEQPACKET"
.LASF57:
	.string	"IPPROTO_MAX"
.LASF70:
	.string	"txAddress"
.LASF68:
	.string	"recDataBuf"
.LASF43:
	.string	"IPPROTO_DCCP"
.LASF49:
	.string	"IPPROTO_MTP"
.LASF53:
	.string	"IPPROTO_COMP"
.LASF23:
	.string	"sin_family"
.LASF67:
	.string	"reuse"
.LASF65:
	.string	"mcastGroup"
.LASF62:
	.string	"argc"
.LASF9:
	.string	"long long int"
.LASF46:
	.string	"IPPROTO_GRE"
.LASF78:
	.string	"memset"
.LASF6:
	.string	"long int"
.LASF74:
	.string	"dgramReceive.c"
.LASF11:
	.string	"SOCK_DGRAM"
.LASF41:
	.string	"IPPROTO_IDP"
.LASF25:
	.string	"sin_addr"
.LASF34:
	.string	"IPPROTO_ICMP"
.LASF0:
	.string	"unsigned char"
.LASF27:
	.string	"sa_family_t"
.LASF60:
	.string	"imr_multiaddr"
.LASF13:
	.string	"SOCK_RDM"
.LASF69:
	.string	"recvdBytes"
.LASF4:
	.string	"signed char"
.LASF26:
	.string	"sin_zero"
.LASF8:
	.string	"long long unsigned int"
.LASF29:
	.string	"uint32_t"
.LASF2:
	.string	"unsigned int"
.LASF28:
	.string	"uint16_t"
.LASF32:
	.string	"s_addr"
.LASF3:
	.string	"long unsigned int"
.LASF63:
	.string	"argv"
.LASF20:
	.string	"sa_data"
.LASF1:
	.string	"short unsigned int"
.LASF36:
	.string	"IPPROTO_IPIP"
.LASF51:
	.string	"IPPROTO_ENCAP"
.LASF7:
	.string	"char"
.LASF54:
	.string	"IPPROTO_SCTP"
.LASF38:
	.string	"IPPROTO_EGP"
.LASF17:
	.string	"SOCK_CLOEXEC"
.LASF30:
	.string	"in_addr_t"
.LASF35:
	.string	"IPPROTO_IGMP"
.LASF76:
	.string	"__socket_type"
.LASF12:
	.string	"SOCK_RAW"
.LASF56:
	.string	"IPPROTO_RAW"
.LASF73:
	.string	"GNU C 4.4.7 20120313 (Red Hat 4.4.7-18)"
.LASF31:
	.string	"in_addr"
.LASF16:
	.string	"SOCK_PACKET"
.LASF24:
	.string	"sin_port"
.LASF66:
	.string	"localRxSock"
.LASF58:
	.string	"in_port_t"
.LASF71:
	.string	"txSockLen"
.LASF19:
	.string	"sa_family"
.LASF61:
	.string	"imr_interface"
.LASF37:
	.string	"IPPROTO_TCP"
.LASF47:
	.string	"IPPROTO_ESP"
.LASF10:
	.string	"SOCK_STREAM"
.LASF52:
	.string	"IPPROTO_PIM"
.LASF44:
	.string	"IPPROTO_IPV6"
.LASF48:
	.string	"IPPROTO_AH"
.LASF22:
	.string	"sockaddr_in"
.LASF21:
	.string	"sockaddr"
.LASF18:
	.string	"SOCK_NONBLOCK"
	.ident	"GCC: (GNU) 4.4.7 20120313 (Red Hat 4.4.7-18)"
	.section	.note.GNU-stack,"",@progbits

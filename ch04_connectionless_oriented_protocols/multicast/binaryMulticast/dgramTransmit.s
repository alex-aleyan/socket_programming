	.file	"dgramTransmit.c"
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
	.string	"rb"
.LC1:
	.string	"data.bin"
.LC2:
	.string	"Unable to open file %s"
.LC3:
	.string	"fileLen (bytes): %d\n"
.LC4:
	.string	"The data read from %s: "
.LC5:
	.string	"0x%02x "
.LC6:
	.string	"Opening datagram socket error"
	.align 8
.LC7:
	.string	"Opening the datagram socket...OK."
.LC8:
	.string	"226.1.1.1"
	.align 8
.LC9:
	.string	"Multicast Address (big endian): %08x\n"
.LC10:
	.string	"Multicast Address: %s\n"
.LC11:
	.string	"Multicast Port: %08x\n"
.LC12:
	.string	"Multicast Port: %d \n"
.LC13:
	.string	"192.168.40.180"
.LC14:
	.string	"Tx NIC (big endian): %08x\n"
.LC15:
	.string	"Tx NIC: %s\n"
.LC16:
	.string	"Setting local interface error"
	.align 8
.LC17:
	.string	"Setting the local interface...OK"
	.align 8
.LC18:
	.string	"Sending datagram message error"
.LC19:
	.string	"Sending datagram message...OK"
	.text
.globl main
	.type	main, @function
main:
.LFB0:
	.file 1 "dgramTransmit.c"
	.loc 1 24 0
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r12
	pushq	%rbx
	subq	$96, %rsp
	movl	%edi, -100(%rbp)
	movq	%rsi, -112(%rbp)
	.loc 1 24 0
	movq	%rsp, %rax
	movq	%rax, %r12
	.cfi_offset 3, -32
	.cfi_offset 12, -24
	.loc 1 28 0
	movq	$0, -48(%rbp)
	.loc 1 30 0
	movl	$.LC0, %edx
	movl	$.LC1, %eax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	fopen
	movq	%rax, -48(%rbp)
	cmpq	$0, -48(%rbp)
	jne	.L2
	movl	$.LC2, %ecx
	movq	stderr(%rip), %rax
	movl	$.LC1, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	movl	$1, %eax
	jmp	.L3
.L2:
	.loc 1 31 0
	movq	-48(%rbp), %rax
	movl	$2, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	fseek
	.loc 1 32 0
	movq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	ftell
	movq	%rax, -40(%rbp)
	.loc 1 35 0
	movl	$.LC3, %eax
	movq	-40(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf
	.loc 1 38 0
	movq	-48(%rbp), %rax
	movl	$0, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	fseek
	.loc 1 39 0
	movq	-40(%rbp), %rax
	movq	%rax, %rdx
	subq	$1, %rdx
	movq	%rdx, -64(%rbp)
	addq	$15, %rax
	addq	$15, %rax
	shrq	$4, %rax
	salq	$4, %rax
	subq	%rax, %rsp
	movq	%rsp, %rax
	addq	$15, %rax
	shrq	$4, %rax
	salq	$4, %rax
	movq	%rax, -56(%rbp)
	.loc 1 41 0
	movq	-56(%rbp), %rax
	movq	-48(%rbp), %rdx
	movq	-40(%rbp), %rbx
	movq	%rdx, %rcx
	movl	$1, %edx
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	fread
	.loc 1 44 0
	movq	-56(%rbp), %rax
	movq	%rax, -32(%rbp)
	.loc 1 45 0
	movl	$.LC4, %eax
	movl	$.LC1, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf
	.loc 1 46 0
	movl	$0, -24(%rbp)
	jmp	.L4
.L5:
	movl	-24(%rbp), %eax
	cltq
	addq	-32(%rbp), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %edx
	movl	$.LC5, %eax
	movl	%edx, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf
	addl	$1, -24(%rbp)
.L4:
	movl	-24(%rbp), %eax
	cltq
	cmpq	-40(%rbp), %rax
	jb	.L5
	.loc 1 47 0
	movl	$10, %edi
	call	putchar
	.loc 1 50 0
	movq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	fclose
	.loc 1 58 0
	movl	$0, %edx
	movl	$2, %esi
	movl	$2, %edi
	call	socket
	movl	%eax, -20(%rbp)
	.loc 1 59 0
	cmpl	$0, -20(%rbp)
	jns	.L6
	movl	$.LC6, %edi
	call	perror
	movl	$1, %edi
	call	exit
.L6:
	.loc 1 60 0
	movl	$.LC7, %edi
	call	puts
	.loc 1 65 0
	leaq	-80(%rbp), %rax
	movl	$16, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	memset
	.loc 1 66 0
	movw	$2, -80(%rbp)
	.loc 1 67 0
	movl	$.LC8, %edi
	call	inet_addr
	movl	%eax, -76(%rbp)
	.loc 1 68 0
	movl	$4321, %edi
	call	htons
	movw	%ax, -78(%rbp)
	.loc 1 70 0
	movl	-76(%rbp), %edx
	movl	$.LC9, %eax
	movl	%edx, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf
	.loc 1 71 0
	movl	-76(%rbp), %eax
	movl	%eax, %edi
	call	inet_ntoa
	movq	%rax, %rdx
	movl	$.LC10, %eax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf
	.loc 1 72 0
	movzwl	-78(%rbp), %eax
	movzwl	%ax, %eax
	movl	%eax, %edi
	call	ntohs
	movzwl	%ax, %edx
	movl	$.LC11, %eax
	movl	%edx, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf
	.loc 1 73 0
	movzwl	-78(%rbp), %eax
	movzwl	%ax, %eax
	movl	%eax, %edi
	call	ntohs
	movzwl	%ax, %edx
	movl	$.LC12, %eax
	movl	%edx, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf
	.loc 1 80 0
	movl	$.LC13, %edi
	call	inet_addr
	movl	%eax, -96(%rbp)
	.loc 1 81 0
	cmpl	$1, -100(%rbp)
	jle	.L7
	movq	-112(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	inet_addr
	movl	%eax, -96(%rbp)
.L7:
	.loc 1 83 0
	movl	-96(%rbp), %edx
	movl	$.LC14, %eax
	movl	%edx, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf
	.loc 1 84 0
	movl	-96(%rbp), %eax
	movl	%eax, %edi
	call	inet_ntoa
	movq	%rax, %rdx
	movl	$.LC15, %eax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf
	.loc 1 86 0
	leaq	-96(%rbp), %rdx
	movl	-20(%rbp), %eax
	movl	$4, %r8d
	movq	%rdx, %rcx
	movl	$32, %edx
	movl	$0, %esi
	movl	%eax, %edi
	call	setsockopt
	testl	%eax, %eax
	jns	.L8
	.loc 1 87 0
	movl	$.LC16, %edi
	call	perror
	movl	$1, %edi
	call	exit
.L8:
	.loc 1 88 0
	movl	$.LC17, %edi
	call	puts
	.loc 1 91 0
	leaq	-80(%rbp), %rdx
	movl	$0, %eax
	movq	%rdx, %rax
	movq	-56(%rbp), %rsi
	movq	-40(%rbp), %rdx
	movl	-20(%rbp), %ebx
	movl	$16, %r9d
	movq	%rax, %r8
	movl	$0, %ecx
	movl	%ebx, %edi
	call	sendto
	testq	%rax, %rax
	jns	.L9
	.loc 1 92 0
	movl	$.LC18, %edi
	call	perror
	jmp	.L10
.L9:
	.loc 1 93 0
	movl	$.LC19, %edi
	call	puts
.L10:
	.loc 1 95 0
	movl	$0, %eax
.L3:
	movq	%r12, %rsp
	.loc 1 96 0
	leaq	-16(%rbp), %rsp
	addq	$0, %rsp
	popq	%rbx
	popq	%r12
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
.Letext0:
	.file 2 "/usr/include/bits/types.h"
	.file 3 "/usr/lib/gcc/x86_64-redhat-linux/4.4.7/include/stddef.h"
	.file 4 "/usr/include/bits/sockaddr.h"
	.file 5 "/usr/include/bits/socket.h"
	.file 6 "/usr/include/netinet/in.h"
	.file 7 "/usr/include/stdint.h"
	.file 8 "/usr/include/stdio.h"
	.file 9 "/usr/include/libio.h"
	.file 10 "<built-in>"
	.section	.debug_info
	.long	0x586
	.value	0x3
	.long	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.long	.LASF106
	.byte	0x1
	.long	.LASF107
	.long	.LASF108
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
	.long	.LASF7
	.byte	0x2
	.byte	0x8d
	.long	0x5e
	.uleb128 0x4
	.long	.LASF8
	.byte	0x2
	.byte	0x8e
	.long	0x5e
	.uleb128 0x5
	.byte	0x8
	.uleb128 0x6
	.byte	0x8
	.long	0x83
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.long	.LASF9
	.uleb128 0x4
	.long	.LASF10
	.byte	0x3
	.byte	0xd3
	.long	0x42
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.long	.LASF11
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.long	.LASF12
	.uleb128 0x7
	.long	.LASF109
	.byte	0x4
	.byte	0x5
	.byte	0x29
	.long	0xe9
	.uleb128 0x8
	.long	.LASF13
	.sleb128 1
	.uleb128 0x8
	.long	.LASF14
	.sleb128 2
	.uleb128 0x8
	.long	.LASF15
	.sleb128 3
	.uleb128 0x8
	.long	.LASF16
	.sleb128 4
	.uleb128 0x8
	.long	.LASF17
	.sleb128 5
	.uleb128 0x8
	.long	.LASF18
	.sleb128 6
	.uleb128 0x8
	.long	.LASF19
	.sleb128 10
	.uleb128 0x8
	.long	.LASF20
	.sleb128 524288
	.uleb128 0x8
	.long	.LASF21
	.sleb128 2048
	.byte	0x0
	.uleb128 0x4
	.long	.LASF22
	.byte	0x4
	.byte	0x1d
	.long	0x34
	.uleb128 0x9
	.long	.LASF25
	.byte	0x10
	.byte	0x5
	.byte	0xaf
	.long	0x119
	.uleb128 0xa
	.long	.LASF23
	.byte	0x5
	.byte	0xb0
	.long	0xe9
	.sleb128 0
	.uleb128 0xa
	.long	.LASF24
	.byte	0x5
	.byte	0xb1
	.long	0x119
	.sleb128 2
	.byte	0x0
	.uleb128 0xb
	.long	0x83
	.long	0x129
	.uleb128 0xc
	.long	0x42
	.byte	0xd
	.byte	0x0
	.uleb128 0x9
	.long	.LASF26
	.byte	0x10
	.byte	0x6
	.byte	0xf0
	.long	0x166
	.uleb128 0xa
	.long	.LASF27
	.byte	0x6
	.byte	0xf1
	.long	0xe9
	.sleb128 0
	.uleb128 0xa
	.long	.LASF28
	.byte	0x6
	.byte	0xf2
	.long	0x248
	.sleb128 2
	.uleb128 0xa
	.long	.LASF29
	.byte	0x6
	.byte	0xf3
	.long	0x187
	.sleb128 4
	.uleb128 0xa
	.long	.LASF30
	.byte	0x6
	.byte	0xf6
	.long	0x253
	.sleb128 8
	.byte	0x0
	.uleb128 0x4
	.long	.LASF31
	.byte	0x7
	.byte	0x32
	.long	0x34
	.uleb128 0x4
	.long	.LASF32
	.byte	0x7
	.byte	0x34
	.long	0x3b
	.uleb128 0x4
	.long	.LASF33
	.byte	0x6
	.byte	0x20
	.long	0x171
	.uleb128 0x9
	.long	.LASF34
	.byte	0x4
	.byte	0x6
	.byte	0x22
	.long	0x1a0
	.uleb128 0xa
	.long	.LASF35
	.byte	0x6
	.byte	0x23
	.long	0x17c
	.sleb128 0
	.byte	0x0
	.uleb128 0xd
	.byte	0x4
	.byte	0x6
	.byte	0x2b
	.long	0x248
	.uleb128 0x8
	.long	.LASF36
	.sleb128 0
	.uleb128 0x8
	.long	.LASF37
	.sleb128 1
	.uleb128 0x8
	.long	.LASF38
	.sleb128 2
	.uleb128 0x8
	.long	.LASF39
	.sleb128 4
	.uleb128 0x8
	.long	.LASF40
	.sleb128 6
	.uleb128 0x8
	.long	.LASF41
	.sleb128 8
	.uleb128 0x8
	.long	.LASF42
	.sleb128 12
	.uleb128 0x8
	.long	.LASF43
	.sleb128 17
	.uleb128 0x8
	.long	.LASF44
	.sleb128 22
	.uleb128 0x8
	.long	.LASF45
	.sleb128 29
	.uleb128 0x8
	.long	.LASF46
	.sleb128 33
	.uleb128 0x8
	.long	.LASF47
	.sleb128 41
	.uleb128 0x8
	.long	.LASF48
	.sleb128 46
	.uleb128 0x8
	.long	.LASF49
	.sleb128 47
	.uleb128 0x8
	.long	.LASF50
	.sleb128 50
	.uleb128 0x8
	.long	.LASF51
	.sleb128 51
	.uleb128 0x8
	.long	.LASF52
	.sleb128 92
	.uleb128 0x8
	.long	.LASF53
	.sleb128 94
	.uleb128 0x8
	.long	.LASF54
	.sleb128 98
	.uleb128 0x8
	.long	.LASF55
	.sleb128 103
	.uleb128 0x8
	.long	.LASF56
	.sleb128 108
	.uleb128 0x8
	.long	.LASF57
	.sleb128 132
	.uleb128 0x8
	.long	.LASF58
	.sleb128 136
	.uleb128 0x8
	.long	.LASF59
	.sleb128 255
	.uleb128 0x8
	.long	.LASF60
	.sleb128 256
	.byte	0x0
	.uleb128 0x4
	.long	.LASF61
	.byte	0x6
	.byte	0x77
	.long	0x166
	.uleb128 0xb
	.long	0x2d
	.long	0x263
	.uleb128 0xc
	.long	0x42
	.byte	0x7
	.byte	0x0
	.uleb128 0x4
	.long	.LASF62
	.byte	0x8
	.byte	0x31
	.long	0x26e
	.uleb128 0xe
	.long	.LASF63
	.byte	0xd8
	.byte	0x9
	.value	0x10f
	.long	0x40a
	.uleb128 0xf
	.long	.LASF64
	.byte	0x9
	.value	0x110
	.long	0x57
	.sleb128 0
	.uleb128 0xf
	.long	.LASF65
	.byte	0x9
	.value	0x115
	.long	0x7d
	.sleb128 8
	.uleb128 0xf
	.long	.LASF66
	.byte	0x9
	.value	0x116
	.long	0x7d
	.sleb128 16
	.uleb128 0xf
	.long	.LASF67
	.byte	0x9
	.value	0x117
	.long	0x7d
	.sleb128 24
	.uleb128 0xf
	.long	.LASF68
	.byte	0x9
	.value	0x118
	.long	0x7d
	.sleb128 32
	.uleb128 0xf
	.long	.LASF69
	.byte	0x9
	.value	0x119
	.long	0x7d
	.sleb128 40
	.uleb128 0xf
	.long	.LASF70
	.byte	0x9
	.value	0x11a
	.long	0x7d
	.sleb128 48
	.uleb128 0xf
	.long	.LASF71
	.byte	0x9
	.value	0x11b
	.long	0x7d
	.sleb128 56
	.uleb128 0xf
	.long	.LASF72
	.byte	0x9
	.value	0x11c
	.long	0x7d
	.sleb128 64
	.uleb128 0xf
	.long	.LASF73
	.byte	0x9
	.value	0x11e
	.long	0x7d
	.sleb128 72
	.uleb128 0xf
	.long	.LASF74
	.byte	0x9
	.value	0x11f
	.long	0x7d
	.sleb128 80
	.uleb128 0xf
	.long	.LASF75
	.byte	0x9
	.value	0x120
	.long	0x7d
	.sleb128 88
	.uleb128 0xf
	.long	.LASF76
	.byte	0x9
	.value	0x122
	.long	0x442
	.sleb128 96
	.uleb128 0xf
	.long	.LASF77
	.byte	0x9
	.value	0x124
	.long	0x448
	.sleb128 104
	.uleb128 0xf
	.long	.LASF78
	.byte	0x9
	.value	0x126
	.long	0x57
	.sleb128 112
	.uleb128 0xf
	.long	.LASF79
	.byte	0x9
	.value	0x12a
	.long	0x57
	.sleb128 116
	.uleb128 0xf
	.long	.LASF80
	.byte	0x9
	.value	0x12c
	.long	0x65
	.sleb128 120
	.uleb128 0xf
	.long	.LASF81
	.byte	0x9
	.value	0x130
	.long	0x34
	.sleb128 128
	.uleb128 0xf
	.long	.LASF82
	.byte	0x9
	.value	0x131
	.long	0x49
	.sleb128 130
	.uleb128 0xf
	.long	.LASF83
	.byte	0x9
	.value	0x132
	.long	0x44e
	.sleb128 131
	.uleb128 0xf
	.long	.LASF84
	.byte	0x9
	.value	0x136
	.long	0x45e
	.sleb128 136
	.uleb128 0xf
	.long	.LASF85
	.byte	0x9
	.value	0x13f
	.long	0x70
	.sleb128 144
	.uleb128 0xf
	.long	.LASF86
	.byte	0x9
	.value	0x148
	.long	0x7b
	.sleb128 152
	.uleb128 0xf
	.long	.LASF87
	.byte	0x9
	.value	0x149
	.long	0x7b
	.sleb128 160
	.uleb128 0xf
	.long	.LASF88
	.byte	0x9
	.value	0x14a
	.long	0x7b
	.sleb128 168
	.uleb128 0xf
	.long	.LASF89
	.byte	0x9
	.value	0x14b
	.long	0x7b
	.sleb128 176
	.uleb128 0xf
	.long	.LASF90
	.byte	0x9
	.value	0x14c
	.long	0x8a
	.sleb128 184
	.uleb128 0xf
	.long	.LASF91
	.byte	0x9
	.value	0x14e
	.long	0x57
	.sleb128 192
	.uleb128 0xf
	.long	.LASF92
	.byte	0x9
	.value	0x150
	.long	0x464
	.sleb128 196
	.byte	0x0
	.uleb128 0x10
	.long	.LASF110
	.byte	0x9
	.byte	0xb4
	.uleb128 0x9
	.long	.LASF93
	.byte	0x18
	.byte	0x9
	.byte	0xba
	.long	0x442
	.uleb128 0xa
	.long	.LASF94
	.byte	0x9
	.byte	0xbb
	.long	0x442
	.sleb128 0
	.uleb128 0xa
	.long	.LASF95
	.byte	0x9
	.byte	0xbc
	.long	0x448
	.sleb128 8
	.uleb128 0xa
	.long	.LASF96
	.byte	0x9
	.byte	0xc0
	.long	0x57
	.sleb128 16
	.byte	0x0
	.uleb128 0x6
	.byte	0x8
	.long	0x411
	.uleb128 0x6
	.byte	0x8
	.long	0x26e
	.uleb128 0xb
	.long	0x83
	.long	0x45e
	.uleb128 0xc
	.long	0x42
	.byte	0x0
	.byte	0x0
	.uleb128 0x6
	.byte	0x8
	.long	0x40a
	.uleb128 0xb
	.long	0x83
	.long	0x474
	.uleb128 0xc
	.long	0x42
	.byte	0x13
	.byte	0x0
	.uleb128 0x11
	.byte	0x1
	.long	.LASF111
	.byte	0x1
	.byte	0x17
	.byte	0x1
	.long	0x57
	.quad	.LFB0
	.quad	.LFE0
	.byte	0x1
	.byte	0x9c
	.long	0x549
	.uleb128 0x12
	.long	.LASF97
	.byte	0x1
	.byte	0x17
	.long	0x57
	.byte	0x3
	.byte	0x91
	.sleb128 -116
	.uleb128 0x12
	.long	.LASF98
	.byte	0x1
	.byte	0x17
	.long	0x549
	.byte	0x3
	.byte	0x91
	.sleb128 -128
	.uleb128 0x13
	.string	"fd"
	.byte	0x1
	.byte	0x1c
	.long	0x54f
	.byte	0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x14
	.long	.LASF99
	.byte	0x1
	.byte	0x20
	.long	0x42
	.byte	0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x14
	.long	.LASF100
	.byte	0x1
	.byte	0x27
	.long	0x555
	.byte	0x4
	.byte	0x91
	.sleb128 -72
	.byte	0x6
	.uleb128 0x14
	.long	.LASF101
	.byte	0x1
	.byte	0x2c
	.long	0x569
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x13
	.string	"i"
	.byte	0x1
	.byte	0x2e
	.long	0x57
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x14
	.long	.LASF102
	.byte	0x1
	.byte	0x39
	.long	0x57
	.byte	0x2
	.byte	0x91
	.sleb128 -36
	.uleb128 0x14
	.long	.LASF103
	.byte	0x1
	.byte	0x40
	.long	0x129
	.byte	0x3
	.byte	0x91
	.sleb128 -96
	.uleb128 0x15
	.byte	0x1
	.long	.LASF112
	.byte	0xa
	.byte	0x0
	.byte	0x1
	.long	0x7b
	.byte	0x1
	.long	0x539
	.uleb128 0x16
	.long	0x7b
	.uleb128 0x16
	.long	0x57
	.uleb128 0x16
	.long	0x42
	.byte	0x0
	.uleb128 0x14
	.long	.LASF104
	.byte	0x1
	.byte	0x4f
	.long	0x187
	.byte	0x3
	.byte	0x91
	.sleb128 -112
	.byte	0x0
	.uleb128 0x6
	.byte	0x8
	.long	0x7d
	.uleb128 0x6
	.byte	0x8
	.long	0x263
	.uleb128 0xb
	.long	0x2d
	.long	0x569
	.uleb128 0x17
	.long	0x42
	.byte	0x4
	.byte	0x91
	.sleb128 -80
	.byte	0x6
	.byte	0x0
	.uleb128 0x6
	.byte	0x8
	.long	0x2d
	.uleb128 0x18
	.long	.LASF105
	.byte	0x8
	.byte	0xa7
	.long	0x448
	.byte	0x1
	.byte	0x1
	.uleb128 0x18
	.long	.LASF105
	.byte	0x8
	.byte	0xa7
	.long	0x448
	.byte	0x1
	.byte	0x1
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
	.uleb128 0x5
	.uleb128 0xf
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x6
	.uleb128 0xf
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x7
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
	.uleb128 0x8
	.uleb128 0x28
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1c
	.uleb128 0xd
	.byte	0x0
	.byte	0x0
	.uleb128 0x9
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
	.uleb128 0xa
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
	.uleb128 0xb
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xc
	.uleb128 0x21
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
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
	.uleb128 0x16
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x11
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
	.uleb128 0x12
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
	.uleb128 0x13
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
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
	.uleb128 0x14
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
	.uleb128 0x15
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
	.uleb128 0x16
	.uleb128 0x5
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x17
	.uleb128 0x21
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x18
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
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.section	.debug_pubnames,"",@progbits
	.long	0x17
	.value	0x2
	.long	.Ldebug_info0
	.long	0x58a
	.long	0x474
	.string	"main"
	.long	0x0
	.section	.debug_pubtypes,"",@progbits
	.long	0xe8
	.value	0x2
	.long	.Ldebug_info0
	.long	0x58a
	.long	0x65
	.string	"__off_t"
	.long	0x70
	.string	"__off64_t"
	.long	0x8a
	.string	"size_t"
	.long	0xa3
	.string	"__socket_type"
	.long	0xe9
	.string	"sa_family_t"
	.long	0xf4
	.string	"sockaddr"
	.long	0x166
	.string	"uint16_t"
	.long	0x171
	.string	"uint32_t"
	.long	0x17c
	.string	"in_addr_t"
	.long	0x187
	.string	"in_addr"
	.long	0x248
	.string	"in_port_t"
	.long	0x129
	.string	"sockaddr_in"
	.long	0x263
	.string	"FILE"
	.long	0x40a
	.string	"_IO_lock_t"
	.long	0x411
	.string	"_IO_marker"
	.long	0x26e
	.string	"_IO_FILE"
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
.LASF80:
	.string	"_old_offset"
.LASF43:
	.string	"IPPROTO_UDP"
.LASF108:
	.string	"/home/e313837/Tutorials/socket_programming/ch04_connectionless_oriented_protocols/multicast/binaryMulticast"
.LASF45:
	.string	"IPPROTO_TP"
.LASF104:
	.string	"localInterface"
.LASF18:
	.string	"SOCK_DCCP"
.LASF48:
	.string	"IPPROTO_RSVP"
.LASF75:
	.string	"_IO_save_end"
.LASF5:
	.string	"short int"
.LASF10:
	.string	"size_t"
.LASF36:
	.string	"IPPROTO_IP"
.LASF85:
	.string	"_offset"
.LASF53:
	.string	"IPPROTO_BEETPH"
.LASF42:
	.string	"IPPROTO_PUP"
.LASF58:
	.string	"IPPROTO_UDPLITE"
.LASF69:
	.string	"_IO_write_ptr"
.LASF64:
	.string	"_flags"
.LASF17:
	.string	"SOCK_SEQPACKET"
.LASF71:
	.string	"_IO_buf_base"
.LASF60:
	.string	"IPPROTO_MAX"
.LASF84:
	.string	"_lock"
.LASF76:
	.string	"_markers"
.LASF66:
	.string	"_IO_read_end"
.LASF46:
	.string	"IPPROTO_DCCP"
.LASF52:
	.string	"IPPROTO_MTP"
.LASF101:
	.string	"charPtr"
.LASF56:
	.string	"IPPROTO_COMP"
.LASF27:
	.string	"sin_family"
.LASF99:
	.string	"fileLen"
.LASF98:
	.string	"argv"
.LASF102:
	.string	"localTxSock"
.LASF105:
	.string	"stderr"
.LASF12:
	.string	"long long int"
.LASF49:
	.string	"IPPROTO_GRE"
.LASF112:
	.string	"memset"
.LASF6:
	.string	"long int"
.LASF14:
	.string	"SOCK_DGRAM"
.LASF81:
	.string	"_cur_column"
.LASF44:
	.string	"IPPROTO_IDP"
.LASF96:
	.string	"_pos"
.LASF29:
	.string	"sin_addr"
.LASF82:
	.string	"_vtable_offset"
.LASF37:
	.string	"IPPROTO_ICMP"
.LASF100:
	.string	"sendDataBuf"
.LASF22:
	.string	"sa_family_t"
.LASF0:
	.string	"unsigned char"
.LASF16:
	.string	"SOCK_RDM"
.LASF97:
	.string	"argc"
.LASF90:
	.string	"__pad5"
.LASF4:
	.string	"signed char"
.LASF30:
	.string	"sin_zero"
.LASF11:
	.string	"long long unsigned int"
.LASF32:
	.string	"uint32_t"
.LASF2:
	.string	"unsigned int"
.LASF93:
	.string	"_IO_marker"
.LASF83:
	.string	"_shortbuf"
.LASF35:
	.string	"s_addr"
.LASF3:
	.string	"long unsigned int"
.LASF8:
	.string	"__off64_t"
.LASF87:
	.string	"__pad2"
.LASF68:
	.string	"_IO_write_base"
.LASF92:
	.string	"_unused2"
.LASF65:
	.string	"_IO_read_ptr"
.LASF24:
	.string	"sa_data"
.LASF72:
	.string	"_IO_buf_end"
.LASF39:
	.string	"IPPROTO_IPIP"
.LASF103:
	.string	"groupAddr"
.LASF57:
	.string	"IPPROTO_SCTP"
.LASF9:
	.string	"char"
.LASF31:
	.string	"uint16_t"
.LASF111:
	.string	"main"
.LASF94:
	.string	"_next"
.LASF86:
	.string	"__pad1"
.LASF41:
	.string	"IPPROTO_EGP"
.LASF88:
	.string	"__pad3"
.LASF89:
	.string	"__pad4"
.LASF33:
	.string	"in_addr_t"
.LASF38:
	.string	"IPPROTO_IGMP"
.LASF109:
	.string	"__socket_type"
.LASF15:
	.string	"SOCK_RAW"
.LASF20:
	.string	"SOCK_CLOEXEC"
.LASF107:
	.string	"dgramTransmit.c"
.LASF59:
	.string	"IPPROTO_RAW"
.LASF106:
	.string	"GNU C 4.4.7 20120313 (Red Hat 4.4.7-18)"
.LASF34:
	.string	"in_addr"
.LASF70:
	.string	"_IO_write_end"
.LASF19:
	.string	"SOCK_PACKET"
.LASF78:
	.string	"_fileno"
.LASF1:
	.string	"short unsigned int"
.LASF77:
	.string	"_chain"
.LASF28:
	.string	"sin_port"
.LASF7:
	.string	"__off_t"
.LASF63:
	.string	"_IO_FILE"
.LASF54:
	.string	"IPPROTO_ENCAP"
.LASF74:
	.string	"_IO_backup_base"
.LASF61:
	.string	"in_port_t"
.LASF79:
	.string	"_flags2"
.LASF23:
	.string	"sa_family"
.LASF91:
	.string	"_mode"
.LASF67:
	.string	"_IO_read_base"
.LASF40:
	.string	"IPPROTO_TCP"
.LASF50:
	.string	"IPPROTO_ESP"
.LASF13:
	.string	"SOCK_STREAM"
.LASF73:
	.string	"_IO_save_base"
.LASF62:
	.string	"FILE"
.LASF55:
	.string	"IPPROTO_PIM"
.LASF95:
	.string	"_sbuf"
.LASF47:
	.string	"IPPROTO_IPV6"
.LASF51:
	.string	"IPPROTO_AH"
.LASF26:
	.string	"sockaddr_in"
.LASF25:
	.string	"sockaddr"
.LASF110:
	.string	"_IO_lock_t"
.LASF21:
	.string	"SOCK_NONBLOCK"
	.ident	"GCC: (GNU) 4.4.7 20120313 (Red Hat 4.4.7-18)"
	.section	.note.GNU-stack,"",@progbits

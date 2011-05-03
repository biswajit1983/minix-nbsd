# Makefile fragment to use Ack compiler (16-bit i86 target)
ARCH=	i86
LIBDIR=	/usr/lib/i86	# force

CC:=${CC:C/.*[gp]cc/cc/:C/clang/cc/}
AR=aal
COMPILER_TYPE=ack
NBSD_LIBC=no
OBJECT_FMT=a.out
CPPFLAGS+=	-mi86
AFLAGS+=	-mi86
LDFLAGS+=	-mi86 -.o -com	# no crtso, common I+D
NBSD_LIBC:=no

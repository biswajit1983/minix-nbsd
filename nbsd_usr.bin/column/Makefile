#	$NetBSD: Makefile,v 1.7 2009/04/14 22:15:18 lukem Exp $
#	@(#)Makefile	8.1 (Berkeley) 6/6/93

.if defined(__MINIX)
.include "../minix-config.inc"

.endif

PROG=	column

.if defined(__MINIX)
LIBUTIL=	/usr/lib/libutil.a
CPPFLAGS+=	-D_MINIX_LIBUTIL -w
.endif
LDADD+=-lutil
DPADD+=${LIBUTIL}

.include <bsd.prog.mk>

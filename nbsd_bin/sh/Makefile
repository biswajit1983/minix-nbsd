#	$NetBSD: Makefile,v 1.94 2010/08/30 06:26:59 christos Exp $
#	@(#)Makefile	8.4 (Berkeley) 5/5/95

.if defined(__MINIX)
.include "../minix-config.inc"
USETOOLS = no
.endif

.include <bsd.own.mk>

YHEADER=1
PROG=	sh
SHSRCS=	alias.c cd.c echo.c error.c eval.c exec.c expand.c \
	histedit.c input.c jobs.c mail.c main.c memalloc.c miscbltin.c \
	mystring.c options.c parser.c redir.c show.c trap.c output.c var.c \
	test.c kill.c syntax.c
GENSRCS=arith.c arith_lex.c builtins.c init.c nodes.c
GENHDRS=arith.h builtins.h nodes.h token.h
SRCS=	${SHSRCS} ${GENSRCS}

DPSRCS+=${GENHDRS}

.if defined(__MINIX)
.if !exists(${LIBDIR}/libterminfo.a)
LIBTERMINFO=	/usr/lib/libterminfo.a
.endif
.if !exists(${LIBDIR}/libedit.a)
LIBTERMINFO=	/usr/lib/libedit.a
.endif
.if !exists(${LIBDIR}/libl.a)
LIBTERMINFO=	/usr/lib/libl.a
.endif
.endif
 
LDADD+=	-ll -ledit -lterminfo
DPADD+=	${LIBL} ${LIBEDIT} ${LIBTERMINFO}

LFLAGS=	-8	# 8-bit lex scanner for arithmetic

# Environment for scripts executed during build.
SCRIPT_ENV= \
	AWK=${TOOL_AWK:Q} \
	SED=${TOOL_SED:Q}

# The .depend file can get references to these temporary files
.OPTIONAL: lex.yy.c y.tab.c

.ifdef CRUNCHEDPROG
LFLAGS+=-L
YFLAGS+=-l
.endif

CPPFLAGS+=-DSHELL -I. -I${.CURDIR}
#XXX: For testing only.
#CPPFLAGS+=-DDEBUG=2
#COPTS+=-g
#CFLAGS+=-funsigned-char
#TARGET_CHARFLAG?= -DTARGET_CHAR="unsigned char" -funsigned-char

.ifdef SMALLPROG
CPPFLAGS+=-DSMALL
.else
SRCS+=printf.c
.endif

.if defined(__MINIX)
.PATH:	${.CURDIR}/bltin ${NETBSDSRCDIR}/nbsd_bin/test \
	${NETBSDSRCDIR}/nbsd_usr.bin/printf \
	${NETBSDSRCDIR}/nbsd_bin/kill
.else
.PATH:	${.CURDIR}/bltin ${NETBSDSRCDIR}/bin/test \
	${NETBSDSRCDIR}/usr.bin/printf \
	${NETBSDSRCDIR}/bin/kill
.endif

CLEANFILES+= ${GENSRCS} ${GENHDRS} y.tab.h
CLEANFILES+= trace

token.h: mktokens
	${_MKTARGET_CREATE}
	${SCRIPT_ENV} ${HOST_SH} ${.ALLSRC}

.ORDER: builtins.h builtins.c
builtins.h builtins.c: mkbuiltins shell.h builtins.def
	${_MKTARGET_CREATE}
	${SCRIPT_ENV} ${HOST_SH} ${.ALLSRC} ${.OBJDIR}
	[ -f builtins.h ]

init.c: mkinit.sh ${SHSRCS}
	${_MKTARGET_CREATE}
	${SCRIPT_ENV} ${HOST_SH} ${.ALLSRC}

.ORDER: nodes.h nodes.c
nodes.c nodes.h: mknodes.sh nodetypes nodes.c.pat
	${_MKTARGET_CREATE}
	${SCRIPT_ENV} ${HOST_SH} ${.ALLSRC} ${.OBJDIR}
	[ -f nodes.h ]

.if ${USETOOLS} == "yes"
COMPATOBJDIR!=	cd ${NETBSDSRCDIR}/tools/compat && ${PRINTOBJDIR}
NBCOMPATLIB=	-L${COMPATOBJDIR} -lnbcompat
.endif

.if !defined(__MINIX)
.if make(install)
SUBDIR+=USD.doc
.endif
.endif

.include <bsd.prog.mk>
.include <bsd.subdir.mk>

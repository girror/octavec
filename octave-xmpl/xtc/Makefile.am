include $(top_srcdir)/Makefile.xt
include $(top_srcdir)/Makefile.octave-front

bin_PROGRAMS   = octave-xmpl
SCFLAGS        = --main io-`basename $*` -O 2
STRINCLUDES    = -I $(XTC)/share/xtc

EXTRA_DIST     = $(wildcard *.str) $(wildcard *.meta)
CLEANFILES     = $(wildcard *.str=.c) $(wildcard *.str=.c.dep) 
BOOTCLEANFILES = $(wildcard *.c) 

octave_xmpl_LDADD = $(LDADD)
nodist_octave_xmpl_SOURCES = octave-xmpl.c

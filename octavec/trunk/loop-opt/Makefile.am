include $(top_srcdir)/Makefile.xt
include $(top_srcdir)/Makefile.octave

SCFLAGS         = --main io-`basename $*` -O 2 --C-include "\"parse-octave.h\"" --format-check 0 --statistics 2 -I ../src 

libexec_PROGRAMS = \
	Octave-IVS \
	Octave-Loop-Forward-Subst \
	Octave-Normalize-Loop \
	Octave-Vectorize

Octave_IVS_LDADD                = $(LDADD) ../src/liboctavec.la 
nodist_Octave_IVS_SOURCES = Octave-IVS.c

Octave_Loop_Forward_Subst_LDADD                = $(LDADD) ../src/liboctavec.la 
nodist_Octave_Loop_Forward_Subst_SOURCES = Octave-Loop-Forward-Subst.c

Octave_Normalize_Loop_LDADD                = $(LDADD) ../src/liboctavec.la 
nodist_Octave_Normalize_Loop_SOURCES = Octave-Normalize-Loop.c

Octave_Vectorize_LDADD                = $(LDADD) ../src/liboctavec.la 
nodist_Octave_Vectorize_SOURCES = Octave-Vectorize.c

STRINCLUDES = -I $(top_srcdir)/syntax -I . -I ../src

EXTRA_DIST = $(pkgdata_DATA) $(wildcard *.str) $(wildcard *.meta)
CLEANFILES = $(wildcard *.dep) $(wildcard *.c) 



include $(top_srcdir)/Makefile.xt
include $(wildcard *.dep)
 
LDADD += $(SSL_LIBS)
libexec_PROGRAMS    = octave-bench-file gen-all-octave-bench

SCFLAGS         = --main io-$* --dr new
STRINCLUDES     = -I $(OCTAVE_FRONT)/share/octave-front \
                -I $(OCTAVE_FRONT)/share/sdf/octave-front \
		-I ../eval \
		-I ../lib 


 
EXTRA_DIST     = $(wildcard *.str) $(wildcard *.meta) 

CLEANFILES         = $(wildcard *.dep)
BOOTCLEANFILES = $(wildcard *.c)


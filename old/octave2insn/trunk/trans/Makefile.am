include $(top_srcdir)/Makefile.xt
include $(wildcard *.dep)

bin_PROGRAMS 	= Octave2INSN 
SCFLAGS      	= --main $*
STRINCLUDES     = -I $(top_srcdir)/sig \
		  -I $(top_srcdir)/syn \
		  -I $(OCTAVE_FRONT)/share/octave-front \
		  -I $(INSN)/share/insn \
		  -I $(XTC)/share/xtc

EXTRA_DIST	= $(wildcard *.str) $(wildcard *.meta) 
CLEANFILES	= $(wildcard *.dep) 
BOOTCLEANFILES	= $(wildcard *.c)



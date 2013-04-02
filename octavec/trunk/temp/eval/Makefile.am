include $(top_srcdir)/Makefile.xt
include $(top_srcdir)/Makefile.octave
include $(wildcard *.dep)

libexec_PROGRAMS 	= Octave-PE 

STRINCLUDES  	= $(FRONT_STRINCLUDES) $(OPT_STRINCLUDES)

EXTRA_DIST     = $(wildcard *.str) $(wildcard *.meta) $(wildcard *.rtree)

CLEANFILES     = $(wildcard *.dep) 
BOOTCLEANFILES = $(wildcard *.c)


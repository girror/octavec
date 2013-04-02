include $(top_srcdir)/Makefile.xt
include $(wildcard *.dep)
 
TBLS_DEFS      = StrategoOctaveINSN.tbl StrategoOctaveINSN.def
sdfdata_DATA   = $(TBLS_DEFS) $(wildcard *.sdf)
BOOTCLEANFILES = $(TBLS_DEFS)
EXTRA_DIST     = $(sdfdata_DATA)
 
SDFINCLUDES  = -I $(STRATEGO_FRONT)/share/sdf/stratego-front \
               -I $(OCTAVE_FRONT)/share/sdf/octave-front \
               -I $(INSN)/share/sdf/insn

PGEN_FLAGS   = -m $*
include $(top_srcdir)/Makefile.xt



TBLS_DEFS      = INSN.tbl INSN.def StrategoINSN.tbl StrategoINSN.def 

sdfdata_DATA   = $(TBLS_DEFS) $(wildcard *.sdf)
BOOTCLEANFILES = $(TBLS_DEFS)
EXTRA_DIST     = $(sdfdata_DATA)
 
SDFINCLUDES    = -I $(STRATEGO_FRONT)/share/sdf/stratego-front
PGEN_FLAGS     = -m $*
 
# TESTING
 
lang = INSN



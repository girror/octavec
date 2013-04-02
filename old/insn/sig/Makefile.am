include $(top_srcdir)/Makefile.xt
 
SIGS          = INSN.str Insn-Operators.str \
                Insn-Lexicals.str Insn-Literals.str \
                Insn-Whitespace.str Insn-Comment.str \
		Insn-Types.str

MSIGS	= Insn-extra.str
 
pkgdata_DATA   = $(subst .str,.rtree,$(SIGS))  $(MSIGS)
EXTRA_DIST     = $(pkgdata_DATA) $(SIGS) $(wildcard *.str) 
CLEANFILES     = $(wildcard *.def)
BOOTCLEANFILES = $(wildcard *.rtree)
 
INSN.def: $(top_srcdir)/syn/INSN.def
	ln -s $< $@


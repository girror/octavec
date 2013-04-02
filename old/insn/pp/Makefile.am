include $(top_srcdir)/Makefile.xt
 
 
pps            = INSN.pp INSN-pretty.pp

ppafs          = $(subst .pp,.pp.af,$(pps))
 
pkgdata_DATA   = $(ppafs)
EXTRA_DIST     = $(pps) $(ppafs) $(wildcard *.src)
CLEANFILES     = INSN.def
BOOTCLEANFILES = INSN.pp $(ppafs)
 
#check_SCRIPTS   = parse-pp-parse-check
#TESTS          = parse-pp-parse-check
 
INSN.def: $(top_srcdir)/syn/INSN.def
	ln -s $< $@
 
# Generate test-tools
%-check: %-check.src Makefile.am
	sed 's#__XT__#$(prefix)#g;\
             s#__MAKE__#$(MAKE)#g' < $< > $@
	chmod +x $@



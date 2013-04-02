include $(top_srcdir)/Makefile.xt
include $(top_srcdir)/Makefile.octave-front

TESTS = parse-input-check 

EXTRA_DIST = $(wildcard *.tbm) $(wildcard *.m) parse-input-check.src
 
.PRECIOUS: %.abox %.ainput %.txt %.tas %.box %.tree
 
# FILES
 
CLEANFILES = \
        *.abox *.pre-abox *.ainput *.txt *.tas *.box \
        *.tree *.tmp *.pre-tas *~ *.tas.check *.cir *.cir.check \
        *.s *.ir *.ir.check *.ra *.a *.sweettas *.asm *.asm.check *.run *.tccheck
 
# TARGETS

# Generate test-tools
%-check: %-check.src Makefile.am
	sed 's#__XT__#$(prefix)#g;\
	   s#__MAKE__#$(MAKE)#g' < $< > $@
	chmod +x $@
	
	
%.out:%.m Makefile.am
	octavec -i $< --script --opts constant-propagation:partial-evaluation:dead-function-elimination:dead-code-elimination 
	cp `basename $< .m` `basename $< .m`.out
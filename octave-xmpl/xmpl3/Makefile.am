include $(top_srcdir)/Makefile.xt
include $(top_srcdir)/Makefile.octave-front

TESTS = parse-input-check 

EXTRA_DIST = $(wildcard *tb.m) $(wildcard *.m) parse-input-check.src
 
.PRECIOUS: %.abox %.ainput %.txt %.tas %.box %.tree
 
# FILES
  
CLEANFILES = \
	*.txt *.out *.cc

# TARGETS

# Generate test-tools
%-check: %-check.src Makefile.am
	sed 's#__XT__#$(prefix)#g;\
	   s#__MAKE__#$(MAKE)#g' < $< > $@
	chmod +x $@


%.out:%.m Makefile.am
	${OCTAVEC}/bin/octavec -i $< --script --opts constant-propagation:partial-evaluation:dead-function-elimination:dead-code-elimination 
	cp `basename $< .m` `basename $< .m`.out
		
        
%.txt:%.m
	${OCTAVEC}/bin/octavec -i $< --script --opts constant-propagation:copy-propagation:common-subexpression-elimination:partial-evaluation:dead-function-elimination:dead-code-elimination \
	 --o2o $@
		 
		 
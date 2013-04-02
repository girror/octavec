include $(top_srcdir)/Makefile.xt
include $(top_srcdir)/Makefile.octave-front

TESTS = parse-input-check 

EXTRA_DIST = $(wildcard *.tbm) $(wildcard *.m) parse-input-check.src \
	map-main.ast ofdm-main.ast 
 
#.PRECIOUS: %.abox %.ainput %.txt %.tas %.box %.tree
 
# FILES
  
CLEANFILES =  *.tmp 
 
# TARGETS

# Generate test-tools
%-check: %-check.src
	sed 's#__XT__#$(prefix)#g;\
	   s#__MAKE__#$(MAKE)#g' < $< > $@
	chmod +x $@

%.out:%.m Makefile.am
        octavec -i $< --script --opts constant-propagation:partial-evaluation:dead-function-elimination:dead-code-elimination 
        cp `basename $< .m` `basename $< .m`.out
include $(top_srcdir)/Makefile.xt
include $(top_srcdir)/Makefile.octave-front
 
EXTRA_DIST = $(wildcard *.tbm) $(wildcard *.m) demo_head.mpg parse-input-check.src
 
.PRECIOUS: %.abox %.ainput %.txt %.tas %.box %.tree
 
# FILES
 
CLEANFILES = \
        *.abox *.pre-abox *.ainput *.txt *.tas *.box  *.tccheck


 
# TARGETS

# Generate test-tools
%-check: %-check.src Makefile.am
	sed 's#__XT__#$(prefix)#g;\
	   s#__MAKE__#$(MAKE)#g' < $< > $@
	chmod +x $@
include $(top_srcdir)/Makefile.xt
include $(top_srcdir)/Makefile.octave

SCFLAGS = --main io-`basename $*` -O 2 --C-include "\"parse-octave.h\"" --format-check 0 --statistics 2 

pkglib_LTLIBRARIES  = \
	liboctavec.la \
	libo2c.la \
	liboctave-eval.la 

nodist_liboctavec_la_SOURCES  = liboctavec.c
nodist_libo2c_la_SOURCES  = libo2c.c
nodist_liboctave_eval_la_SOURCES  = liboctave-eval.c

octavelib = \
	octave/lang/cons/type-specification.str \
	octave/lang/cons/common.str \
	$(wildcard octave/*.str) \
	$(wildcard octave/general/*.str) \
	$(wildcard octave/lang/eval/*.str) \
	$(wildcard octave/lang/*.str) \
	$(wildcard octave/lang/cons/*.str) \
	$(wildcard octave/lang/type/*.str) \
	$(wildcard octave/interpreter/*.str) \
	$(wildcard octave/o2c/*.str) \
	$(wildcard octave/config/*.str)

extra_octavelib = \
	$(wildcard octave/*.meta) \
	$(wildcard octave/general/*.meta) \
	$(wildcard octave/lang/eval/*.meta) \
	$(wildcard octave/lang/*.meta) \
	$(wildcard octave/lang/cons/*.meta) \
	$(wildcard octave/lang/type/*.meta) \
	$(wildcard octave/interpreter/*.meta) \
	$(wildcard octave/o2c/*.meta) \
	$(wildcard octave/config/*.meta)

STRINCLUDES = -I $(top_srcdir)/syntax -I . 
SDF2RTG_FLAGS = -m `basename $*`

#LDADD      += ./liboctavec.la $(SSL_LIBS)

liboctavec.rtree liboctavec.c : oct.str 
	$(STRC)/bin/strc -c --library \
	  -O 2 --verbose 1 \
	  -i $< -o liboctavec.rtree \
	  --statistics 2 \
	  --format-check 0 \
	  ${STRINCLUDES} && \
	  rm liboctavec.str

libo2c.rtree libo2c.c : o2c.str liboctavec.rtree 
	$(STRC)/bin/strc -c --library \
	  -O 2 --verbose 1 \
	  -i $< -o libo2c.rtree \
	  --statistics 2 \
	  --format-check 0 \
	  ${STRINCLUDES} && \
	rm libo2c.str

liboctave-eval.rtree liboctave-eval.c : octave-eval.str liboctavec.rtree 
	$(STRC)/bin/strc -c --library \
	  -O 2 --verbose 1 \
	  -i $< -o liboctave-eval.rtree \
	  --statistics 2 \
	  --format-check 0 \
	  ${STRINCLUDES}&& \
         rm liboctave-eval.str

#octave/lang/cons/common.def:$(top_srcdir)/syntax/common.def
#	ln -fs ../../../$< $@

#octave/lang/cons/type-specification.def:$(top_srcdir)/syntax/type-specification.def
#	ln -fs ../../../$< $@


EXTRA_DIST = $(octavelib) $(extra_octavelib)  $(nobase_pkgdata_DATA) $(wildcard *.str) 
CLEANFILES = $(octavelib:.str=.rtree) liboctave-eval.rtree liboctave-eval.c libo2c.rtree libo2c.c liboctavec.rtree liboctavec.c

include $(wildcard octave/*.dep)
include $(wildcard *.dep)

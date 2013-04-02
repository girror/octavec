include $(top_srcdir)/Makefile.xt
include $(top_srcdir)/Makefile.octave

include_HEADERS = parse-octave.h

pkglib_LTLIBRARIES = \
  libparseoctave.la   
libparseoctave_la_SOURCES = pt-aterm.cc pt-aterm.h

AM_LDFLAGS += -L${ATERM}/lib -L${OCTAVE}/lib/$(OCTAVE_SUBDIR) -lATerm -loctave -loctinterp \
 -L${OCTAVE}/lib -L${OCTAVE}/libexec/octave/3.0.0
AM_CXXFLAGS = -I${OCTAVE}/include/$(OCTAVE_SUBDIR) -I${OCTAVE}/include/$(OCTAVE_SUBDIR)/octave \
  -I/${OCTAVE}/include

pt-aterm.o : pt-aterm.h pt-aterm.cc
	mkoctfile -I. -DHAVE_CONFIG_H  -c pt-aterm.cc -o pt-aterm.o
pt-aterm : pt-aterm.o
	mkoctfile -I. -DHAVE_CONFIG_H pt-aterm.o -o pt-aterm --link-stand-alone ${LDFLAGS} ${CXXFLAGS}


EXTRA_DIST     = $(wildcard *.h)  


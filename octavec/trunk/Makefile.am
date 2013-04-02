include $(top_srcdir)/Makefile.xt
include $(top_srcdir)/Makefile.octave

SUBDIRS           = syntax src bin loop-opt test 
BOOTCLEAN_SUBDIRS = $(SUBDIRS)
DIST_SUBDIRS      = $(SUBDIRS)

XTC_IMPORT   = $(STRATEGOXT)/share/strategoxt/XTC  

pkgdata_DATA = builtin.ti

install-data-local2::
	$(XTC)/bin/xtc -r $(DREPOSITORY) register -l $(OCTAVE) -t OctavePrefix -V $(OCTAVE_VERSION)
	$(XTC)/bin/xtc -r $(DREPOSITORY) register -l $(OCTAVE)/share/octave -t OctaveLibrary -V $(OCTAVE_VERSION)
	
install-data-hook::	
	$(XTC)/bin/xtc -r $(DREPOSITORY) register -l $(OCTAVE)/bin -t mkoctfile -V $(OCTAVE_VERSION)

EXTRA_DIST = builtin.ti octave.m4

ACLOCAL_AMFLAGS = -I .

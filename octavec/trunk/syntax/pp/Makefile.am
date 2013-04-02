include $(top_srcdir)/Makefile.xt

pps            = Octave-pretty.pp RealOctave-pretty.pp C-pretty1.pp
ppafs          = $(subst .pp,.pp.af,$(pps))
   
pkgdata_DATA   = $(ppafs)

EXTRA_DIST     = $(pps) 
CLEANFILES     = Octave.def
BOOTCLEANFILES = Octave.pp $(ppafs)

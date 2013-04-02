include $(top_srcdir)/Makefile.xt
include $(top_srcdir)/Makefile.octave
include $(wildcard *.dep)

SUBDIRS           = pp libparseoctave
BOOTCLEAN_SUBDIRS = $(SUBDIRS)

TBLS_DEFS      = \
	StrategoOctaveCS.tbl \
	type-specification.tbl \
	Stratego-Octave-C.tbl \
	Octave-Concrete-Syntax.tbl \
	Octave-Concrete-SyntaxRenamed.tbl

sdfdata_DATA   = \
  Octave-Concrete-SyntaxRenamed.def \
  Octave-Concrete-SyntaxRenamed.sdf \
  common.def \
  $(TBLS_DEFS) \
  $(wildcard *.sdf) \
  Octave-Concrete-Syntax.def 


BOOTCLEANFILES = $(TBLS_DEFS)
EXTRA_DIST     = \
  $(wildcard *.sdf)
 
SDFINCLUDES    = \
	-I $(STRATEGO_FRONT)/share/sdf/stratego-front \
	-I $(C_TOOLS)/share/sdf/c-tools
	
PGEN_FLAGS     = -m $*

Octave-Concrete-SyntaxRenamed.sdf: Octave-Concrete-Syntax.def
	$(SDF_TOOLS)/bin/gen-renamed-sdf-module -i Octave-Concrete-Syntax.def -o Octave-Concrete-SyntaxRenamed.sdf --main Octave-Concrete-Syntax --name Octave-Concrete-SyntaxRenamed --prefix Octave
	

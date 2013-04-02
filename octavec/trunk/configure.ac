AC_PREREQ(2.58)
AC_INIT([octavec],[0.1],[stratego-bugs@cs.uu.nl])
AC_CONFIG_AUX_DIR([config])
AM_INIT_AUTOMAKE([1.7.2 -Wall -Wno-portability])

m4_pattern_forbid([^(AB|XT)_])
m4_pattern_forbid([^PKG_CHECK_MODULES$])

AC_CONFIG_HEADERS([config.h])

XT_SETUP
XT_PRE_RELEASE
XT_SVN_REVISION
XT_USE_XT_PACKAGES 
# XT_TERM_DEFINE
XT_PKG_ATERM
XT_PKG_SDF
XT_PKG_STRATEGOXT

XT_USE_OCTAVE

AC_PROG_LIBTOOL
AC_PROG_CC
AC_PROG_CXX
AC_PROG_LEX
AC_PROG_YACC
AC_PROG_INSTALL

for dir in $OCTAVE/lib/octave-*
do
  OCTAVE_SUBDIR=$(basename $dir)
done
AC_SUBST([OCTAVE_SUBDIR])

AC_CONFIG_FILES([
  Makefile

  syntax/Makefile
  syntax/pp/Makefile
  syntax/libparseoctave/Makefile

  src/Makefile
  bin/Makefile

  loop-opt/Makefile
  test/Makefile
])
AC_OUTPUT

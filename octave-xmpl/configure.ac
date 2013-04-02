AC_PREREQ(2.58)
AC_INIT([octave-xmpl],[0.1],[stratego-bugs@cs.uu.nl])
AC_CONFIG_AUX_DIR([config])
AM_INIT_AUTOMAKE([1.7.2 -Wall -Wno-portability])

m4_pattern_forbid([^(AB|XT)_])
m4_pattern_forbid([^PKG_CHECK_MODULES$])

XT_SETUP
XT_PRE_RELEASE
XT_SVN_REVISION
XT_USE_XT_PACKAGES
XT_PKG_ATERM
XT_PKG_SDF
XT_PKG_STRATEGOXT

XT_USE_OCTAVE
AC_ARG_WITH(octavec,
  AC_HELP_STRING([--with-octavec=DIR], [use octavec compiler at DIR @<:@prefix@:>@]),
  OCTAVEC="$withval",
  OCTAVEC="$prefix"
)

AC_SUBST(OCTAVEC)

//AC_PROG_LIBTOOL
AC_PROG_CC
AC_PROG_CXX
AC_PROG_INSTALL


AC_CONFIG_FILES([
    Makefile
    xmpl/Makefile
    xmpl2/Makefile
    xmpl3/Makefile
    mat2c-benchmark/Makefile 
    xtc/Makefile
])
AC_OUTPUT

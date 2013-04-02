#                                                       -*- Autoconf -*-
# serial 2
#
# Author: Martin Bravenboer


# XT_USE_OCTAVE
# --------------
AC_DEFUN([XT_USE_OCTAVE], [
  AC_REQUIRE([AC_PROG_CC])

  AC_ARG_WITH([octave],
    AS_HELP_STRING([--octave=DIR],
                   [use Octave at DIR]),
    [OCTAVE=$withval],
    [OCTAVE="none"]
  )

  if test "$OCTAVE" = "none"; then
    AC_PATH_PROG([OCTAVEI],[octave],[none])

    if test "$OCTAVEI" = "none"; then
      AC_MSG_ERROR([octave is required. Make sure it is on the path or specify a prefix --with-octave])
    fi

    OCTAVE="$(dirname $(dirname $OCTAVEI))"
  else
    OCTAVEI=$OCTAVE/bin/octave$EXEEXT

    AC_MSG_CHECKING([for octave at $OCTAVEI])
    test -x "$OCTAVEI"
    if test $? -eq 0; then
      AC_MSG_RESULT([yes])
    else
      AC_MSG_RESULT([no])
      AC_MSG_ERROR([cannot find octave. Please check the path you specified --with-octave.])
    fi
  fi

  AC_SUBST([OCTAVE])
])

CC=/home/cygwin/cegcc/bin/arm-mingw32ce-gcc
CXX=/home/cygwin/cegcc/bin/arm-mingw32ce-g++
LD=/home/cygwin/cegcc/bin/arm-mingw32ce-ld
AR=/home/cygwin/cegcc/bin/arm-mingw32ce-ar
RANLIB=/home/cygwin/cegcc/bin/arm-mingw32ce-ranlib
STRIP=/home/cygwin/cegcc/bin/arm-mingw32ce-strip
WINDRES=/home/cygwin/cegcc/bin/arm-mingw32ce-windres
AS=/home/cygwin/cegcc/bin/arm-mingw32ce-as
DLLTOOL=/home/cygwin/cegcc/bin/arm-mingw32ce-dlltool
OBJDUMP=/home/cygwin/cegcc/bin/arm-mingw32ce-objdump
NM=/home/cygwin/cegcc/bin/arm-mingw32ce-nm
#! /bin/sh

srcdir=`dirname $0`
test -z "$srcdir" && srcdir=.

ORIGDIR=`pwd`
cd $srcdir

autoreconf -v --install || exit 1
cd $ORIGDIR || exit $?

if test -z "$NOCONFIGURE"; then
    $srcdir/configure "$@"
fi

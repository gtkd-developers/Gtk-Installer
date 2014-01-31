#!/bin/bash

cd `basename ${0:0:${#0}-3}`

PKGNAME=zlib-1.2.8

function build {
	make CC=$1 AR=$2 RC=$3 STRIP=$4 || exit $?
	make install \
		DESTDIR=$DESTDIR \
		INCLUDE_PATH=$prefix/include \
		LIBRARY_PATH=$prefix/lib \
		BINARY_PATH=$prefix/bin \
		SHARED_MODE=1 || exit $?

	make clean || exit $?
}

case "$1" in
	"prepare" )
		#wget http://zlib.net/$PKGNAME.tar.gz
		shasum -c checksum || exit $?

		tar -xf $PKGNAME.tar.gz
		cd $PKGNAME

		cp win32/Makefile.gcc MakeFile
		cd ..
	;;
	"build32" )
		cd $PKGNAME
		build i686-w64-mingw32-gcc ar windres strip
		cd ..
	;;
	"build64" )
		cd $PKGNAME
		build x86_64-w64-mingw32-gcc x86_64-w64-mingw32-ar x86_64-w64-mingw32-windres x86_64-w64-mingw32-strip
		cd ..
	;;
	"clean" )
		rm -rf $PKGNAME
		rm -rf $PKGNAME.tar.gz
	;;
esac
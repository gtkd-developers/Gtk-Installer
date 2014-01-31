#!/bin/bash

cd `basename ${0:0:${#0}-3}`

PKGNAME=fontconfig-2.11.0
export FREETYPE_CFLAGS=-I$DESTDIR$prefix/include/freetype2

function build {
	../configure --host=$1 --prefix=$prefix --enable-iconv --enable-libxml2 || exit $?

	make || exit $?
	make install DESTDIR=$DESTDIR || exit $?
	make install-pkgconfigDATA DESTDIR=$DESTDIR || exit $?

	rm $DESTDIR$prefix/lib/*.la
	rm -r "$DESTDIR"WINDOWSTEMPDIR_FONTCONFIG_CACHE
}

case "$1" in
	"prepare" )
		#wget http://www.fontconfig.org/release/$PKGNAME.tar.bz2
		shasum -c checksum || exit $?

		tar -xf $PKGNAME.tar.bz2
		cd $PKGNAME
		
		patch -p1 -i ../fontconfig-disable-migration-testcase-on-win32.patch
		patch -p1 -i ../fontconig-missing-destdir-conf.d.patch
		
		cd ..
	;;
	"build32" )
		cd $PKGNAME
		mkdir build32
		cd build32
		
		build i686-w64-mingw32
		
		cd ..
		rm -rf build32
		cd ..
	;;
	"build64" )
		cd $PKGNAME
		mkdir build64
		cd build64
		
		build x86_64-w64-mingw32
		
		cd ..
		rm -rf build64
		cd ..
	;;
	"clean" )
		rm -rf $PKGNAME
		rm -rf $PKGNAME.tar.bz2
	;;
esac
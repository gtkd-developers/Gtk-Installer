#!/bin/bash

cd `basename ${0:0:${#0}-3}`

PKGNAME=pkg-config-0.27.1
export GLIB_CFLAGS="-I$DESTDIR$prefix/include/glib-2.0 -I$DESTDIR$prefix/lib/glib-2.0/include"
export GLIB_LIBS=-lglib-2.0

function build {
	../configure --host=$1 --prefix=$prefix || exit $?
	make || exit $?
	make install DESTDIR=$DESTDIR || exit $?
}

case "$1" in
	"prepare" )
		#wget http://pkgconfig.freedesktop.org/releases/$PKGNAME.tar.gz
		shasum -c checksum || exit $?

		tar -xf $PKGNAME.tar.gz
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
		rm -rf $PKGNAME.tar.gz
	;;
esac
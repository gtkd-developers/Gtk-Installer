#!/bin/bash

cd `basename ${0:0:${#0}-3}`

PKGNAME=pixman-0.32.4

function build {
	../configure --host=$1 --prefix=$prefix || exit $?
	make || exit $?
	make install DESTDIR=$DESTDIR || exit $?
	rm $DESTDIR$prefix/lib/*.la
}

case "$1" in
	"prepare" )
		#wget http://xorg.freedesktop.org/releases/individual/lib/$PKGNAME.tar.bz2
		shasum -c checksum || exit $?

		tar -xf $PKGNAME.tar.bz2
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
#!/bin/bash

cd `basename ${0:0:${#0}-3}`

PKGNAME=tiff-4.0.3

function build {
	../configure --host=$1 --prefix=$prefix --enable-shared --enable-static || exit $?
	make || exit $?
	make install DESTDIR=$DESTDIR || exit $?
	rm $DESTDIR$prefix/lib/*.la
}

case "$1" in
	"prepare" )
		#wget http://download.osgeo.org/libtiff/$PKGNAME.tar.gz
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
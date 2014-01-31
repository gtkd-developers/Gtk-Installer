#!/bin/bash

cd `basename ${0:0:${#0}-3}`

PKGNAME=freetype-2.5.2

function build {
	../configure --host=$1 --prefix=$prefix || exit $?
	make || exit $?
	make install DESTDIR=$DESTDIR || exit $?
	rm $DESTDIR$prefix/lib/*.la
}

case "$1" in
	"prepare" )
		#wget http://download.savannah.gnu.org/releases/freetype/$PKGNAME.tar.gz
		shasum -c checksum || exit $?

		tar -xf $PKGNAME.tar.gz
		cd $PKGNAME

		patch -Np1 -i "../freetype-2.2.1-enable-valid.patch"
		patch -Np1 -i "../freetype-2.5.1-enable-spr.patch"
		#patch -Np1 -i "../freetype-2.5.1-enable-sph.patch"
		
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
		rm -rf $PKGNAME.tar.gz
	;;
esac
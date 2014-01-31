#!/bin/bash

cd `basename ${0:0:${#0}-3}`

PKGNAME=libpng-1.6.7

function build {
	../configure --host=$1 --prefix=$prefix || exit $?
	make || exit $?
	make install DESTDIR=$DESTDIR || exit $?
	rm $DESTDIR$prefix/lib/*.la
}

case "$1" in
	"prepare" )
		#wget http://downloads.sourceforge.net/sourceforge/libpng/$PKGNAME.tar.xz
		#wget http://downloads.sourceforge.net/sourceforge/libpng-apng/$PKGNAME-apng.patch.gz
		shasum -c checksum || exit $?

		tar -xf $PKGNAME.tar.xz
		gzip -d -f -c $PKGNAME-apng.patch.gz > $PKGNAME-apng.patch

		cd $PKGNAME

		patch -p1 -i "../$PKGNAME-apng.patch"
		
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
		rm -rf $PKGNAME.tar.xz
		rm -rf $PKGNAME-apng.patch
		rm -rf $PKGNAME-apng.patch.gz
	;;
esac
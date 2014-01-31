#!/bin/bash

cd `basename ${0:0:${#0}-3}`

PKGNAME=libjpeg-turbo-1.3.0

function build {
	../configure --host=$1 --prefix=$prefix --mandir=$prefix/share/man || exit $?
	make || exit $?
	make install DESTDIR=$DESTDIR || exit $?
	rm $DESTDIR$prefix/lib/*.la
}

case "$1" in
	"prepare" )
		#wget http://downloads.sourceforge.net/libjpeg-turbo/$PKGNAME.tar.gz
		shasum -c checksum || exit $?

		tar -xf $PKGNAME.tar.gz

		cd $PKGNAME

		patch -p1 -i ../libjpeg-turbo-match-autoconf-behavior.patch
		patch -p0 -i ../temp-fix-for-poppler.patch
		
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
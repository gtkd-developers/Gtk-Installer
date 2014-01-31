#!/bin/bash

cd `basename ${0:0:${#0}-3}`

PKGNAME=libiconv-1.14

function build {
	../configure --disable-nls --enable-shared --enable-static --host=$1 --prefix=$prefix || exit $?
	make || exit $?
	make install DESTDIR=$DESTDIR || exit $?
	rm $DESTDIR$prefix/lib/*.la
}

case "$1" in
	"prepare" )
		#wget http://ftp.gnu.org/pub/gnu/libiconv/$PKGNAME.tar.gz
		shasum -c checksum || exit $?

		tar -xf $PKGNAME.tar.gz
		cd $PKGNAME

		patch -p2 -i ../00-wchar-libiconv-1.14.patch
		patch -p2 -i ../01-reloc-libiconv-1.14.patch
		patch -p2 -i ../02-reloc-libiconv-1.14.patch
		patch -p2 -i ../03-cygwin-libiconv-1.14.patch
		patch -p2 -i ../libiconv-1.14-2.src.patch
		
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
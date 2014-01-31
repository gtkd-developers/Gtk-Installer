#!/bin/bash

cd `basename ${0:0:${#0}-3}`

PKGNAME=libxml2-2.9.1

function build {
	../configure --host=$1 --prefix=$prefix --without-python || exit $?
	make || exit $?
	make install DESTDIR=$DESTDIR || exit $?
	rm $DESTDIR$prefix/lib/*.la
}

case "$1" in
	"prepare" )
		#wget http://xmlsoft.org/sources/$PKGNAME.tar.gz
		shasum -c checksum || exit $?

		tar -xf $PKGNAME.tar.gz
		cd $PKGNAME

		patch -Np0 -i ../mingw32-libxml2-static-build-compile-fix.patch
		patch -Np1 -i ../libxml2-no-test.patch
		sed -i "s| doc example | |g" Makefile.am
		sed -i "s|LIBXML_STATIC|_WIN32|g" include/libxml/xmlexports.h
		
		cd ..
	;;
	"build32" )
		cd $PKGNAME
		autoreconf --force --install -Wno-portability -I$DESTDIR$prefix/share/aclocal
		mkdir build32
		cd build32
		
		build i686-w64-mingw32
		
		cd ..
		rm -rf build32
		cd ..
	;;
	"build64" )
		cd $PKGNAME
		autoreconf --force --install -Wno-portability -I$DESTDIR$prefix/share/aclocal
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
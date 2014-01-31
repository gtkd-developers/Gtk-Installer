#!/bin/bash

cd `basename ${0:0:${#0}-3}`

PKGNAME=cairo-1.12.16

function build {
	../configure \
		  --host=$1 \
		  --prefix=$prefix \
		  --enable-win32 \
		  --enable-win32-font \
		  --enable-png \
		  --enable-shared \
		  --enable-static \
		  --enable-gobject \
		  --enable-tee \
		  --disable-xlib \
		  --disable-xcb \
		  --enable-fc \
		  --enable-ft \
		  --disable-gtk-doc-html || exit $?
	make || exit $?
	make install DESTDIR=$DESTDIR || exit $?
	rm $DESTDIR$prefix/lib/*.la
}

case "$1" in
	"prepare" )
		#wget http://cairographics.org/releases/$PKGNAME.tar.xz
		shasum -c checksum || exit $?

		tar -xf $PKGNAME.tar.xz
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
	;;
esac
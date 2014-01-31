#!/bin/bash

cd `basename ${0:0:${#0}-3}`

PKGNAME=glib-2.38.2
export LIBFFI_CFLAGS=-I"$DESTDIR$prefix/lib/libffi-3.0.13/include"
export LIBFFI_LIBS=-lffi

function build {
	../configure --enable-shared --with-pcre=internal --host=$1 --prefix=$prefix || exit $?
	make || exit $?
	make install DESTDIR=$DESTDIR || exit $?
	rm $DESTDIR$prefix/lib/*.la
}

case "$1" in
	"prepare" )
		#wget http://ftp.acc.umu.se/pub/GNOME/sources/glib/2.38/$PKGNAME.tar.xz
		shasum -c checksum || exit $?

		tar -xf $PKGNAME.tar.xz
		cd $PKGNAME

		patch -Np1 -i ../0001-Use-CreateFile-on-Win32-to-make-sure-g_unlink-always.patch
		patch -Np0 -i ../glib-send-log-messages-to-correct-stdout-and-stderr.patch
		patch -Np1 -i ../glib-prefer-constructors-over-DllMain.patch
		
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
	;;
esac
#!/bin/bash

cd `basename ${0:0:${#0}-3}`

PKGNAME=gtk+-3.10.6

function build {
	mkdir -p $DESTDIR$prefix/lib/gdbus-2.0
	cp -R $DESTDIR$prefix/share/glib-2.0/codegen/ $DESTDIR$prefix/lib/gdbus-2.0/

	export CC_FOR_BUILD="$1-gcc"
	export CPP_FOR_BUILD="$1-gcc -E"
	
	../configure --host=$1 --prefix=$prefix --enable-win32-backend --with-included-immodules || exit $?

	sed -i "s| widget-factory | |g" demos/Makefile
	sed -i "s| examples||g" Makefile

	make || exit $?
	make install DESTDIR=$DESTDIR || exit $?
	
	cp ../../settings.ini $DESTDIR$prefix/etc/gtk-3.0/ || exit $?
	glib-compile-schemas $DESTDIR$prefix/share/glib-2.0/schemas/ || exit $?

	rm $DESTDIR$prefix/lib/*.la
	rm -rf $DESTDIR$prefix/lib/gdbus-2.0
}

case "$1" in
	"prepare" )
		#wget http://ftp.gnome.org/pub/gnome/sources/gtk+/3.10/$PKGNAME.tar.xz
		shasum -c checksum || exit $?

		tar -xf $PKGNAME.tar.xz
		cd $PKGNAME

		patch -Np1 < "../0004-BURN-THE-.DEF.patch"
		patch -Np1 < "../0005-Remove-gobject-introspection.patch"
		patch -Np0 < "../Bug-691678-draw-notebook-tabs-correctly.patch"
		
		cd ..
	;;
	"build32" )
		cd $PKGNAME
		autoreconf -is --force -Wno-portability -I$DESTDIR$prefix/share/aclocal
		mkdir build32
		cd build32
		
		build i686-w64-mingw32
		
		cd ..
		rm -rf build32
		cd ..
	;;
	"build64" )
		cd $PKGNAME
		autoreconf -is --force -Wno-portability -I$DESTDIR$prefix/share/aclocal
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
#!/bin/bash

cd `basename ${0:0:${#0}-3}`

PKGNAME=gdk-pixbuf-2.30.2

function build {
	../configure \
		  --host=$1 \
		  --prefix=$prefix \
		  --with-libjasper \
		  --with-included-loaders=wbmp,png,pnm,ras,ani,xpm,xbm,tga,icns,pcx,qtif,gdip-ico,gdip-wmf,gdip-emf,gdip-bmp,gdip-gif,gdip-jpeg,gdip-tiff,jasper || exit $?
	make || exit $?
	make install DESTDIR=$DESTDIR || exit $?
	rm $DESTDIR$prefix/lib/*.la
}

case "$1" in
	"prepare" )
		#wget http://ftp.gnome.org/pub/gnome/sources/gdk-pixbuf/2.30/$PKGNAME.tar.xz
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
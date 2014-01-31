#!/bin/bash

cd `basename ${0:0:${#0}-3}`

function build {
	../configure --prefix=$prefix --enable-win32-backend --enable-shared --disable-static --disable-gtk-doc-html --disable-introspection --host=$1 || exit $?
	echo "all:" > examples/Makefile
	echo "install-exec:" >> examples/Makefile
	make || exit $?
	make install-exec DESTDIR=$DESTDIR || exit $?
}

case "$1" in
	"prepare" )
		#wget --no-check-certificate https://github.com/tdz/gtkglext/archive/master.zip
		shasum -c checksum || exit $?
		unzip master
	;;
	"build32" )
		cd gtkglext-master
		autoreconf -is --force -Wno-portability -I$DESTDIR$prefix/share/aclocal -I`pwd`/../aclocal
		mkdir build32
		cd build32
		
		build i686-w64-mingw32
		
		cd ..
		rm -rf build32
		cd ..
	;;
	"build64" )
		cd gtkglext-master
		autoreconf -is --force -Wno-portability -I$DESTDIR$prefix/share/aclocal -I`pwd`/../aclocal
		mkdir build64
		cd build64
		
		build x86_64-w64-mingw32
		
		cd ..
		rm -rf build64
		cd ..
	;;
	"clean" )
		rm -rf gtkglext-master
		rm -rf master.zip
	;;
esac
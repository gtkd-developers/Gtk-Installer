#!/bin/bash

cd `basename ${0:0:${#0}-3}`

PKGNAME=termcap-1.3.1

function build {
	../configure --host=$1 --prefix=$prefix || exit $?
	
	make || exit $?
	#$1-gcc -shared \
	#	-Wl,--out-implib,libtermcap.dll.a \
	#	-o libtermcap-0.dll \
	#	termcap.o tparam.o version.o

	make install prefix=$DESTDIR$prefix infodir=$DESTDIR$prefix/share/info || exit $?
	#install -m 0755 libtermcap-0.dll "$DESTDIR$prefix/bin"
    #install -m 0755 libtermcap.dll.a "$DESTDIR$prefix/lib"
}

case "$1" in
	"prepare" )
		#wget http://ftp.gnu.org/gnu/termcap/$PKGNAME.tar.gz
		shasum -c checksum || exit $?

		tar -xf $PKGNAME.tar.gz
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
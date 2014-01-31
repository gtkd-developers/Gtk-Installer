#!/bin/bash

cd `basename ${0:0:${#0}-3}`

PKGNAME=gettext-0.18.3.1

function build {
	export CFLAGS="$CFLAGS -O2" 
	export CXXFLAGS="$CXXFLAGS -O2" 
		
	../configure \
		  --host=$1 \
		  --prefix=$prefix \
		  --disable-silet-rules \
		  --disable-java \
		  --disable-native-java \
		  --disable-csharp \
		  --enable-static \
		  --enable-threads=win32 \
		  --without-emacs \
		  --disable-openmp || exit $?
	make || exit $?
	make install DESTDIR=$DESTDIR || exit $?
	rm $DESTDIR$prefix/lib/*.la
}

case "$1" in
	"prepare" )
		#wget http://ftp.gnu.org/pub/gnu/gettext/$PKGNAME.tar.gz
		shasum -c checksum || exit $?

		tar -xf $PKGNAME.tar.gz
		
		cd $PKGNAME
	
		sed -i "s|@REPLACE_TOWLOWER@|0|g" gettext-runtime/gnulib-lib/wctype.in.h
		@REPLACE_TOWLOWER@
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
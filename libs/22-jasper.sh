#!/bin/bash

cd `basename ${0:0:${#0}-3}`

PKGNAME=jasper-1.900.1

case "$1" in
	"prepare" )
		#wget http://www.ece.uvic.ca/~mdadams/jasper/software/$PKGNAME.zip
		shasum -c checksum || exit $?

		unzip $PKGNAME.zip
		cd $PKGNAME

		patch -p1 -i "../jpc_dec.c.patch"
		patch -p1 -i "../patch-libjasper-stepsizes-overflow.diff"
		patch -p1 -i "../jasper-1.900.1-CVE-2008-3520.patch"
		patch -p1 -i "../jasper-1.900.1-CVE-2008-3522.patch"
		patch -p1 -i "../jasper-1.900.1-mingw32.patch"
		
		cd ..
	;;
	"build32" )
		cd $PKGNAME
		mkdir build32
		cd build32

		../configure \
			  --host=i686-w64-mingw32 \
			  --prefix=$prefix \
			  --mandir=$prefix/share/man \
			  --enable-shared \
			  --enable-static || exit $?

		make || exit $?
		make install DESTDIR=$DESTDIR || exit $?
		rm $DESTDIR$prefix/lib/*.la

		cd ..
		rm -rf build32
		cd ..
	;;
	"build64" )
		cd $PKGNAME
		mkdir build64
		cd build64
		
		../configure \
			  --host=x86_64-w64-mingw32 \
			  --prefix=$prefix \
			  --mandir=$prefix/share/man \
			  --enable-shared \
			  --enable-static || exit $?

		make || exit $?
		mkdir -p ".dllbuild"
		find "src/libjasper" \
			-name '*.o' | xargs -rtl1 -I {} cp {} ".dllbuild"
		x86_64-w64-mingw32-gcc -shared .dllbuild/*.o $DESTDIR$prefix/lib/libjpeg.dll.a -o libjasper-1.dll \
			-Xlinker --out-implib -Xlinker libjasper.dll.a
		
		make install DESTDIR=$DESTDIR || exit $?
		install -m644 "libjasper-1.dll" "$DESTDIR$prefix/bin/" || exit $?
		install -m644 "libjasper.dll.a" "$DESTDIR$prefix/lib/" || exit $?
		
		rm $DESTDIR$prefix/lib/*.la
		
		cd ..
		rm -rf build64
		cd ..
	;;
	"clean" )
		rm -rf $PKGNAME
		rm -rf $PKGNAME.zip
	;;
esac
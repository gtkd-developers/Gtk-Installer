#!/bin/bash

cd `basename ${0:0:${#0}-3}`

PKGNAME=hicolor-icon-theme-0.13

function build {
	./configure --prefix=$prefix || exit $?
	make install DESTDIR=$DESTDIR || exit $?
}

case "$1" in
	"prepare" )
		#wget http://icon-theme.freedesktop.org/releases/$PKGNAME.tar.gz
		shasum -c checksum || exit $?

		tar -xf $PKGNAME.tar.gz
	;;
	"build32" )
		cd $PKGNAME
		build
		cd ..
	;;
	"build64" )
		cd $PKGNAME
		build
		cd ..
	;;
	"clean" )
		rm -rf $PKGNAME
		rm -rf $PKGNAME.tar.gz
	;;
esac
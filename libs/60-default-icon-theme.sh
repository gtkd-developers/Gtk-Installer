#!/bin/bash

cd `basename ${0:0:${#0}-3}`

PKGNAME=default-icon-theme-0.1

case "$1" in
	"prepare" )
		#wget http://icon-theme.freedesktop.org/releases/$PKGNAME.tar.gz
		shasum -c checksum || exit $?

		tar -xf $PKGNAME.tar.gz
	;;
	"build32" )
		cd $PKGNAME
		make install DESTDIR=$DESTDIR PREFIX=$prefix/share || exit $?
		cd ..
	;;
	"build64" )
		cd $PKGNAME
		make install DESTDIR=$DESTDIR PREFIX=$prefix/share || exit $?
		cd ..
	;;
	"clean" )
		rm -rf $PKGNAME
		rm -rf $PKGNAME.tar.gz
	;;
esac
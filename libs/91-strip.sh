#!/bin/bash

case "$1" in
	"build32" )
		strip --strip-all $DESTDIR$prefix/bin/*.exe
		strip --strip-unneeded $DESTDIR$prefix/bin/*.dll
	;;
	"build64" )
		x86_64-w64-mingw32-strip --strip-all $DESTDIR$prefix/bin/*.exe
		x86_64-w64-mingw32-strip --strip-unneeded $DESTDIR$prefix/bin/*.dll
	;;
esac
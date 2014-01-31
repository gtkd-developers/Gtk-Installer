#!/bin/bash

case "$1" in
	"build32" )
		cp /mingw/bin/libgcc_s_sjlj-1.dll $DESTDIR$prefix/bin/ || exit $?
		cp /mingw/bin/libstdc++-6.dll $DESTDIR$prefix/bin/ || exit $?
	;;
	"build64" )
		cp /mingw/x86_64-w64-mingw32/lib/libgcc_s_sjlj-1.dll $DESTDIR$prefix/bin/ || exit $?
		cp /mingw/x86_64-w64-mingw32/lib/libstdc++-6.dll $DESTDIR$prefix/bin/ || exit $?
	;;
esac
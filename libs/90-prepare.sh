#!/bin/bash

cd $DESTDIR$prefix

case "$1" in
	"prepare" )
		exit 0
	;;
	"clean" )
		exit 0
	;;
esac

cd bin

shopt -s extglob
rm -rf !(gdbus.exe|gio-querymodules.exe|glib-compile-resources.exe|glib-compile-schemas.exe|gresource.exe|gsettings.exe|gspawn*|*.dll)

rm -rf libasprintf-0.dll
rm -rf libcairo-script-interpreter-2.dll
rm -rf libcharset-1.dll
rm -rf libgettextpo-0.dll
rm -rf libtiffxx-5.dll
rm -rf libturbojpeg-0.dll
rm -rf libstdc++-6.dll

cd ..

rm -rf lib
rm -rf include

cd share

rm -rf aclocal
rm -rf bash-completion
rm -rf doc
rm -rf gdb
rm -rf gettext

cd glib-2.0

rm -rf codegen
rm -rf gdb
rm -rf gettext

cd ..

rm -rf gtk-3.0
rm -rf gtk-doc
rm -rf info

rm -rf locale/*/*/gettext-tools.mo
rm -rf locale/*/*/gettext-runtime.mo
rm -rf locale/*/*/xz.mo

rm -rf man
rm -rf xml
#!/bin/bash

mkdir -p pkg/lib

#-O2 ?
export CFLAGS="-mms-bitfields"
export CXXFLAGS="${CFLAGS}"
export LDFLAGS=-L`pwd`/pkg/lib
export CPPFLAGS=-I`pwd`/pkg/include
export prefix=""
export DESTDIR="`pwd`/pkg"

export OLD_PATH=$PATH
export PATH=`pwd`/pkg/bin:/mingw/bin:/usr/bin:/usr/local/bin:/bin:/c/Python25

cd libs

#prepare build32 build64 clean
for command in build32 build64
do
	for file in *.sh
	do
		./$file $command || exit $?
	done
done

#./01-zlib.sh
#./02-xz.sh
#./03-libfii.sh
#./04-libiconv.sh
#./05-termcap.sh
#./10-gettext.sh
#./11-libxml2.sh
#./12-glib2.sh
#./13-pkgconfig.sh
#./14-atk.sh
#./20-libpng.sh
#./21-libjpeg.sh
#./22-jasper.sh
#./23-libtiff.sh
#./24-pixman.sh
#./30-freetype.sh
#./31-fontconfig.sh
#./40-cairo.sh
#./41-harfbuzz.sh
#./42-pango.sh
#./43-gdk-pixbuf2.sh
#./50-gtk.sh
#./51-gtkglext.sh
#./52-gtksourceview.sh
#./60-default-icon-theme.sh
#./61-hicolor-icon-theme.sh
#./90-prepare.sh
#./91-strip.sh
#./99-installer.sh
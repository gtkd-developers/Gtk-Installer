#!/bin/sh

#Download delelopment package from suse.
python download-mingw-rpm.py --deps --project windows:mingw:win32 gtk3-devel libxml2-devel pkg-config glib2-tools gsettings-desktop-schemas

#Temporarly override the PATH.
export OLD_PATH=$PATH
export PATH=`pwd`/usr/i686-w64-mingw32/sys-root/mingw/bin:.:/usr/local/bin:/mingw/bin:/bin:.

#Download an configure gtkglext
wget --no-check-certificate https://github.com/tdz/gtkglext/archive/master.zip
unzip master
rm master
cd gtkglext-master
autoreconf -is -Wno-postability -I/c/Users/Mike/Gtk-Installer/aclocal -I/c/Users/Mike/Gtk-Installer/usr/i686-w64-mingw32/sys-root/mingw/share/aclocal -I/usr/local/share/aclocal
mkdir build
cd build
../configure --enable-win32-backend --enable-shared --disable-static --disable-gtk-doc-html --disable-introspection --host=i686-w64-mingw32
echo "all:" > examples/Makefile
echo "install-exec:" >> examples/Makefile

#make gtkglext
make
mkdir root
make install-exec DESTDIR=`pwd`/root

cd ../..

#Download Gtksourceview
wget ftp://ftp.gnome.org/Public/gnome/sources/gtksourceview/3.8/gtksourceview-3.8.1.tar.xz
tar -xf gtksourceview-3.8.1.tar.xz
rm gtksourceview-3.8.1.tar.xz

#cd gtksourceview-3.8.1
mkdir build
cd build

#Make gtksourceview
../configure --localedir=/usr/local/share/locale --enable-shared --disable-static --host=i686-w64-mingw32
make
cd po
make all-yes
cd ..
mkdir root
make install DESTDIR=`pwd`/root
cd po
make install-data-yes DATADIRNAME="share" DESTDIR=`pwd`/../root

cd ../../../

#Download the packages needed by the installer.
rm -rf usr
export PATH=$OLD_PATH
python download-mingw-rpm.py --deps --project windows:mingw:win32 gtk3 glib2-tools gsettings-desktop-schemas
usr/i686-w64-mingw32/sys-root/mingw/bin/glib-compile-schemas.exe usr/i686-w64-mingw32/sys-root/mingw/share/glib-2.0/schemas/

#Copy over the files build for gtkglext and gtksourceview.
cp -R gtkglext-master/build/root/usr/local/bin usr/i686-w64-mingw32/sys-root/mingw
cp -R gtksourceview-3.8.1/build/root/usr/local/bin usr/i686-w64-mingw32/sys-root/mingw
cp -R gtksourceview-3.8.1/build/root/usr/local/share usr/i686-w64-mingw32/sys-root/mingw

#Build the installer.
/c/Program\ Files\ \(x86\)/Inno\ Setup\ 5/ISCC.exe gtk32.iss

rm -rf usr

## 64 bits.

#Download delelopment package from suse.
python download-mingw-rpm.py --deps --project windows:mingw:win64 gtk3-devel libxml2-devel pkg-config glib2-tools gsettings-desktop-schemas

#Temporarly override the PATH.
export PATH=`pwd`/usr/x86_64-w64-mingw32/sys-root/mingw/bin:.:/usr/local/bin:/mingw/bin:/bin:.

#Configure gtkglext
cd gtkglext-master
mkdir build64
cd build64
../configure --enable-win32-backend --enable-shared --disable-static --disable-gtk-doc-html --disable-introspection --host=x86_64-w64-mingw32
echo "all:" > examples/Makefile
echo "install-exec:" >> examples/Makefile

#make gtkglext
make
mkdir root
make install-exec DESTDIR=`pwd`/root

cd ../..

cd gtksourceview-3.8.1
mkdir build64
cd build64

#Make gtksourceview
../configure --localedir=/usr/local/share/locale --enable-shared --disable-static --host=x86_64-w64-mingw32
make
cd po
make all-yes
cd ..
mkdir root
make install DESTDIR=`pwd`/root
cd po
make install-data-yes DATADIRNAME="share" DESTDIR=`pwd`/../root

cd ../../../

#Download the packages needed by the installer.
rm -rf usr
export PATH=$OLD_PATH
python download-mingw-rpm.py --deps --project windows:mingw:win64 gtk3 glib2-tools gsettings-desktop-schemas
usr/x86_64-w64-mingw32/sys-root/mingw/bin/glib-compile-schemas.exe usr/x86_64-w64-mingw32/sys-root/mingw/share/glib-2.0/schemas/

#Copy over the files build for gtkglext and gtksourceview.
cp -R gtkglext-master/build64/root/usr/local/bin usr/x86_64-w64-mingw32/sys-root/mingw
cp -R gtksourceview-3.8.1/build64/root/usr/local/bin usr/x86_64-w64-mingw32/sys-root/mingw
cp -R gtksourceview-3.8.1/build64/root/usr/local/share usr/x86_64-w64-mingw32/sys-root/mingw

#Build the installer.
/c/Program\ Files\ \(x86\)/Inno\ Setup\ 5/ISCC.exe gtk64.iss

rm -rf usr
rm -rf cache
rm -rf gtkglext-master
rm -rf gtksourceview-3.8.1
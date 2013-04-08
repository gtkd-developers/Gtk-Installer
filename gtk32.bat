python download-mingw-rpm.py --deps --project windows:mingw:win32 gtk3 glib2-tools gsettings-desktop-schemas
usr\i686-w64-mingw32\sys-root\mingw\bin\glib-compile-schemas.exe usr\i686-w64-mingw32\sys-root\mingw\share\glib-2.0\schemas\

"C:\Program Files (x86)\Inno Setup 5\ISCC.exe" gtk32.iss

rmdir /S /Q cache
rmdir /S /Q usr

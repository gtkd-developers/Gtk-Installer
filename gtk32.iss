[Setup]
ShowLanguageDialog=no
AppName=Gtk+ Runtime
AppVersion=3.22.24-1
AppPublisher=GtkD Developers
DefaultDirName={pf}\Gtk-Runtime
SourceDir=./
ChangesEnvironment=true
WizardImageFile=compiler:WizModernImage-IS.bmp
WizardSmallImageFile=./logo.gtk.bmp
WizardImageBackColor=clWhite
OutputDir=./
OutputBaseFilename=gtk3-runtime_3.22.24-1_32bit

[Files]                                                                                  
Source: "C:\msys64\mingw32\bin\*.dll"; DestDir: "{app}/bin"; Excludes: "libasprintf-0.dll, libcairo-script-interpreter-2.dll, libcharset-1.dll, libgettextpo-0.dll, libtiffxx-5.dll, libturbojpeg-0.dll, edit.dll, libgirepository-1.0-1.dll, tcl86.dll, tk86.dll, libpython2.7.dll, libreadline7.dll, libtermcap-0.dll, libtre-5.dll, libsystre-0.dll, libeay32.dll, ssleay32.dll, libgdbm-4.dll, libhistory7.dll, libp11-kit-0.dll, libssp-0.dll"; Flags: ignoreversion
Source: "C:\msys64\mingw32\bin\gdbus.exe";                       DestDir: "{app}/bin"; Flags: ignoreversion
Source: "C:\msys64\mingw32\bin\gio-querymodules.exe";            DestDir: "{app}/bin"; Flags: ignoreversion
Source: "C:\msys64\mingw32\bin\glib-compile-resources.exe";      DestDir: "{app}/bin"; Flags: ignoreversion
Source: "C:\msys64\mingw32\bin\glib-compile-schemas.exe";        DestDir: "{app}/bin"; Flags: ignoreversion
Source: "C:\msys64\mingw32\bin\gresource.exe";                   DestDir: "{app}/bin"; Flags: ignoreversion
Source: "C:\msys64\mingw32\bin\gsettings.exe";                   DestDir: "{app}/bin"; Flags: ignoreversion
Source: "C:\msys64\mingw32\bin\gspawn-win32-helper.exe";         DestDir: "{app}/bin"; Flags: ignoreversion
Source: "C:\msys64\mingw32\bin\gspawn-win32-helper-console.exe"; DestDir: "{app}/bin"; Flags: ignoreversion

Source: "C:\msys64\mingw32\share\*"; DestDir: "{app}\share"; Excludes: "aclocal, applications, bash-completion, doc, gdb, gettext, gettext-0.19.8, glib-2.0\codegen, glib-2.0\gdb, glib-2.0\gettext, glib-2.0\valgrind, gobject-introspection-1.0, graphite2, gtk-3.0, gtk-doc, info, locale\*\*\gettext-tools.mo, locale\*\*\gettext-runtime.mo, locale\*\*\xz.mo, man, pkgconfig, readline, thumbnailers, vala, xml, installed-tests, p11-kit, pki, tabset, terminfo"; Flags: ignoreversion recursesubdirs createallsubdirs

Source: "C:\msys64\mingw32\lib\gdk-pixbuf-2.0\*"; DestDir: "{app}\lib\gdk-pixbuf-2.0"; Excludes: "2.10.0\loaders\*.a"; Flags: ignoreversion recursesubdirs createallsubdirs

Source: "C:\msys64\mingw32\etc\*"; DestDir: "{app}\etc"; Excludes: "pkcs11, pki, xml"; Flags: ignoreversion recursesubdirs createallsubdirs

[Tasks]
Name: modifypath; Description: &Add application directory to your system path

[Code]
const
	ModPathName = 'modifypath';
	ModPathType = 'system';

function ModPathDir(): TArrayOfString;
begin
	setArrayLength(Result, 1)
	Result[0] := ExpandConstant('{app}\bin');
end;
#include "modpath.iss"

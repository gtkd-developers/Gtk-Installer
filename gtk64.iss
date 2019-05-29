[Setup]
ShowLanguageDialog=no
AppName=Gtk+ Runtime (64-bits)
AppVersion=3.24.8
AppPublisher=GtkD Developers
DefaultDirName={pf}\Gtk-Runtime
SourceDir=./
ChangesEnvironment=true
WizardImageFile=compiler:WizModernImage-IS.bmp
WizardSmallImageFile=./logo.gtk.bmp
WizardImageBackColor=clWhite
OutputDir=./
OutputBaseFilename=gtk3-runtime_3.24.8_64bit
ArchitecturesInstallIn64BitMode=x64
ArchitecturesAllowed=x64

[Files]                                                                                  
Source: "C:\msys64\mingw64\bin\*.dll"; DestDir: "{app}/bin"; Excludes: "libasprintf-0.dll, libcairo-script-interpreter-2.dll, libcharset-1.dll, libgettextpo-0.dll, libtiffxx-5.dll, libturbojpeg-0.dll, edit.dll, libgirepository-1.0-1.dll, tcl86.dll, tk86.dll, libpython2.7.dll, libreadline7.dll, libtermcap-0.dll, libtre-5.dll, libsystre-0.dll, libeay32.dll, ssleay32.dll, libgdbm-4.dll, libhistory7.dll, libp11-kit-0.dll, libssp-0.dll"; Flags: ignoreversion
Source: "C:\msys64\mingw64\bin\gdbus.exe";                       DestDir: "{app}/bin"; Flags: ignoreversion
Source: "C:\msys64\mingw64\bin\gio-querymodules.exe";            DestDir: "{app}/bin"; Flags: ignoreversion
Source: "C:\msys64\mingw64\bin\glib-compile-resources.exe";      DestDir: "{app}/bin"; Flags: ignoreversion
Source: "C:\msys64\mingw64\bin\glib-compile-schemas.exe";        DestDir: "{app}/bin"; Flags: ignoreversion
Source: "C:\msys64\mingw64\bin\gresource.exe";                   DestDir: "{app}/bin"; Flags: ignoreversion
Source: "C:\msys64\mingw64\bin\gsettings.exe";                   DestDir: "{app}/bin"; Flags: ignoreversion
Source: "C:\msys64\mingw64\bin\gspawn-win64-helper.exe";         DestDir: "{app}/bin"; Flags: ignoreversion
Source: "C:\msys64\mingw64\bin\gspawn-win64-helper-console.exe"; DestDir: "{app}/bin"; Flags: ignoreversion

Source: "C:\msys64\mingw64\share\*"; DestDir: "{app}\share"; Excludes: "aclocal, bash-completion, doc, gdb, gettext, gettext-0.19.8, glib-2.0\codegen, glib-2.0\gdb, glib-2.0\gettext, glib-2.0\valgrind, gobject-introspection-1.0, graphite2, gtk-3.0, gtk-doc, info, locale\*\*\xz.mo, man, pkgconfig, readline, thumbnailers, vala, xml, installed-tests, p11-kit, pki, tabset, terminfo"; Flags: ignoreversion recursesubdirs createallsubdirs

Source: "C:\msys64\mingw64\lib\gdk-pixbuf-2.0\*"; DestDir: "{app}\lib\gdk-pixbuf-2.0"; Excludes: "2.10.0\loaders\*.a"; Flags: ignoreversion recursesubdirs createallsubdirs

Source: "C:\msys64\mingw64\etc\*"; DestDir: "{app}\etc"; Excludes: "pkcs11, pki, xml"; Flags: ignoreversion recursesubdirs createallsubdirs


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

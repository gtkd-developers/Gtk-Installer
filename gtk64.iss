[Setup]
ShowLanguageDialog=no
AppName=Gtk+ Runtime (64-bits)
AppVersion=3.20.4
AppPublisher=GtkD Developers
DefaultDirName={pf}\Gtk-Runtime
SourceDir=./
ChangesEnvironment=true
WizardImageFile=compiler:WizModernImage-IS.bmp
WizardSmallImageFile=./logo.gtk.bmp
WizardImageBackColor=clWhite
OutputDir=./
OutputBaseFilename=Gtk-Runtime-3.20-Setup(64-bits)
ArchitecturesInstallIn64BitMode=x64
ArchitecturesAllowed=x64

[Files]                                                                                  
Source: "C:\msys64\mingw64\bin\*.dll"; DestDir: "{app}/bin"; Excludes: "libasprintf-0.dll, libcairo-script-interpreter-2.dll, libcharset-1.dll, libgettextpo-0.dll, libtiffxx-5.dll, libturbojpeg-0.dll, edit.dll"; Flags: ignoreversion
Source: "C:\msys64\mingw64\bin\gdbus.exe";                       DestDir: "{app}/bin"; Flags: ignoreversion
Source: "C:\msys64\mingw64\bin\gio-querymodules.exe";            DestDir: "{app}/bin"; Flags: ignoreversion
Source: "C:\msys64\mingw64\bin\glib-compile-resources.exe";      DestDir: "{app}/bin"; Flags: ignoreversion
Source: "C:\msys64\mingw64\bin\glib-compile-schemas.exe";        DestDir: "{app}/bin"; Flags: ignoreversion
Source: "C:\msys64\mingw64\bin\gresource.exe";                   DestDir: "{app}/bin"; Flags: ignoreversion
Source: "C:\msys64\mingw64\bin\gsettings.exe";                   DestDir: "{app}/bin"; Flags: ignoreversion
Source: "C:\msys64\mingw64\bin\gspawn-win64-helper.exe";         DestDir: "{app}/bin"; Flags: ignoreversion
Source: "C:\msys64\mingw64\bin\gspawn-win64-helper-console.exe"; DestDir: "{app}/bin"; Flags: ignoreversion

Source: "C:\msys64\mingw64\share\*"; DestDir: "{app}\share"; Excludes: "aclocal, bash-completion, doc, gdb, gettext, gir-1.0, glib-2.0\codegen, glib-2.0\gdb, glib-2.0\gettext, gtk-3.0, gtk-doc, info, locale\*\*\gettext-tools.mo, locale\*\*\gettext-runtime.mo, locale\*\*\xz.mo, man, xml"; Flags: ignoreversion recursesubdirs createallsubdirs

Source: "C:\msys64\mingw64\etc\*"; DestDir: "{app}\etc"; Excludes: "xml"; Flags: ignoreversion recursesubdirs createallsubdirs


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

#!/bin/bash

cd `basename ${0:0:${#0}-3}`

case "$1" in
	"build32" )
		/c/Program\ Files\ \(x86\)/Inno\ Setup\ 5/ISCC.exe gtk32.iss
		rm -rf ../../pkg
	;;
	"build64" )
		/c/Program\ Files\ \(x86\)/Inno\ Setup\ 5/ISCC.exe gtk64.iss
		rm -rf ../../pkg
	;;
esac
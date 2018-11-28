#!/bin/bash 
EXECUTABLE="linpack"
if [[ ! -e ${EXECUTABLE} ]] ; then
	gcc -O -o linpack linpack.c -lm
fi

if [[ "$SYSTEMROOT" = "C:\Windows" ]] ; then
	RESULT=$(./linpack.exe | tail -1)
else
	RESULT=$(./${EXECUTABLE} | tail -1)
fi
echo "$RESULT"
#!/bin/bash 
EXECUTABLE="linpack"
if [[ ! -e ${EXECUTABLE} ]] ; then
	echo "Compiling linpack.c (requires GNU compiler collection)" 1>&2
	gcc -O -o linpack linpack.c -lm
fi

echo "Running linpack benchmark" 1>&2

if [[ "$SYSTEMROOT" = "C:\Windows" ]] ; then
	RESULT=$(./linpack.exe | tail -1)
else
	RESULT=$(./${EXECUTABLE} | tail -1)
fi
echo "$RESULT"

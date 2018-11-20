#!/bin/bash
EXECUTABLE="memsweep"
if [[ ! -e ${EXECUTABLE} ]] ; then
	echo "Compiling memsweep.c (requires GNU compiler collection) " 1>&2
	gcc -O -o memsweep memsweep.c -lm
fi

echo "Running memsweep benchmark" 1>&2

if [[ "$SYSTEMROOT" = "C:\Windows" ]] ; then
	./memsweep.exe
else
	./memsweep
fi

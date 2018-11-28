#!/usr/bin/env bash

NUM_MEGS=128

if [[ ! -e bigfile ]]; then
    dd if=/dev/zero of=bigfile bs=1M count=${NUM_MEGS} >& /dev/null # create a 1GB file
    sync 2>&1 > /dev/null
fi

#/sbin/sysctl -w vm.drop_caches=3 2>&1 > /dev/null
# this outputs time, not read speed - but it's easy to compute GB/s
OUTPUT=`apt-get install -y time`
#RESULT=`time -p dd if=bigfile of=/dev/null bs=1M count=${NUM_MEGS} 2>&1`
echo "$OUTPUT"
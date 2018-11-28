#!/usr/bin/env bash

NUM_MEGS=2048

if [[ ! -e bigfile ]]; then
    dd if=/dev/zero of=bigfile bs=1M count=${NUM_MEGS} 2>&1 > /dev/null # create a 1GB file
    sync 2>&1 > /dev/null
fi

sudo sysctl -w vm.drop_caches=3 2>&1 > /dev/null
# this outputs time, not read speed - but it's easy to compute GB/s
/usr/bin/time -p dd if=bigfile of=/dev/null bs=1M count=${NUM_MEGS} 2>&1 | grep real | cut -d' ' -f2
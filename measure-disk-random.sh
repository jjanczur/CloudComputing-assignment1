#!/usr/bin/env bash
/usr/bin/time -p sudo fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=test --filename=test \
                          --bs=1M --iodepth=64 --size=2048M --readwrite=randread 2>&1 \
    | grep real | cut -d' ' -f2
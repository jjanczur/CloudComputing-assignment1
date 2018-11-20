#!/usr/bin/env bash

current_time=$(date +%s)
current_time_nice=$(date)

if which ec2-metadata > /dev/null; then
    PROVIDER=ec2
else
    PROVIDER=google
fi

for benchmark in cpu mem disk-random disk-sequential; do
    RESULT_FILE=${PROVIDER}-${benchmark}.csv
    BENCHMARK_SCRIPT=./measure-${benchmark}.sh

    if [[ ! -x ${RESULT_FILE} ]]; then
        echo "[$current_time_nice] creating $RESULT_FILE"
        echo "time,value" > ${RESULT_FILE}
    fi

    RESULT=$(${BENCHMARK_SCRIPT})

    echo "[$current_time_nice] $benchmark benchmark result $RESULT"
    echo "$current_time,$RESULT" >> ${RESULT_FILE}
done
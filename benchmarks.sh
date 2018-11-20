#!/usr/bin/env bash

CURRENT_TIME=$(date +%s)
CURRENT_TIME_NICE=$(date)

if which ec2-metadata > /dev/null; then
    PROVIDER=ec2
else
    PROVIDER=google
fi

for BENCHMARK in cpu mem disk-random disk-sequential; do
    RESULT_FILE=${PROVIDER}-${BENCHMARK}.csv
    BENCHMARK_SCRIPT=./measure-${BENCHMARK}.sh

    if [[ ! -x ${RESULT_FILE} ]]; then
        echo "[$CURRENT_TIME_NICE] creating $RESULT_FILE"
        echo "time,value" > ${RESULT_FILE}
    fi

    RESULT=$(${BENCHMARK_SCRIPT})

    echo "[$CURRENT_TIME_NICE] $BENCHMARK benchmark result $RESULT"
    echo "$CURRENT_TIME,$RESULT" >> ${RESULT_FILE}
done
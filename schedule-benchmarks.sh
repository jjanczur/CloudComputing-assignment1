#!/usr/bin/env bash

for i in $(seq 0 47); do
    at now + ${i} hours <<< "./benchmarks.sh"
done
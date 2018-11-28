#!/usr/bin/env bash

for I in $(seq 0 47); do
    at now + ${I} hours <<< "./benchmarks.sh"
done
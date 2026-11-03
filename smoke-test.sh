#!/usr/bin/env bash
export PER_SUITE=3
export TIMEOUT=${TIMEOUT:-1s}
export RESULTS_DIR=${RESULTS_DIR:-results-smoke}
exec ./bench.sh

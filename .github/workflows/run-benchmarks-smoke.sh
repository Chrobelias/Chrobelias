#!/usr/bin/env bash

set +e +o pipefail;

solver_with_flags=$1;
base=$2;
timeout=$3;

mkdir -p results/

k=0
execut=$(echo $solver_with_flags | tr ' ' '\n' | head -n 1);
solver=$(basename "$solver_with_flags");
readarray -t flags < <(echo $solver_with_flags | tr ' ' '\n' | tail -n +2);
for suite in $(find $base -type d | sort | awk '$0 !~ last "/" {print last} {last=$0} END {print last}'); do
  suitename=$(sed 's/\.//g' <<< ${suite:${#base} + 1} | sed 's/\///g');
  suitefile="results/res-$(echo "$solver" | sed 's/ /-/g')-$suitename.txt";
  START_TIME=$(date +%s)
  for i in $suite"/"*.smt2; do
    echo $i;
    (timeout -s SIGINT $timeout time ./_build/default/$execut "${flags[@]}" $i) 2> /dev/null;
    res=$?
    if [[ res -eq 124 ]]; then
      echo timeout
    elif [[ res -ne 0 ]]; then
      echo unknown
    fi
    ((k++))
    if [[ $k -eq 3 ]]; then
      break
    fi
  done | tee "$suitefile";
  END_TIME=$(date +%s)
  DURATION=$(($END_TIME - $START_TIME))
  echo "OK $suitename via $solver in $DURATION seconds with $execute"
done

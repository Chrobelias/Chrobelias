#!/usr/bin/env bash

set +e +o pipefail;

solver_with_flags=$1;
base=$2;
timeout=$3;

execut=$(echo $solver_with_flags | tr ' ' '\n' | head -n 1);
solver=$(basename $execut);
readarray -t flags < <(echo $solver_with_flags | tr ' ' '\n' | tail -n +2);
for suite in $(find $base -type d | sort | awk '$0 !~ last "/" {print last} {last=$0} END {print last}'); do
  suitename=$(sed 's/\.//g' <<< ${suite:${#base} + 1} | sed 's/\///g');
  suitefile="res-$solver-$suitename.txt";
  tempfile=".temp";
  START_TIME=$(date +%s)
  for i in $suite"/"*.smt2; do
    echo $i;
    (timeout -k 2 $timeout time ./_build/default/$execut "${flags[@]}" $i) > $tempfile 2>&1 ;
    res=$?;
    # timeout's -k SIGKILL reaches only its direct child, and a solver stuck
    # inside native Z3 defers the group SIGTERM forever, so stragglers (and
    # their portfolio children) survive every instance that hits the limit.
    # Sequential execution makes an unconditional per-instance sweep safe.
    pkill -9 -f "_build/default/$execut" 2>/dev/null;
    if [[ res -eq 124 || res -eq 137 ]]; then
      echo timeout
    elif grep -q "^sat" $tempfile; then
      echo sat
    elif grep -q "^unsat" $tempfile; then
      echo unsat
    elif grep -q "^timeout" $tempfile; then
      echo timeout
    else
      echo unknown
    fi
  done | tee $suitefile;
  END_TIME=$(date +%s)
  DURATION=$(($END_TIME - $START_TIME))
  echo "Benchmarks $suitename completed by $solver in: $DURATION seconds with $execute"
done

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
    if [[ res -eq 124 ]]; then
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
  # A solver stuck inside native Z3 defers OCaml signal handling forever, so a
  # TERM-only timeout strands it (and its portfolio children). -k above KILLs
  # the process group after the grace period; this sweep catches anything that
  # escaped the group, before orphans accumulate into fork failures that turn
  # every remaining instance into a bare "unknown".
  pkill -9 -f "_build/default/$execut" 2>/dev/null;
  END_TIME=$(date +%s)
  DURATION=$(($END_TIME - $START_TIME))
  echo "Benchmarks $suitename completed by $solver in: $DURATION seconds with $execute"
done

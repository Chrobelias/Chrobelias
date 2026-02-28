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
  suitefile="res_"$solver"_"$suitename".txt";
  START_TIME=$(date +%s)
  for i in $suite"/"*.smt2; do
    echo $i;
    timeout $timeout time opam exec -- dune exec $execut --no-build -- "${flags[@]}" $i;
  done 2>&1 | tee $suitefile;
  END_TIME=$(date +%s)
  DURATION=$(($END_TIME - $START_TIME))
  echo "Benchmarks $suitename completed by $solver in: $DURATION seconds with $execute"
done

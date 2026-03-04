#!/usr/bin/env bash

set +e +o pipefail;

solver_with_flags=$1;
base=$2;
timeout=$3;

execut=$(echo $solver_with_flags | tr ' ' '\n' | head -n 1);
solver=$(basename $execut);
readarray -t flags < <(echo $solver_with_flags | tr ' ' '\n' | tail -n +2);

suitename=$(sed 's/\.//g' <<< $(basename $base) | sed 's/\///g');
suitefile="res_"$solver"_"$suitename".txt";
START_TIME=$(date +%s)
for i in $base"/"*.smt2; do
  echo $i;
  timeout $timeout time ./_build/default/$execut "${flags[@]}" $i;
done 2>&1 | tee $suitefile;
END_TIME=$(date +%s)
DURATION=$(($END_TIME - $START_TIME))
echo "Benchmarks $suitename completed by $solver in: $DURATION seconds with $execute"

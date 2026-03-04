#!/usr/bin/env bash

set +e +o pipefail;

solver_with_flags=$1
base=$2

execut=$(echo $solver_with_flags | tr ' ' '\n' | head -n 1);
solver=$(basename $execut);
flags=$(echo $solver_with_flags | tr ' ' '\n' | tail -n +2 | xargs);

suite=$base

suitename=$(sed 's/\.//g' <<< $(basename $suite) | sed 's/\///g');
suitefile="res_"$solver"_"$suitename".txt";
echo "$solver results for $suitename:";
unsat_c=$(grep unsat $suitefile | wc -l);
sat_c=$(grep sat $suitefile | wc -l);
unknown_c=$(grep unknown $suitefile | wc -l);
echo "sat     : $((sat_c - unsat_c))";
echo "unsat   : $unsat_c";
echo "unknown : $unknown_c";
echo "timeout : $(grep timeout $suitefile | wc -l)";
echo "total   : $(grep smt2 $suitefile | wc -l)";

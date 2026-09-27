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
# Count verdict lines only (anchored at line start): benchmark file names may
# contain "sat"/"unsat" (e.g. z3str2/regex-004-unsat-*.smt2) and must not be counted.
sat_c=$(grep -cE '^sat( |$)' "$suitefile");
unsat_c=$(grep -cE '^unsat( |$)' "$suitefile");
unknown_c=$(grep -cE '^unknown( |$)' "$suitefile");
timeout_c=$(grep -cE '^timeout( |$)' "$suitefile");
echo "sat     : $sat_c";
echo "unsat   : $unsat_c";
echo "unknown : $unknown_c";
echo "timeout : $timeout_c";
echo "total   : $(grep -c '\.smt2$' "$suitefile")";

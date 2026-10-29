#!/usr/bin/env bash

set +e +o pipefail;

solver_with_flags=$1
base=$2

execut=$(echo $solver_with_flags | tr ' ' '\n' | head -n 1);
solver=$(basename $execut);
flags=$(echo $solver_with_flags | tr ' ' '\n' | tail -n +2 | xargs);

reason_breakdown() {
  local v="$1" f="$2"
  [ -z "$CHRO_REASONS" ] && return 0
  local out
  out=$(grep "^$v (" "$f" \
    | sed -nE "s/^$v \((.*)\)[[:space:]]*\$/\1/p" \
    | sort | uniq -c | sort -rn \
    | awk '{c=$1; $1=""; sub(/^[[:space:]]+/,""); printf "%s%s %s", sep, c, $0; sep=", "}')
  [ -n "$out" ] && printf " (%s)" "$out"
}

suite=$base

suitename=$(sed 's/\.//g' <<< $(basename $suite) | sed 's/\///g');
suitefile="res_"$solver"_"$suitename".txt";
echo "$solver results for $suitename:";
# Count verdict lines only (anchored at line start): benchmark file names may
# contain "sat"/"unsat" (e.g. z3str2/regex-004-unsat-*.smt2) and must not be counted.
echo "sat     : $(grep -c '^sat' $suitefile)$(reason_breakdown sat "$suitefile")";
echo "unsat   : $(grep -c '^unsat' $suitefile)$(reason_breakdown unsat "$suitefile")";
echo "unknown : $(grep -c '^unknown' $suitefile)$(reason_breakdown unknown "$suitefile")";
echo "timeout : $(grep -c '^timeout' $suitefile)";
echo "total   : $(grep -c smt2 $suitefile)";

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

for suite in $(find $base -type d | sort | awk '$0 !~ last "/" {print last} {last=$0} END {print last}'); do
  suitename=$(sed 's/\.//g' <<< ${suite:${#base} + 1} | sed 's/\///g');
  suitefile="res-$solver-$suitename.txt";
  echo "$solver results for $suitename:";
  echo "sat     : $(grep -c '^sat' $suitefile)$(reason_breakdown sat "$suitefile")";
  echo "unsat   : $(grep -c '^unsat' $suitefile)$(reason_breakdown unsat "$suitefile")";
  echo "unknown : $(grep -c '^unknown' $suitefile)$(reason_breakdown unknown "$suitefile")";
  echo "timeout : $(grep -c '^timeout' $suitefile)";
  echo "total   : $(grep -c smt2 $suitefile)";

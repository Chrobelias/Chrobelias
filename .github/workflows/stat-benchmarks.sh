#!/usr/bin/env bash
# Summarise the res-<label>-<suite>.tsv files written by run-benchmarks.sh:
# the number of each verdict, Chrobelias's deciding stages, and the
# wall-clock time spent on the decided instances.
#
#   stat-benchmarks.sh "<executable> [flags]" <base>

set +e +o pipefail

solver_with_flags=$1
base=$2
label=$(echo "$solver_with_flags" | sed -E 's|^[^ ]*/||; s/ +/_/g')
: "${RESULTS_DIR:=.}"

for suite in $(find $base -type d | sort | awk '$0 !~ last "/" {print last} {last=$0} END {print last}'); do
  suitename=$(sed 's/\.//g' <<<${suite:${#base}+1} | sed 's/\///g')
  [ -n "$suitename" ] || suitename=$(basename "$base" | sed 's/\.//g')
  f="$RESULTS_DIR/res-$label-$suitename.tsv"
  [ -f "$f" ] || { echo "missing $f"; continue; }
  echo "$label results for $suitename:"
  for v in sat unsat unknown timeout; do
    n=$(awk -F'\t' -v v="$v" '$4 == v' "$f" | wc -l)
    stages=$(awk -F'\t' -v v="$v" '$4 == v && $5 != "" { print $5 }' "$f" |
      sort | uniq -c | sort -rn |
      awk '{ c = $1; $1 = ""; sub(/^ +/, ""); printf "%s%s %s", sep, c, $0; sep = ", " }')
    printf '%-8s: %s%s\n' "$v" "$n" "${stages:+ ($stages)}"
  done
  echo "total   : $(wc -l <"$f")"
  awk -F'\t' '$4 == "sat" || $4 == "unsat" { s += $6; n++ }
    END { printf "wall time on decided instances: %.1f s (%d instances)\n", s, n }' "$f"
done

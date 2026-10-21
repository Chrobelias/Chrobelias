#!/usr/bin/env bash
# Re-run Chrobelias with --check-model on every instance it answered sat.
#
#   scripts/check-models.sh RESULTS_DIR [JOBS]
#
# Reads RESULTS_DIR/res-chro*.tsv (written by run-benchmarks.sh), runs
# "$CHRO -q --check-model <file>" with a 60 s limit, and writes
# RESULTS_DIR/check-models.tsv:  file  outcome  wall_s
# outcome: ok, FAILED (the model does not satisfy the formula), no-short-model,
# or not-finished (timeout or no verdict in this run).
# Prints the FAILED lines at the end; exit status 1 if there is one.
set +e
rdir=$1
jobs=${2:-$(($(nproc) / 2))}
: "${CHRO:=./release/chro}"
: "${MEM_PER_RUN:=8192}"
export CHRO MEM_PER_RUN

check_one() {
  local f="$1" tmp t0 t1 res outcome
  tmp=$(mktemp)
  t0=$(date +%s.%N)
  (
    ulimit -v $((MEM_PER_RUN * 1024))
    exec timeout -k 2 -s SIGINT 60 "$CHRO" -q --check-model "$f"
  ) >"$tmp" 2>&1
  res=$?
  t1=$(date +%s.%N)
  if grep -q 'model check has failed' "$tmp"; then
    outcome=FAILED
  elif grep -q 'no short model' "$tmp"; then
    outcome=no-short-model
  elif [ "$res" -ne 124 ] && [ "$res" -ne 137 ] && grep -q '^sat' "$tmp"; then
    outcome=ok
  else
    outcome=not-finished
  fi
  printf '%s\t%s\t%s\n' "$f" "$outcome" "$(awk -v a="$t0" -v b="$t1" 'BEGIN { printf "%.2f", b - a }')"
  rm -f "$tmp"
}
export -f check_one

cat "$rdir"/res-chro*.tsv | awk -F'\t' '$4 == "sat" { print $3 }' | sort -u |
  parallel --will-cite -j "$jobs" check_one {} >"$rdir/check-models.tsv"
cut -f2 "$rdir/check-models.tsv" | sort | uniq -c
grep -P '\tFAILED\t' "$rdir/check-models.tsv" && exit 1
exit 0

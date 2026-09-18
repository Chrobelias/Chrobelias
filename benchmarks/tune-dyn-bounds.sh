#!/usr/bin/env bash

# Sweeps the ladder's starting budgets, [Config.dyn_leaf_budget] (residues
# per ordering) and [Config.dyn_scan_budget] (ChrobakNF scan budget, bounding
# the state count at its square root), and reports solved counts per suite.
# Both are overridable through CHRO_DYN_LEAVES / CHRO_DYN_SCAN, so no rebuild.
#
#   ./benchmarks/tune-dyn-bounds.sh benchmarks/chrobelias 10 6
#
# Arguments: benchmark root, per-instance timeout (default 10), jobs (default
# 4). Narrow the grid with LEAVES=... SCAN=...
#
# -no-parallel because the portfolio credits a budget with answers won by a
# racing strategy; -no-model to keep the measurement on the elimination.
#
# Split the set before trusting a winner: the grid has a broad plateau whose
# argmax moves between runs.

set -u

base=${1:?usage: tune-dyn-bounds.sh <benchmark-root> [timeout] [jobs]}
timeout_s=${2:-10}
jobs=${3:-4}
bin=${CHRO:-./_build/default/bin/chro.exe}

# Bounds of 8..256 states, against residues from "floor at 2 at once" to
# "expand freely".
leaves_grid=${LEAVES:-"4 16 64"}
scan_grid=${SCAN:-"64 144 400 3136 10000 65536"}

if [ ! -x "$bin" ]; then
  echo "no solver at $bin (build it, or set CHRO=)" >&2
  exit 1
fi

list=$(mktemp) || exit 1
results=$(mktemp) || exit 1
trap 'rm -f "$list" "$results"' EXIT

find "$base" -name '*.smt2' | sort > "$list"
total=$(wc -l < "$list")
if [ "$total" -eq 0 ]; then
  echo "no .smt2 files under $base" >&2
  exit 1
fi

# Per-suite, as the CI matrices report: a budget trading one suite for another
# must be visible rather than averaged away.
suites=$(sed 's#/[^/]*$##' "$list" | sed "s#^$base/\?##" | sort -u)

probe() {
  local out
  out=$(CHRO_DYN_LEAVES="$1" CHRO_DYN_SCAN="$2" \
        timeout -k 2 "$timeout_s" "$bin" -q -no-model -no-parallel "$3" \
        2>/dev/null | head -n 1)
  case "$out" in
    sat*|unsat*) echo "solved	$3" ;;
    *) echo "unknown	$3" ;;
  esac
}
export -f probe
export bin timeout_s

printf '%s instances, %ss timeout, %s jobs\n\n' "$total" "$timeout_s" "$jobs"
printf '%7s %8s %7s %8s' leaves scan states solved
for s in $suites; do printf ' %14s' "$(basename "$s")"; done
printf '\n'

for leaves in $leaves_grid; do
  for scan in $scan_grid; do
    xargs -a "$list" -P "$jobs" -I{} \
      bash -c 'probe "$0" "$1" "$2"' "$leaves" "$scan" {} > "$results" 2>/dev/null
    states=$(awk -v s="$scan" 'BEGIN { printf "%d", int(sqrt(s)) }')
    printf '%7s %8s %7s %8s' \
      "$leaves" "$scan" "$states" "$(grep -c '^solved' "$results")"
    for s in $suites; do
      printf ' %14s' "$(grep '^solved' "$results" | grep -c "/$s/")"
    done
    printf '\n'
  done
done

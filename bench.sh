#!/usr/bin/env bash
set +e;
TIMEOUT=60s

matches_filter() {
  local value="$1"
  local filter="$2"
  [[ -z "$filter" ]] && return 0
  IFS=',' read -ra patterns <<< "$filter"
  for pattern in "${patterns[@]}"; do
    [[ "$value" =~ $pattern ]] && return 0
  done
  return 1
}

eia_benchmarks=(
  "benchmarks/chrobelias/QF_EIA/LoAT"
  "benchmarks/chrobelias/QF_EIA/PURRS"
  "benchmarks/chrobelias/QF_EIA/SIERPINSKI"
)
eia_solvers=(
  "bin/chro.exe -q"
  "bin/chro.exe -q -bres 2 -bstates 20"
  "bin/swine"
)

mkdir -p results stats

for solver in "${eia_solvers[@]}"; do
  matches_filter "$solver" "$CHRO_SOLVERS" || continue
  echo "Testing EIA $solver..."
  for benchmark in "${eia_benchmarks[@]}"; do
    matches_filter "$benchmark" "$CHRO_BENCHMARKS" || continue
    echo "Runinng $solver on $benchmark"
    ./.github/workflows/run-benchmarks.sh "$solver" "$benchmark" $TIMEOUT
    solverescaped=$(basename "$solver" | sed 's/[ /]/-/g')
    benchmarkescaped=$(basename "$benchmark" | sed 's/[ /]/-/g')
    ./.github/workflows/stat-benchmarks.sh "$solver" "$benchmark" | tee "stats/$solverescaped-$benchmarkescaped.txt"
  done
done

slia_benchmarks=(
  "benchmarks/chrobelias/QF_SLIA/stringfuzz"
  "benchmarks/chrobelias/QF_SLIA/Hash2"
  "benchmarks/chrobelias/QF_SLIA/StrRElnc"
)
slia_solvers=(
  "bin/chro.exe -q"
  "bin/chro.exe -q -bres 2 -bstates 20"
  "bin/chro.exe -under-all"
  "bin/ostrich2"
  "bin/cvc5"
  "bin/z3-noodler"
  "bin/z3-old"
)

for solver in "${slia_solvers[@]}"; do
  matches_filter "$solver" "$CHRO_SOLVERS" || continue
  echo "Testing SLIA $solver..."
  for benchmark in "${slia_benchmarks[@]}"; do
    matches_filter "$benchmark" "$CHRO_BENCHMARKS" || continue
    echo "Runinng $solver on $benchmark"
    ./.github/workflows/run-benchmarks.sh "$solver" "$benchmark" $TIMEOUT
    solverescaped=$(basename "$solver" | sed 's/[ /]/-/g')
    benchmarkescaped=$(basename "$benchmark" | sed 's/[ /]/-/g')
    ./.github/workflows/stat-benchmarks.sh "$solver" "$benchmark" | tee "stats/$solverescaped-$benchmarkescaped.txt"
  done
done

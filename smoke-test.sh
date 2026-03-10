#!/usr/bin/env bash

set +e;

TIMEOUT=1s

eia_benchmarks=(
  "benchmarks/QF_LIA"
  "benchmarks/chrobelias/QF_EIA/SIERPINSKI"
)
eia_solvers=(
  "bin/chro.exe -q"
  "bin/chro.exe -q -bres 1 -bstates 10"
  "bin/chro.exe -q -bres 2 -bstates 20"
  "bin/swine"
)

mkdir -p results
mkdir -p stats

for solver in "${eia_solvers[@]}"; do
  echo "Testing EIA $solver..."
  for benchmark in "${eia_benchmarks[@]}"; do
    echo "Runinng $solver on $benchmark"
    ./.github/workflows/run-benchmarks-smoke.sh "$solver" "$benchmark" $TIMEOUT
    solverescaped=$(echo "$(basename "$solver")" | sed 's/ /-/g' | sed 's/\//-/g');
    benchmarkescaped=$(echo "$(basename "$benchmark")" | sed 's/ /-/g' | sed 's/\//-/g');
    stat="stats/$solverescaped-$benchmarkescaped.txt"
    ./.github/workflows/stat-benchmarks.sh "$solver" "$benchmark" | tee "$stat"
  done
done

slia_benchmarks=(
  "benchmarks/chrobelias/QF_SLIA/stringfuzzregex"
  "benchmarks/chrobelias/QF_SLIA/HashFunction"
  "benchmarks/chrobelias/QF_SLIA/StrRElnc"
)
slia_solvers=(
  "bin/chro.exe -q"
  "bin/chro.exe -q -bres 1 -bstates 10"
  "bin/chro.exe -q -bres 2 -bstates 20"
  "bin/chro.exe -under-all -sbcnt 10 -sblen 5"
  "bin/ostrich2"
  "bin/cvc5"
  "bin/z3-noodler"
  "bin/z3-old"
)

for solver in "${slia_solvers[@]}"; do
  echo "Testing SLIA $solver..."
  for benchmark in "${slia_benchmarks[@]}"; do
    echo "Runinng $solver on $benchmark"
    ./.github/workflows/run-benchmarks-smoke.sh "$solver" "$benchmark" $TIMEOUT
    solverescaped=$(echo "$(basename "$solver")" | sed 's/ /-/g' | sed 's/\//-/g');
    benchmarkescaped=$(echo "$(basename "$benchmark")" | sed 's/ /-/g' | sed 's/\//-/g');
    stat="stats/$solverescaped-$benchmarkescaped.txt"
    ./.github/workflows/stat-benchmarks.sh "$solver" "$benchmark" | tee "$stat"
  done
done

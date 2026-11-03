#!/usr/bin/env bash
# Run every solver configuration of the paper on every benchmark family.
# Families run one after another, all their solvers before the next family,
# in the order of the list below, so that complete comparisons for the
# cheaper families exist early.
#
# Environment:
#   CHRO             Chrobelias executable (default ./release/chro, the static
#                    binary of the GitHub release used in the paper);
#   CHRO_SOLVERS     comma-separated regexes: run only matching solver configs;
#   CHRO_BENCHMARKS  comma-separated regexes: run only matching families;
#   RESULTS_DIR      where res-*.tsv go (default results);
#   REPO_COMMIT, BENCH_COMMIT: commits recorded in environment.txt when the
#                    checkout has no .git (e.g. inside the Docker image);
#   CORES_PER_RUN, JOBS, MEM_PER_RUN: see .github/workflows/run-benchmarks.sh.
set +e
TIMEOUT=${TIMEOUT:-60s}
: "${CHRO:=./release/chro}"
: "${RESULTS_DIR:=results}"
export RESULTS_DIR

matches_filter() {
  local value="$1"
  local filter="$2"
  [[ -z "$filter" ]] && return 0
  IFS=',' read -ra patterns <<<"$filter"
  for pattern in "${patterns[@]}"; do
    [[ "$value" =~ $pattern ]] && return 0
  done
  return 1
}

families=(
  "benchmarks/chrobelias/QF_EIA/SIERPINSKI eia"
  "benchmarks/chrobelias/QF_EIA/PURRS eia"
  "benchmarks/chrobelias/QF_EIA/LoAT eia"
  "benchmarks/chrobelias/QF_SLIA/Hash2 slia"
  "benchmarks/chrobelias/QF_SLIA/StrRElnc slia"
  "benchmarks/chrobelias/QF_SLIA/stringfuzz slia"
  "benchmarks/chrobelias/QF_SLIA/FullStrInt slia"
)
eia_solvers=("$CHRO -q" "bin/swine")
slia_solvers=("$CHRO -q" "bin/cvc5" "bin/ostrich2" "bin/z3" "bin/z3-noodler")

mkdir -p "$RESULTS_DIR" stats

# Record the machine and the exact binaries once per results directory.
env_file="$RESULTS_DIR/environment.txt"
if [ ! -f "$env_file" ]; then
  {
    echo "date: $(date -Is)"
    echo "host: $(uname -a)"
    grep -m1 PRETTY_NAME /etc/os-release
    lscpu | grep -E 'Model name|^CPU\(s\)|Thread|Core|Socket'
    free -g | head -2
    echo "repo: ${REPO_COMMIT:-$(git rev-parse HEAD 2>/dev/null)}"
    echo "benchmarks: ${BENCH_COMMIT:-$(git -C benchmarks/chrobelias rev-parse HEAD 2>/dev/null)}"
    echo "TIMEOUT=$TIMEOUT CORES_PER_RUN=${CORES_PER_RUN:-2} JOBS=${JOBS:-auto} MEM_PER_RUN=${MEM_PER_RUN:-8192}"
    for b in "$CHRO" ./_build/default/bin/swine ./_build/default/bin/cvc5 \
      ./_build/default/bin/z3 ./_build/default/bin/z3-noodler \
      ./_build/default/bin/target/native-image/ostrich; do
      [ -e "$b" ] && sha256sum "$b"
    done
    ./_build/default/bin/cvc5 --version 2>&1 | head -1
    ./_build/default/bin/z3 --version 2>&1 | head -1
    ./_build/default/bin/z3-noodler --version 2>&1 | head -1
    ./_build/default/bin/swine --version 2>&1 | head -2
  } >"$env_file"
fi

for entry in "${families[@]}"; do
  benchmark=${entry% *}
  kind=${entry#* }
  matches_filter "$benchmark" "$CHRO_BENCHMARKS" || continue
  if [ "$kind" = eia ]; then
    solvers=("${eia_solvers[@]}")
  else
    solvers=("${slia_solvers[@]}")
  fi
  for solver in "${solvers[@]}"; do
    matches_filter "$solver" "$CHRO_SOLVERS" || continue
    echo "Running $solver on $benchmark"
    ./.github/workflows/run-benchmarks.sh "$solver" "$benchmark" $TIMEOUT
    label=$(echo "$solver" | sed -E 's|^[^ ]*/||; s/ +/_/g')
    ./.github/workflows/stat-benchmarks.sh "$solver" "$benchmark" |
      tee "stats/$label-$(basename "$benchmark").txt"
  done
done

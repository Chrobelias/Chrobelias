#!/usr/bin/env bash

set +e +o pipefail;

solver_with_flags=$1;
base=$2;
timeout=$3;

execut=$(echo $solver_with_flags | tr ' ' '\n' | head -n 1);
solver=$(basename $execut);
readarray -t flags < <(echo $solver_with_flags | tr ' ' '\n' | tail -n +2);

NPROC=$(nproc 2>/dev/null || sysctl -n hw.ncpu 2>/dev/null || echo 1);
: "${CORES_PER_RUN:=1}";
: "${MEM_PER_RUN:=8192}";
: "${NO_VMEM_CAP:=ostrich}";
: "${OSTRICH_MEM_MB:=$MEM_PER_RUN}";
: "${JOBS:=$(( NPROC / CORES_PER_RUN ))}";
[ "$JOBS" -ge 1 ] || JOBS=1;

export timeout execut NPROC CORES_PER_RUN MEM_PER_RUN NO_VMEM_CAP OSTRICH_MEM_MB
export FLAGS="${flags[*]}"

run_one() {
  local i="$1" slot="$2"
  local flags; read -ra flags <<< "$FLAGS"
  local tmp; tmp="$(mktemp)"
  local pin=""
  if [ "$CORES_PER_RUN" -gt 0 ]; then
    local a=$(( (slot - 1) * CORES_PER_RUN ))
    local b=$(( a + CORES_PER_RUN - 1 ))
    [ "$b" -lt "$NPROC" ] && pin="taskset -c $a-$b"
  fi
  local xmx=()
  if [[ "$execut" =~ $NO_VMEM_CAP ]] && [ "$OSTRICH_MEM_MB" -gt 0 ]; then
    xmx=("-Xmx${OSTRICH_MEM_MB}m")
  fi
  echo "$i"
  set -m
  (
    if [ "$MEM_PER_RUN" -gt 0 ] && ! [[ "$execut" =~ $NO_VMEM_CAP ]]; then
      ulimit -v $(( MEM_PER_RUN * 1024 ))
    fi
    exec $pin timeout -k 2 -s SIGINT "$timeout" ./_build/default/"$execut" "${xmx[@]}" "${flags[@]}" "$i"
  ) > "$tmp" 2>&1 &
  local pid=$!
  wait "$pid"; local res=$?
  kill -9 -"$pid" 2>/dev/null
  set +m
  if [ "$res" -eq 124 ] || [ "$res" -eq 137 ]; then
    echo timeout
  elif grep -q "^sat" "$tmp"; then
    echo sat
  elif grep -q "^unsat" "$tmp"; then
    echo unsat
  elif grep -q "^timeout" "$tmp"; then
    echo timeout
  else
    echo unknown
  fi
  rm -f "$tmp"
}
export -f run_one

for suite in $(find $base -type d | sort | awk '$0 !~ last "/" {print last} {last=$0} END {print last}'); do
  suitename=$(sed 's/\.//g' <<< ${suite:${#base} + 1} | sed 's/\///g');
  suitefile="res-$solver-$suitename.txt";
  START_TIME=$(date +%s)
  printf '%s\n' "$suite"/*.smt2 | parallel --will-cite --keep-order -j "$JOBS" run_one {} {%} | tee "$suitefile";
  END_TIME=$(date +%s)
  DURATION=$(($END_TIME - $START_TIME))
  echo "Benchmarks $suitename completed by $solver in: $DURATION seconds with $execute"
done

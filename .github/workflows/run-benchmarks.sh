#!/usr/bin/env bash
# Run one solver configuration on every leaf directory (suite) below a base
# directory, several instances in parallel.
#
#   run-benchmarks.sh "<executable> [flags]" <base> <timeout>
#
# <executable> is a path relative to _build/default (e.g. bin/cvc5) or a path
# starting with / or ./ (e.g. ./release/chro).  For every suite the script
# writes res-<label>-<suite>.tsv, one line per instance:
#
#   label  suite  file  verdict  stage  wall_s  cpu_s  maxrss_kb  exit
#
# label   the executable name and its flags, e.g. chro_-q;
# verdict sat, unsat, unknown or timeout;
# stage   the text in parentheses after Chrobelias's verdict, empty otherwise;
# wall_s  wall-clock seconds of the run;
# cpu_s   user + system seconds (GNU time, the process and the children it
#         waited for);
# maxrss_kb  largest resident set of one process, in KB (GNU time %M).
# cpu_s and maxrss_kb are NA when /usr/bin/time (GNU time) is not installed.
#
# A run that reaches <timeout> is "timeout" even if the solver printed a
# verdict before (e.g. sat followed by a (get-model) that did not finish).
#
# Environment:
#   CORES_PER_RUN  physical cores per run (default 2);
#   JOBS           parallel runs (default: physical cores / CORES_PER_RUN);
#   MEM_PER_RUN    MB of address space per process via ulimit -v (default 8192);
#   NO_VMEM_LIMIT  regex of executables that get no ulimit -v (default ostrich);
#                  these get -Xmx$OSTRICH_MEM_MB m instead;
#   RESULTS_DIR    directory for the res-*.tsv files (default .).

set +e +o pipefail

solver_with_flags=$1
base=$2
timeout=$3

execut=$(echo $solver_with_flags | tr ' ' '\n' | head -n 1)
readarray -t flags < <(echo $solver_with_flags | tr ' ' '\n' | tail -n +2)
label=$(echo "$solver_with_flags" | sed -E 's|^[^ ]*/||; s/ +/_/g')
case "$execut" in
  /* | ./*) cmd="$execut" ;;
  *) cmd="./_build/default/$execut" ;;
esac

: "${CORES_PER_RUN:=2}"
: "${MEM_PER_RUN:=8192}"
: "${NO_VMEM_LIMIT:=ostrich}"
: "${OSTRICH_MEM_MB:=$MEM_PER_RUN}"
: "${RESULTS_DIR:=.}"
mkdir -p "$RESULTS_DIR"
# One logical CPU per physical core, so that no two runs share a physical core.
PCPUS=$(lscpu -p=CPU,CORE,SOCKET 2>/dev/null | grep -v '^#' |
  awk -F, '!seen[$3 "," $2]++ { print $1 }' | tr '\n' ' ')
[ -n "$PCPUS" ] || PCPUS=$(seq 0 $(($(nproc) - 1)) | tr '\n' ' ')
NPHYS=$(wc -w <<<"$PCPUS")
: "${JOBS:=$((NPHYS / (CORES_PER_RUN > 0 ? CORES_PER_RUN : 1)))}"
[ "$JOBS" -ge 1 ] || JOBS=1

export timeout cmd label CORES_PER_RUN MEM_PER_RUN NO_VMEM_LIMIT OSTRICH_MEM_MB PCPUS
export FLAGS="${flags[*]}"

run_one() {
  local i="$1" slot="$2" suite="$3"
  local flags pcpus
  read -ra flags <<<"$FLAGS"
  read -ra pcpus <<<"$PCPUS"
  local tmp tfile
  tmp="$(mktemp)"
  tfile="$(mktemp)"
  local pin=""
  if [ "$CORES_PER_RUN" -gt 0 ]; then
    local a=$(((slot - 1) * CORES_PER_RUN))
    if [ $((a + CORES_PER_RUN)) -le "${#pcpus[@]}" ]; then
      pin="taskset -c $(
        IFS=,
        echo "${pcpus[*]:a:CORES_PER_RUN}"
      )"
    fi
  fi
  local xmx=()
  if [[ "$cmd" =~ $NO_VMEM_LIMIT ]] && [ "$OSTRICH_MEM_MB" -gt 0 ]; then
    xmx=("-Xmx${OSTRICH_MEM_MB}m")
  fi
  local t0 t1
  t0=$(date +%s.%N)
  set -m
  (
    if [ "$MEM_PER_RUN" -gt 0 ] && ! [[ "$cmd" =~ $NO_VMEM_LIMIT ]]; then
      ulimit -v $((MEM_PER_RUN * 1024))
    fi
    local timecmd=()
    [ -x /usr/bin/time ] && timecmd=(/usr/bin/time -q -o "$tfile" -f '%U %S %M')
    exec $pin "${timecmd[@]}" \
      timeout -k 2 -s SIGINT "$timeout" "$cmd" "${xmx[@]}" "${flags[@]}" "$i"
  ) >"$tmp" 2>&1 &
  local pid=$!
  wait "$pid"
  local res=$?
  t1=$(date +%s.%N)
  kill -9 -"$pid" 2>/dev/null
  set +m
  local verdict stage="" line=""
  if [ "$res" -eq 124 ] || [ "$res" -eq 137 ]; then
    verdict=timeout
  else
    line=$(grep -m1 -E '^(sat|unsat|unknown|timeout)' "$tmp")
    case "$line" in
      sat*) verdict=sat ;;
      unsat*) verdict=unsat ;;
      timeout*) verdict=timeout ;;
      *) verdict=unknown ;;
    esac
    stage=$(sed -nE 's/^(sat|unsat|unknown) \((.*)\)[[:space:]]*$/\2/p' <<<"$line")
  fi
  local u s m
  read -r u s m < <(tail -n 1 "$tfile")
  local cpu wall
  wall=$(awk -v a="$t0" -v b="$t1" 'BEGIN { printf "%.3f", b - a }')
  if [[ "$u" =~ ^[0-9.]+$ && "$s" =~ ^[0-9.]+$ ]]; then
    cpu=$(awk -v u="$u" -v s="$s" 'BEGIN { printf "%.2f", u + s }')
  else
    cpu=NA
    m=NA
  fi
  printf '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n' \
    "$label" "$suite" "$i" "$verdict" "$stage" "$wall" "$cpu" "${m:-NA}" "$res"
  rm -f "$tmp" "$tfile"
}
export -f run_one

for suite in $(find $base -type d | sort | awk '$0 !~ last "/" {print last} {last=$0} END {print last}'); do
  suitename=$(sed 's/\.//g' <<<${suite:${#base}+1} | sed 's/\///g')
  [ -n "$suitename" ] || suitename=$(basename "$base" | sed 's/\.//g')
  suitefile="$RESULTS_DIR/res-$label-$suitename.tsv"
  START_TIME=$(date +%s)
  printf '%s\n' "$suite"/*.smt2 |
    parallel --will-cite --keep-order -j "$JOBS" run_one {} {%} "$suitename" |
    tee "$suitefile"
  END_TIME=$(date +%s)
  echo "Suite $suitename: $label finished in $((END_TIME - START_TIME)) s ($JOBS parallel runs, CPUs ${PCPUS% })"
done

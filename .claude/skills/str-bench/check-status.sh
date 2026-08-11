#!/bin/sh
# Run chro.exe on one .smt2 file and compare against its (set-info :status ...).
# Prints one TSV line: verdict, expected, actual, seconds, file.
# Verdicts: OK (statuses agree), WRONG (sat/unsat disagreement -- soundness bug!),
#           UNKNOWN (solver answered unknown), TIMEOUT, ERROR (crash/parse),
#           NOSTATUS (benchmark carries no :status annotation).
# Usage: check-status.sh [-t SECONDS] file.smt2
# Env: CHRO_BIN overrides the solver binary (for A/B runs against a saved baseline).
TIMEOUT_S=10
if [ "$1" = "-t" ]; then TIMEOUT_S="$2"; shift 2; fi
f="$1"
root="$(cd "$(dirname "$0")/../../.." && pwd)"
chro="${CHRO_BIN:-$root/_build/default/bin/chro.exe}"

# The value may sit on the line after "(set-info :status", so match across newlines.
expected=$(tr '\n' ' ' < "$f" | grep -m1 -o ':status  *[a-z]*' | awk '{print $2}')
[ -z "$expected" ] && expected=nostatus

start=$(perl -MTime::HiRes=time -e 'printf "%.3f", time')
out=$(timeout "${TIMEOUT_S}s" "$chro" "$f" 2>/dev/null)
code=$?
dur=$(perl -MTime::HiRes=time -e "printf '%.2f', time - $start")
out=$(printf '%s\n' "$out" | head -1)
if [ $code -eq 124 ]; then
  actual=timeout
else
  case "$out" in
    unsat*) actual=unsat ;;
    sat*) actual=sat ;;
    unknown*) actual=unknown ;;
    *) actual=error ;;
  esac
fi

case "$expected:$actual" in
  nostatus:*) verdict=NOSTATUS ;;
  *:timeout) verdict=TIMEOUT ;;
  *:unknown) verdict=UNKNOWN ;;
  *:error) verdict=ERROR ;;
  sat:sat | unsat:unsat) verdict=OK ;;
  unknown:*) verdict=OK ;;
  *) verdict=WRONG ;;
esac
printf '%s\t%s\t%s\t%s\t%s\n' "$verdict" "$expected" "$actual" "$dur" "$f"

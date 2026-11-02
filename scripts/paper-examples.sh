#!/usr/bin/env bash
# Run the solvers on the three examples that the paper discusses outside the
# tables (examples/paper), with the timeout of the paper (60 s):
#   swine-refinement.smt2  7x + 3 = 2^y (Sect. 6): SwInE gives no answer within
#                          60 s, Chrobelias answers unsat at once;
#   huge-model.smt2        z >= x + 2^x + 2^(2^x), x >= 100 (Sect. 4): Chrobelias
#                          answers sat with "no short model", SwInE unknown
#                          (exponent-overflow);
#   string-template.smt2   the template of REln/RElnC (Sect. 6): of the compared
#                          solvers only OSTRICH decides it within 60 s,
#                          Chrobelias needs less than 1 s.
# Prints: example  solver  first output line  wall time.
set +e
: "${CHRO:=./release/chro}"
: "${TIMEOUT:=60}"
B=./_build/default/bin
run() {
  local name=$1 file=$2; shift 2
  local t0 out
  t0=$(date +%s.%N)
  out=$(timeout -k 2 "$TIMEOUT" "$@" "$file" 2>&1 |
    grep -E '^(sat|unsat|unknown)|no short model|reason-unknown' | head -2 | tr '\n' ' ')
  printf '%-22s %-11s %-50s %6.1f s\n' "$(basename "$file" .smt2)" "$name" "${out:-(no answer)}" \
    "$(awk -v a="$t0" -v b="$(date +%s.%N)" 'BEGIN { print b - a }')"
}
for f in examples/paper/swine-refinement.smt2 examples/paper/huge-model.smt2; do
  run chro "$f" "$CHRO" -q
  run swine "$f" $B/swine
done
f=examples/paper/string-template.smt2
run chro "$f" "$CHRO" -q
for s in cvc5 ostrich2 z3 z3-noodler; do run "$s" "$f" $B/$s; done

#!/usr/bin/env bash
# Check the models of the sat answers of Chrobelias with Z3 (the model sentence
# of Sect. 6 of the paper).
#
#   scripts/check-models-z3.sh RESULTS_DIR [JOBS]
#
# Takes every problem of Hash2, REln (1-3 variables), RElnC and Sierpinski that
# RESULTS_DIR/res-chro_-q-*.tsv answers sat, runs "$CHRO -q" on it again with
# (get-model), and checks the model with scripts/check_models_z3.py: Z3 checks
# the string problems with the model added as equalities, and the Sierpinski
# models (one integer variable, powers of 2) are evaluated exactly.
# Every Chrobelias run and every Z3 run gets 60 s and MEM_PER_RUN MB.
# Writes RESULTS_DIR/check-models-z3.tsv:  file  answer  result
# result: ok, WRONG (the model violates the formula), huge (sat with
# "no short model"), not-sat (no sat answer in this run: timeout or memory
# limit), no-model, or unchecked (Z3 gave no answer in time).
# Prints the counts per set; exit status 1 if there is a WRONG line.
set +e
rdir=$1
jobs=${2:-$(($(nproc) / 2))}
: "${CHRO:=./release/chro}"
: "${Z3:=./_build/default/bin/z3}"
: "${MEM_PER_RUN:=8192}"
export CHRO Z3 MEM_PER_RUN TIMEOUT=60

check_one() {
  (
    ulimit -v $((MEM_PER_RUN * 1024))
    python3 scripts/check_models_z3.py "$CHRO" "$1"
  ) || printf '%s\t?\tcrashed\n' "$1"
}
export -f check_one

cat "$rdir"/res-chro_-q-*.tsv |
  awk -F'\t' '$4 == "sat" && $3 ~ /QF_SLIA\/Hash2\/|QF_SLIA\/StrRElnc\/|QF_EIA\/SIERPINSKI\// { print $3 }' |
  grep -v '_v[4-9]_' | sort -u |
  parallel --will-cite -j "$jobs" check_one {} >"$rdir/check-models-z3.tsv"
awk -F'\t' '{ s = $1 ~ /SIERPINSKI/ ? "Sierpinski" : $1 ~ /Hash2/ ? "Hash2" : $1 ~ /\/RElnc[-\/]/ ? "RElnC" : "REln";
              n[s "\t" $3]++; t[$3]++ }
  END { for (k in n) print k "\t" n[k]; for (k in t) print "all\t" k "\t" t[k] }' \
  "$rdir/check-models-z3.tsv" | sort
grep -P '\tWRONG$' "$rdir/check-models-z3.tsv" && exit 1
exit 0

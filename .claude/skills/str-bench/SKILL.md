---
name: str-bench
description: Run the string (QF_SLIA) benchmark suites against chro.exe and check answers against the expected :status. Use after changes to the simplifier (SimplII), string solver, regex/NFA code, or unsat-core extraction to catch soundness bugs (WRONG) and completeness/performance regressions (TIMEOUT/UNKNOWN deltas).
---

# String benchmark regression runs

Sweeps a benchmark suite with `chro.exe`, compares each answer against the
`(set-info :status ...)` annotation inside the file, and summarizes verdicts.

## Prerequisites

```sh
dune build            # the runner uses ./_build/default/bin/chro.exe
```

GNU parallel is required (`/opt/homebrew/bin/parallel`, 12 cores on this machine — use `-j10`).

## Running a sweep

`check-status.sh` (in this skill's directory) runs one file and prints a TSV line:
`VERDICT  expected  actual  seconds  file`.
The solver defaults to `./_build/default/bin/chro.exe`; set `CHRO_BIN=/path/to/chro.exe`
to run a saved snapshot instead (see the A/B recipe below).

```sh
# Single file, default 10s timeout (use -t SECONDS to override):
.claude/skills/str-bench/check-status.sh path/to/file.smt2

# Full sweep of a suite (results file goes to the scratchpad or results/):
parallel -j10 .claude/skills/str-bench/check-status.sh \
  ::: benchmarks/chrobelias/QF_SLIA/stringfuzzregex/transformed/z3str2/regex-0*.smt2 \
  > results.tsv 2>/dev/null

# Summary:
cut -f1 results.tsv | sort | uniq -c

# The failures, if any:
grep -v '^OK' results.tsv
```

Glob patterns must exclude `*.bak` files (a plain `*.smt2` glob already does).
Run big sweeps in the background; ~7000 small instances take roughly 5–10 min at `-j10`.

## Verdicts

- **WRONG** — solver said sat where the file says unsat or vice versa. This is a
  soundness bug: stop and investigate immediately (typical culprits: unsat-core
  extraction feeding bad DPLL blocking clauses, unsound simplifier rewrites).
- **TIMEOUT / UNKNOWN** — not bugs by themselves; compare *counts* against a
  baseline run. A jump means a completeness or performance regression.
  **Caveat:** UNKNOWN is load-sensitive — chro's internal Z3 calls run with
  their own timeouts, and under `parallel -j10` contention a normally-sat
  instance can come back unknown. Before treating an OK→UNKNOWN flip as a
  regression, re-run those files *sequentially*; only reproducible flips count.
- **ERROR** — crash or parse failure; inspect by running `chro.exe` on the file directly.
- **NOSTATUS** — benchmark has no `:status` annotation; ignore or check manually.

## A/B benchmarking a change

Snapshot both binaries first so branch state can't drift mid-run, then sweep
each under identical settings (same `-j`, same timeout, ideally back-to-back):

```sh
cp _build/default/bin/chro.exe /tmp/chro-after.exe
git stash push lib/... && dune build && cp _build/default/bin/chro.exe /tmp/chro-before.exe
git stash pop && dune build

CHRO_BIN=/tmp/chro-before.exe parallel -j10 .claude/skills/str-bench/check-status.sh ::: FILES > before.tsv
CHRO_BIN=/tmp/chro-after.exe  parallel -j10 .claude/skills/str-bench/check-status.sh ::: FILES > after.tsv
```

Compare per-file verdicts (columns: verdict, expected, actual, seconds, file):

```sh
join -t$'\t' -j5 -o 0,1.1,2.1,1.4,2.4 \
  <(sort -t$'\t' -k5 before.tsv) <(sort -t$'\t' -k5 after.tsv) \
  | awk -F'\t' '$2 != $3'                     # verdict flips
awk -F'\t' '{s+=$4} END {print s}' before.tsv  # total solver seconds (same for after.tsv)
```

Files that moved OK→TIMEOUT are regressions; TIMEOUT→OK are wins. Verdict
flips must be re-verified sequentially before being believed (see the UNKNOWN
caveat above). For time deltas, ignore sub-second jitter; look at files whose
time changed by both >1s and >2x.

## The suites

Under `benchmarks/chrobelias/QF_SLIA/` (sizes = non-.bak `.smt2` files):

| Suite | Path | Size | What it exercises |
|---|---|---|---|
| stringfuzzregex (z3str2) | `stringfuzzregex/transformed/z3str2/` | ~7000 | StringFuzz-transformed regex + str.in_re; the usual smoke set is `regex-0*.smt2` |
| stringfuzzregex (amazon) | `stringfuzzregex/transformed/amazon/` | rest of 11618 | industrial regex membership |
| stringfuzzregex (generated) | `stringfuzzregex/generated/` | manyregexes, regexbig, regexdeep, regexlengths, regexpair, regexsmall | synthetic regex stress |
| StrRElnc | `StrRElnc/` | 1260 | string-regex-length relations |
| 2025-generated-strreln | `2025-generated-strreln/` | 940 | generated string relations |
| HashFunction | `HashFunction/` | 600 | str.to_int-heavy hash constraints (also `benchmarks/EXP-solver/Benchmark/HashFunction/`) |

Full SMT-LIB QF_SLIA lives in `benchmarks/qf-slia-smtlib25/QF_SLIA/` (e.g.
`2019-full_str_int`, `20230327-stringfuzz-lu`, `2015-Norn`, ...) — much bigger;
use for deeper validation, not smoke tests.

Suggested tiers:
- **Smoke** (after any simplifier/string change): `stringfuzzregex/transformed/z3str2/regex-0*.smt2`
- **Standard**: all of `benchmarks/chrobelias/QF_SLIA/stringfuzzregex/` + `StrRElnc` + `HashFunction`
- **Deep**: add `benchmarks/qf-slia-smtlib25/QF_SLIA/2019-full_str_int` with a 60s timeout
  (the historical baseline of that run is `full-str-int.txt` at the repo root, produced by `run-parallel.sh`)

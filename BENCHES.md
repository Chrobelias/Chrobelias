# Chrobelias: TACAS 2027 Artifact

Artifact of the tool paper "Chrobelias: SMT-Solver for Exp-Linear Integer
Arithmetic and String Constraints" by Georgii Belianin and Mikhail Starchak
(TACAS 2027).

* Artifact (Zenodo): https://doi.org/10.5281/zenodo.23369563
* Docker image (Docker Hub): https://hub.docker.com/r/chrobelias/chrobelias-evaluation
  (`chrobelias/chrobelias-evaluation:1.2.4`, the same image as on Zenodo)
* Source code: https://github.com/Chrobelias/Chrobelias (release `v1.2.4`)
* Benchmarks: https://github.com/Chrobelias/benchmarks
* Badges applied for: **Available**, **Functional**, **Reusable**

Chrobelias is an SMT-solver for quantifier-free 
exponential integer arithmetic (`QF_EIA`) and for the quantifier-free formulas of linear integer arithmetic and strings (`QF_SLIA`). The paper compares it with SwInE on `QF_EIA` benchmarks and with cvc5, OSTRICH, Z3 and Z3-Noodler on `QF_SLIA` benchmarks (Sect. 6, Tables 1–3). The artifact is a Docker image with all these solvers, all benchmark sets, and the scripts that run the experiments and make the tables.

## 1. Contents

| File on Zenodo | Contents |
|---|---|
| `chrobelias-evaluation-1.2.4.tar.gz` | the Docker image `chrobelias/chrobelias-evaluation:1.2.4` (x86-64), also on Docker Hub |
| `chrobelias-evaluation-1.2.4.tar.gz.sha256` | its checksum |
| `README.md`, `LICENSE` | this file, the licenses |
| `chrobelias-1.2.4-src.tar.gz`, `chrobelias-1.2.2-src.tar.gz` | the source code of Chrobelias |
| `paper-results.tar.gz` | the raw results: `paper-results/` (the runs reported in the paper), `reference-1.2.3/` and `reference-1.2.4/` (our runs, see [Section 6](#6-claims-of-the-paper)); the first two are also in the image |

The image contains, in its working directory `/Chrobelias`:

* `release/chro`: Chrobelias 1.2.4; `release/chro-1.2.2`: the version named in
  the paper;
* `_build/default/bin/`: SwInE 0.2.0 (`swine`), cvc5 1.4.0, OSTRICH 2.1
  (`ostrich2`), Z3 5.1.0, Z3-Noodler 1.7.0, the same binaries as in the
  paper's runs;
* `benchmarks/chrobelias/`: the benchmark sets `QF_EIA/{SIERPINSKI,PURRS,LoAT}`
  and `QF_SLIA/{Hash2,StrRElnc,stringfuzz,FullStrInt}`;
* `bench.sh`, `smoke-test.sh`, `.github/workflows/run-benchmarks.sh`: the
  benchmark runner (manual: `BENCHES.md`);
* `scripts/`: tables, checks and statistics;
* `examples/paper/`: the three examples that the paper discusses outside the
  tables;
* `paper-results/` (see its `README.md`) and `reference-1.2.3/`: raw results
  (`reference-1.2.4/` is only in `paper-results.tar.gz`).

## 2. Requirements and Tested Platforms

* An x86-64 (amd64) Linux host with Docker. No network access is needed after
  loading or pulling the image. On arm64 hosts (e.g. Apple Silicon) Docker runs
  the image under emulation, which is much slower, so more problems reach the
  timeout.
* Memory: 8 GB per parallel run.
* Disk: 2.2 GB for the loaded image (0.35 GB compressed), less than 1 GB for
  the results.
* The paper's runs: Intel Core i7-6700 (3.40 GHz, 4 cores), host Linux 5.15
  (Ubuntu 20.04 kernel), the runs inside this Docker image (Ubuntu 24.04), one
  core, 8 GB of RAM and 60 s per solver run.
* Tested on: an Intel Core Ultra 7 255U laptop (12 cores, 30 GB RAM), Debian
  13, Docker 26.1.5: build of this image, smoke test, paper examples, all
  scripts. Our reference runs: 1.2.3 on all sets (`reference-1.2.3/`) and the
  release binary of 1.2.4 on StringFuzz and RElnC (`reference-1.2.4/`), on the
  paper's machine (62 GB RAM) with earlier builds of this image containing the
  same solver binaries.

The TACAS 2027 VM does not contain Docker; to use the VM, install Docker in it
first (this needs network access), e.g. `sudo apt-get install docker.io`.

## 3. Setup (about 5 minutes)

Load the image from the Zenodo file:

```bash
sha256sum -c chrobelias-evaluation-1.2.4.tar.gz.sha256
docker load -i chrobelias-evaluation-1.2.4.tar.gz
IMG=chrobelias/chrobelias-evaluation:1.2.4
```

or pull the same image from Docker Hub (this needs network access):

```bash
docker pull chrobelias/chrobelias-evaluation:1.2.4
IMG=chrobelias/chrobelias-evaluation:1.2.4
```

Run all commands below in an empty directory whose path has no spaces. The
container writes its output to the mounted subdirectories (`results`, `stats`,
`tables`). It runs as root, so on Linux take the files back with
`sudo chown -R "$USER" results stats tables`.

## 4. Smoke Test (about 8 minutes)

1. Every solver on the first 3 problems of every suite, with a 1 s timeout
   (about 3 minutes):

   ```bash
   docker run --rm \
     -v "$PWD/results-smoke:/Chrobelias/results-smoke" \
     -v "$PWD/stats-smoke:/Chrobelias/stats" \
     $IMG /Chrobelias/smoke-test.sh
   ls stats-smoke | wc -l          # expected: 26
   grep -l missing stats-smoke/*   # expected: no output
   ```

2. The three examples of the paper (about 4 minutes; four runs reach the 60 s
   timeout, as the paper says):

   ```bash
   docker run --rm $IMG ./scripts/paper-examples.sh
   ```

   Expected output (times vary):

   ```
   swine-refinement       chro        unsat (nfa)                                  0.1 s
   swine-refinement       swine       (no answer)                                 60.0 s
   huge-model             chro        sat (nfa) no short model                     2.3 s
   huge-model             swine       unknown (:reason-unknown exponent-overflow)  0.0 s
   string-template        chro        sat (nfa)                                    0.1 s
   string-template        cvc5        (no answer)                                 60.0 s
   string-template        ostrich2    sat                                          0.1 s
   string-template        z3          (no answer)                                 60.1 s
   string-template        z3-noodler  (no answer)                                 60.0 s
   ```

## 5. Reproducing the Results

The full run takes about 115 CPU hours on the paper's machine, most of them
spent by cvc5, OSTRICH and Z3. The subset below takes about 6 hours with 4
parallel runs.

### 5.1 Subset (about 6 hours with 4 parallel runs)

Chrobelias, SwInE and Z3-Noodler run on all problems of the tables; cvc5,
OSTRICH and Z3 run on every 10th problem of every suite (`SAMPLE=10`). On the
paper's machine this is about 11 + 10 CPU hours. With 4 cores and 32 GB of RAM:

```bash
COMMON="--memory=32g --memory-swap=32g -e CORES_PER_RUN=1 -e JOBS=4 -e MEM_PER_RUN=8192
  -e CHRO_BENCHMARKS=SIERPINSKI,PURRS,LoAT,Hash2,StrRElnc,stringfuzz
  -v $PWD/results:/Chrobelias/results -v $PWD/stats:/Chrobelias/stats"
docker run --rm $COMMON -e CHRO_SOLVERS='chro,swine,z3-noodler' $IMG
docker run --rm $COMMON -e CHRO_SOLVERS='cvc5,ostrich2,bin/z3$' -e SAMPLE=10 $IMG
```

With 16 GB of RAM, change `JOBS=4` to `JOBS=2` and `32g` to `16g` in `COMMON`
(about twice the time). For shorter runs, restrict `CHRO_BENCHMARKS` or
increase `SAMPLE`.

### 5.2 Full Run (about 30 hours with 4 parallel runs)

```bash
docker run --rm $COMMON $IMG
```

This runs every solver on every problem of the tables. FullStrInt (16968
problems, not in the tables) is not included; to run it too, remove the line
`-e CHRO_BENCHMARKS=...` from `COMMON`.

### 5.3 Tables and Comparison with the Paper

```bash
RUN="docker run --rm -v $PWD/results:/Chrobelias/results -v $PWD/tables:/Chrobelias/tables $IMG"
$RUN python3 scripts/make_tables.py tables results         # Tables 1 and 3, tables/*.tex, summary.csv
$RUN python3 scripts/stages_table.py results               # Table 2
$RUN python3 scripts/stages_table.py --subsets results     # Table 2 per subset, with all stages
$RUN python3 scripts/compare_runs.py reference-1.2.3 results                       # Chrobelias: your run vs ours (1.2.3)
$RUN python3 scripts/compare_runs.py paper-results/2026-10-13-all-solvers results  # the other solvers: your run vs the paper's
$RUN python3 scripts/check_results.py results .            # disagreements between solvers
```

* `make_tables.py` writes `table-eia.tex` (Table 1), `table-slia.tex` (Table 3,
  REln and RElnC summed over the number of variables),
  `table-reln-vars.tex` (REln and RElnC per number of variables, as in
  Table 3) and `summary.csv` (one line per solver and subset). The files also
  contain the problems with 4 variables, which the paper does not use (REln: 1–3
  variables, RElnC: 2–3).
* `compare_runs.py` compares two runs on the problems that occur in both, so a
  `SAMPLE=10` run is compared with the same problems of the other run. For
  every solver and subset it prints the sat/unsat counts of both runs, the
  problems solved in only one of them, and the contradictions (sat in one run,
  unsat in the other), which must be 0.
* Raw results: `paper-results/2026-10-13-all-solvers/` is the run that gives
  the columns of the other solvers and the StringFuzz numbers of Chrobelias
  (Chrobelias 1.2.0 in that run); the other rows of Chrobelias come from reruns
  with 1.2.2, of which only the per-suite counts were kept
  (`paper-results/2026-10-16-chrobelias-1.2.2-counts/`). For Chrobelias,
  compare your run with `reference-1.2.3/` and, on StringFuzz, with
  `reference-1.2.4/paper-machine-stringfuzz/` from `paper-results.tar.gz`
  (mount it, e.g. `-v $PWD/reference-1.2.4:/Chrobelias/reference-1.2.4`). Against
  `2026-10-13-all-solvers/`, REln `benchmark_hard_v2_w03_n24` shows up as a
  contradiction: 1.2.0 answered it wrongly (sat), which 1.2.2 fixed.

### 5.4 Model Checks

```bash
docker run --rm -v "$PWD/results:/Chrobelias/results" $IMG ./scripts/check-models-z3.sh results 4
docker run --rm -v "$PWD/results:/Chrobelias/results" $IMG ./scripts/check-models.sh results 4
```

* `check-models-z3.sh` (about 15 minutes with 2 parallel runs on our laptop)
  runs Chrobelias again with `(get-model)` on every sat answer on Hash2, REln,
  RElnC and Sierpiński and checks the model: Z3 checks the string models (the
  model added as equalities); the Sierpiński models (one integer variable,
  powers of 2 with huge exponents) are evaluated exactly in Python. The
  results go to `results/check-models-z3.tsv`: `ok`, `WRONG` (must not occur),
  `huge` (sat with `no short model`), `no-model` (the model construction did
  not finish, e.g. it exceeded the memory limit), `not-sat` (the rerun gave no
  sat answer, e.g. a timeout), `unchecked` (Z3 gave no answer in time).
* `check-models.sh` uses Chrobelias's own `--check-model` on every sat answer
  of every set; there must be no `FAILED` line.

### 5.5 Statistics of the Benchmark Sets

```bash
docker run --rm $IMG python3 scripts/set_stats.py stringfuzz benchmarks/chrobelias/QF_SLIA/stringfuzz
docker run --rm $IMG python3 scripts/set_stats.py fullstrint benchmarks/chrobelias/QF_SLIA/FullStrInt
docker run --rm $IMG python3 scripts/set_stats.py purrs benchmarks/chrobelias/QF_EIA/PURRS
```

## 6. Claims of the Paper

Sect. 6 unless stated otherwise. The last column shows our runs on the
paper's machine: 1.2.4 on StringFuzz (`reference-1.2.4/`), 1.2.3 on the other
sets (`reference-1.2.3/`). The change of 1.2.4 (#291, Section 7) concerns only
string models built after the arithmetization of regular constraints; on RElnC,
1.2.4 gives the same numbers as 1.2.3 (419/148/271/104). Numbers
near the 60 s timeout vary between runs (see
[Section 7](#7-differences-from-the-paper)); a contradiction between two runs or
two solvers would be a real difference.

| # | Claim | Check with | Paper | Ours |
|---|---|---|---|---|
| 1 | Table 1, Chrobelias sat/unsat: Sierpiński Standard, Big, 250; LoAT; PURRS | `make_tables.py` (`table-eia.tex`) | 66/25, 53/31, 5/2; 1951/2665; 0/13 | 66/25, 54/31, 5/2; 1953/2665; 0/13 |
| 2 | Table 3, all rows | `make_tables.py` (`table-slia.tex`, `table-reln-vars.tex`) | Table 3 | as in Table 3, except Chrobelias on Hash2 *gen long* 38/14 (paper 37/14), StringFuzz 6335/5253 (6338/5253), REln 3 variables *z3-hard* 8/27 (8/28) |
| 3 | Table 2, solved / before / after the arithmetization / NFA Solver | `stages_table.py` | Sierpiński 182/–/–/98, LoAT 4616/–/–/14, PURRS 13/–/–/0, Hash2 460/242/218/218, StringFuzz 11591/4956/6635/6, REln 713/236/477/337, RElnC 419/148/271/104 | 183/–/–/99, 4618/–/–/14, 13/–/–/0, 461/242/219/219, 11588/4907/6681/7, 712/235/477/337, 419/148/271/104 |
| 4 | No answer of Chrobelias contradicts another solver | `check_results.py` | no conflict | no conflict, no `:status` contradiction |
| 5 | Z3 confirms the models on Hash2, REln, RElnC, Sierpiński, except answers with only huge models, model construction over 8 GB, or a timeout | `check-models-z3.sh` | 711 ok, 6 huge, 3 no-model, 1 not-sat | 713 ok, 6 huge, 2 no-model, 2 not-sat, 0 WRONG (1.2.3, our laptop) |
| 6 | LoAT: the NFA Solver decides 14 problems; the unsolved ones are NIA formulas not decided by Z3 in 60 s | `stages_table.py --subsets`; `CHRO_DEBUG=chro ./release/chro -q FILE 2>&1 \| grep 'Non linear'` shows that a problem reaches the NIA check | 14; 11 unsolved | 14; 9 unsolved |
| 7 | PURRS: Chrobelias 13 vs SwInE 31; the 24 unsolved problems lie outside ELIA | `set_stats.py purrs` | every problem not solved by Chrobelias has a reason other than `ELIA` | the same |
| 8 | Sierpiński: sat and unsat vs SwInE; answers of the NFA Solver; its sat answers on Big | `stages_table.py --subsets` | 124 vs 55, 58 vs 29; 98 of 182; 36 of 53 | 125 vs 55, 58 vs 29; 99 of 183; 37 of 54 |
| 9 | SwInE gives no answer on 7x+3=2^y within 60 s, Chrobelias answers unsat at once; on the example of Sect. 4, Chrobelias answers sat with `no short model`, SwInE unknown (`exponent-overflow`) | `paper-examples.sh` | as stated | as stated (smoke test) |
| 10 | On the template of REln/RElnC only OSTRICH decides within 60 s; Chrobelias needs less than 1 s | `paper-examples.sh` | as stated | as stated (smoke test) |
| 11 | StringFuzz: regular constraints in all problems, length constraints in 46%, `str.to_int` in 14%; 57% decided after the arithmetization | `set_stats.py stringfuzz`; claim 3 | 100%, 45.9%, 13.8%; 57% | the same; 57.5% |
| 12 | StringFuzz: problems Chrobelias leaves unsolved; of its answers after the arithmetization, those of Simpl (Int) and Under exp, and of the NFA Solver | `stages_table.py --subsets` | 27; 6580 and 6 of 6635 | 30; 6625 and 7 of 6681 |
| 13 | Hash2: solved vs cvc5; answers after the arithmetization, all from the NFA Solver; sat on original, gen, z3-hard, and how many from the string underapproximation; z3-hard unsat; long; gen long | Table 3; `stages_table.py --subsets` | 460 vs 332; 218; 147, 87, 61, 235 of 295; 39; 61; 51 | 461 vs 332; 219; 147, 87, 61, 235 of 295; 39; 61; 52 |
| 14 | REln and RElnC: solved; before the arithmetization; from the NFA Solver; NFA Solver on REln z3-hard; REln with 3 variables: unsolved, and sat answers on random from the string underapproximation | `table-reln-vars.tex`; `stages_table.py --subsets` | 713 and 419; 236 and 148; 337 and 104; 228 of 234; 70 of 180, 32 of 36 | 712 and 419; 235 and 148; 337 and 104; 227 of 233; 71 of 180, 31 of 36 |
| 15 | FullStrInt: Chrobelias solves N of 16968, M of them after the arithmetization | `stages_table.py reference-1.2.3` (row FullStrInt) | 12053, 810 (6.7%; measured with 1.1.4) | 12049, 830 (6.9%) |
| 16 | FullStrInt: 99% contain `str.at` or `str.substr`; the only regular constraints are Σ₁₀⁺ and {0,1}⁺; 86 problems compare `str.to_int` with a non-constant term | `set_stats.py fullstrint` | as stated | 99.1%; `(re.+ (re.range "0" "9"))`, `(re.+ (re.range "0" "1"))`; 86 (all with `str.len`) |

The statements on the other solvers in the text (e.g. "Z3 solves 48 of them
in 60 s" on Hash2 z3-hard, "Z3 solves 23 of the 150" on RElnC z3-hard) are
their numbers in Table 3. Their FullStrInt numbers ("the others solve
15660–16946") come from an earlier run that is not in `paper-results/`; a full
run including FullStrInt (Section 5.2) gives them.

## 7. Differences from the Paper

**Version.** The paper names Chrobelias 1.2.2; the artifact runs the release
1.2.4 (commit `a18365848`), which fixes three problems of 1.2.2:

* [#288](https://github.com/Chrobelias/Chrobelias/pull/288): models from the
  `nia` stage printed the variables eliminated by the presimplification as 0,
  and the integer underapproximation replaced integer constants whose
  absolute value exceeds 2^62 by a power of the base. The first affects only models; the second applied to 2
  RElnC problems of the paper's sets, with the same answers in 1.2.2 and 1.2.3.
  With 1.2.2, `check-models.sh` reports 23–25 `FAILED` models on LoAT; with
  1.2.3 none.
* [#289](https://github.com/Chrobelias/Chrobelias/pull/289): the arithmetization
  of large regular constraints. 1.2.0, which produced the paper's StringFuzz
  numbers, over-approximated a regular constraint whose Chrobak normal form
  needs more than 20 states and trusted its sat answers, which is unsound in
  general (e.g. x ∈ (a²³)⁺ ∧ |x| = 402). 1.2.1 and 1.2.2 compute the exact form,
  which is slow on large regular expressions: on the paper's machine 1.2.2
  leaves 179 StringFuzz problems unsolved instead of 27. 1.2.3 uses the
  over-approximation again and confirms each of its sat answers by an exact
  solve.
* [#291](https://github.com/Chrobelias/Chrobelias/pull/291) (1.2.4): the string
  models built after the arithmetization could contain the padding symbol of
  the automata. The exact check of #289 rejects such a model, so 1.2.3 solved
  some problems twice: on 52 StringFuzz *variants* problems it needs about twice
  the time of 1.2.2, and 4 of them time out on the paper's machine. 1.2.4
  solves 3 of these 4 in time.

To run 1.2.2 instead, add `-e CHRO=./release/chro-1.2.2` to a `docker run`
command; its results are labelled `chro-1.2.2_-q` instead of `chro_-q`.

**Result.** Our runs on the paper's machine are within 4 answers of the paper
in every row of Chrobelias in Tables 1–3 (Section 6), no answer contradicts
another solver or a `:status` annotation, and the only problem with sat and
unsat in different runs is the wrong sat answer of 1.2.0 (REln
`benchmark_hard_v2_w03_n24`, unsat).

**Expected differences.**

* **Timing.** Answers near the 60 s limit vary between runs and machines. Two
  runs of 1.2.2 on the paper's machine differed by 3 sat answers on Sierpiński
  Standard and 1 unsat answer on REln random with 3 variables. Chrobelias is
  more sensitive to the machine than the other solvers: it runs up to three
  strategies on its one core, and its string underapproximation has a time
  budget. For the same reason, the split of the StringFuzz answers before and
  after the arithmetization varies (4956/6635 in the paper, 4907/6681 with
  1.2.4 on the paper's machine, 5323/6270 with 1.2.3 on our laptop with 3
  parallel runs). We reran the problems on which our run of 1.2.3 and earlier
  runs differ three times with 1.2.2 and with 1.2.3; apart from the *variants*
  problems of #291, both versions gave the same outcomes in similar times.
* **Faster machines.** The LoAT problems that time out on the paper's machine
  (9 with 1.2.3: TPDB_ITS_Complexity `size02.koat_136`, `size02.koat_152`,
  `size04.koat_125`, `size04.koat_173`, `size04.koat_54`, `size09.koat_87`,
  `size09.koat_88`, `twn09.koat_0`, `twn09.koat_1`) reach the NIA check, where
  Z3 gets an NIA formula. On our laptop, 1.2.2 solved all 11 of its LoAT
  timeouts within 60 s, so a faster machine can give up to about 10 more sat
  answers on LoAT.
* **Memory.** With less than 8 GB per run, some answers of Chrobelias and of the
  string solvers become `unknown` or timeouts.
* **StringFuzz.** Against the paper, 1.2.4 has 3 sat answers fewer on the
  paper's machine: `variants/d59e9d9d` (about 40 s also with 1.2.0 and 1.2.2,
  just over 60 s there), `regexdeep/regex-deep-00014-17` (32 s with 1.2.0, over
  40 s since the exact form of 1.2.1), and `z3str2/regex-031-fuzz-rotate-translate`
  (the `regex-031` problems of *z3str2* are solved or not from run to run, in
  all versions).
* **FullStrInt.** The paper's FullStrInt numbers (claim 15) come from
  Chrobelias 1.1.4 (counts in `paper-results/fullstrint-chrobelias-1.1.4-counts/`);
  1.2.3 solves 4 problems fewer and decides 20 more after the arithmetization.

## 8. Using Chrobelias on Other Inputs (Reusable)

Chrobelias reads `.smt2` files in `QF_EIA` (exponentiation `exp` or `**`) and
the `QF_SLIA` fragment of the paper:

```bash
docker run --rm -v "$PWD:/work" $IMG ./release/chro /work/problem.smt2
docker run --rm $IMG ./release/chro -help
```

The first line of the output is `sat`, `unsat` or `unknown` with the stage
that decided it, e.g. `sat (nfa)`. Useful options: `-q` (print `unknown`
instead of an exception; used in all runs), `-no-model`, `--check-model`,
`-no-str-under`, `-no-parallel`, `-bound <n>`; tracing with
`CHRO_DEBUG=<tracer>` (see the README of Chrobelias).

**New benchmarks.** Put the `.smt2` files into a directory below `benchmarks/`
(each leaf directory is one suite) and add it to the `families` list of
`bench.sh` with the kind `eia` or `slia`, which selects the solvers. Or run a
solver on a directory directly:

```bash
mkdir -p mybench/QF_SLIA/MySet/suite1 && cp *.smt2 mybench/QF_SLIA/MySet/suite1/
docker run --rm -e RESULTS_DIR=results -v "$PWD/mybench:/Chrobelias/benchmarks/mine" \
  -v "$PWD/results:/Chrobelias/results" -v "$PWD/stats:/Chrobelias/stats" \
  $IMG ./.github/workflows/run-benchmarks.sh "./release/chro -q" benchmarks/mine/QF_SLIA/MySet 60s
```

`run-benchmarks.sh` writes `results/res-<solver>-<suite>.tsv`, one line per
problem: solver, suite, file, verdict, stage, wall time, CPU time, memory, exit
code; `stat-benchmarks.sh` summarises them. The same command runs the other
solvers (`bin/cvc5`, `bin/ostrich2`, `bin/z3`, `bin/z3-noodler`,
`bin/swine`). **New solvers** are added to `eia_solvers` or `slia_solvers` in
`bench.sh`, and to `CONFIGS` in `scripts/make_tables.py` for a column heading.

**Building from source.** `chrobelias-1.2.4-src.tar.gz` contains the OCaml
source (`lib/`: the solver, `bin/chro.ml`: the command-line tool, `tests/`:
the cram tests). It builds with OCaml 5.3 and opam (network access is needed
for the opam packages):

```bash
opam switch create 5.3.0+flambda --packages=ocaml-variants.5.3.0+options,ocaml-option-flambda --yes
opam install . --deps-only --with-test
opam exec -- dune build bin/chro.exe       # _build/default/bin/chro.exe
opam exec -- dune runtest tests lib
```

## 9. License

See `LICENSE`. Chrobelias and the scripts are under the MIT license; the other
solvers and the benchmark sets are under their own licenses, listed there.

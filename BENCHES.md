# Chrobelias benchmarking

This README describes how to reproduce the Chrobelias experiments.
They run in a Docker evaluation image that contains the static Chrobelias
release binary, the solvers it is compared with, the benchmarks, and the
scripts. The image is available on [Docker Hub][1] as
`chrobelias/chrobelias-evaluation:1.2.3`; using it is the recommended way.
It can also be [built manually](#building-the-image-manually).

## Prerequisites

The only prerequisite is Docker. To install it, follow the instructions on
the official website: https://docs.docker.com/engine/install/

The image is built for x86_64 Linux.

To fetch the image:

```bash
docker pull chrobelias/chrobelias-evaluation:1.2.2
```

Without network access, load the image from the archive on [Zenodo][2]
instead:

```bash
docker load -i chrobelias-evaluation-1.2.2.tar.gz
```

The container runs as root, so on Linux the directories it writes
(`results`, `stats`, ...) are owned by root; use `sudo chown -R "$USER" ...`
to take them back.

## Smoke tests

To run the first 3 benchmarks of each suite with every solver and a 1s timeout:

```bash
docker run --rm \
  -v "$PWD/results-smoke:/Chrobelias/results-smoke" \
  -v "$PWD/stats-smoke:/Chrobelias/stats" \
  chrobelias/chrobelias-evaluation:1.2.2 /Chrobelias/smoke-test.sh
```

To check that every solver has run on every benchmark family (2 solvers on
3 `QF_EIA` families and 5 solvers on 4 `QF_SLIA` families):

```bash
$ ls ./stats-smoke/ | wc -l
26
$ grep -l missing ./stats-smoke/*
```

The second command must print nothing.

## Benchmarking

To run all solvers on all benchmarks with the settings of the paper (one core
and 8 GB of RAM per solver, 60s timeout):

```bash
docker run --rm \
  -e CORES_PER_RUN=1 \
  -v "$PWD/results:/Chrobelias/results" \
  -v "$PWD/stats:/Chrobelias/stats" \
  chrobelias/chrobelias-evaluation:1.2.2
```

The full run takes about 150 CPU hours, most of them spent by cvc5, Z3 and
OSTRICH (about 1.6 days with `JOBS=4`, see [Resources](#resources)), not
counting `FullStrInt`.

### Output

* `results/res-<solver>-<suite>.tsv`: one line per instance:

  ```
  label  suite  file  verdict  stage  wall_s  cpu_s  maxrss_kb  exit
  ```

  `verdict` is `sat`, `unsat`, `unknown`, or `timeout`; `stage` is the part of
  Chrobelias that decided the instance (e.g. `nfa`), empty for other solvers.
* `results/environment.txt`: the machine, the settings, the commits of the
  repository and of the benchmarks, and the hashes and versions of the solver
  binaries.
* `stats/<solver>-<family>.txt`: the number of each verdict per suite.

### Choosing solvers and benchmarks

To run only some of the solvers or benchmark families, pass comma-separated
regexes in `CHRO_SOLVERS` and `CHRO_BENCHMARKS`:

```bash
# Only Chrobelias, on everything except FullStrInt:
docker run --rm -e CORES_PER_RUN=1 \
  -e CHRO_SOLVERS="chro" \
  -e CHRO_BENCHMARKS="SIERPINSKI,PURRS,LoAT,Hash2,StrRElnc,stringfuzz" \
  -v "$PWD/results:/Chrobelias/results" \
  -v "$PWD/stats:/Chrobelias/stats" \
  chrobelias/chrobelias-evaluation:1.2.2

# Only SwInE on LoAT:
docker run --rm -e CORES_PER_RUN=1 \
  -e CHRO_SOLVERS="swine" \
  -e CHRO_BENCHMARKS="LoAT" \
  -v "$PWD/results:/Chrobelias/results" \
  -v "$PWD/stats:/Chrobelias/stats" \
  chrobelias/chrobelias-evaluation:1.2.2
```

`QF_EIA` solvers:
* `chro -q` (Chrobelias)
* `swine`

`QF_EIA` benchmark families:
* `SIERPINSKI`
* `PURRS`
* `LoAT`

`QF_SLIA` solvers:
* `chro -q` (Chrobelias)
* `cvc5`
* `ostrich2`
* `z3`
* `z3-noodler`

`QF_SLIA` benchmark families:
* `Hash2`
* `StrRElnc`
* `stringfuzz`
* `FullStrInt`

### Resources

Every run is pinned to its own physical cores, and several runs are executed
in parallel. The following environment variables control this:

* `CORES_PER_RUN`: physical cores per run (default 2);
* `JOBS`: number of parallel runs (default: physical cores / `CORES_PER_RUN`);
* `MEM_PER_RUN`: MB of memory per solver process (default 8192);
* `TIMEOUT`: timeout per instance (default `60s`).

For example, to run with one core and 8 GB per solver on a machine with
4 cores and 32 GB of RAM:

```bash
docker run --rm \
  --memory=32g --memory-swap=32g \
  -e CORES_PER_RUN=1 -e JOBS=4 -e MEM_PER_RUN=8192 \
  -v "$PWD/results:/Chrobelias/results" \
  -v "$PWD/stats:/Chrobelias/stats" \
  chrobelias/chrobelias-evaluation:1.2.2
```

Make sure that `JOBS * MEM_PER_RUN` fits into the RAM of the machine, so that
the runs do not swap.

### Tables and checks

To make the result tables and plots from the `res-*.tsv` files of one or
more results directories:

```bash
docker run --rm \
  -v "$PWD/results:/Chrobelias/results" \
  -v "$PWD/tables:/Chrobelias/tables" \
  chrobelias/chrobelias-evaluation:1.2.2 \
  python3 scripts/make_tables.py tables results
```

To add the results of another run, mount its directory too and pass it after
`results` (e.g. `... tables results results-extra`). The `.tex` tables use
the macros of the paper's `macros.tex`.

To list the instances on which the solvers disagree, and the answers that
contradict the expected `(set-info :status ...)` of a benchmark:

```bash
docker run --rm \
  -v "$PWD/results:/Chrobelias/results" \
  chrobelias/chrobelias-evaluation:1.2.2 \
  python3 scripts/check_results.py results .
```

To re-run Chrobelias with `--check-model` on every instance it answered `sat`
(4 parallel jobs):

```bash
docker run --rm \
  -v "$PWD/results:/Chrobelias/results" \
  chrobelias/chrobelias-evaluation:1.2.2 \
  ./scripts/check-models.sh results 4
```

The result is written to `results/check-models.tsv`, one line per instance:
`file outcome wall_s`. The outcome `ok` means the model satisfies the formula,
and `FAILED` means it does not; there must be no `FAILED` line. The outcomes
`no-short-model` and `not-finished` (no model within the size or time limit)
are not errors.

## Building the image manually

Build the image from a fresh clone of the repository, since the whole
checkout is copied into the image:

```bash
git clone https://github.com/Chrobelias/Chrobelias.git
cd Chrobelias
git submodule update --init benchmarks/chrobelias
docker build -f docker/Dockerfile.eval --build-arg CHRO_VERSION=v1.2.2 \
  --build-arg REPO_COMMIT="$(git rev-parse HEAD)" \
  --build-arg BENCH_COMMIT="$(git -C benchmarks/chrobelias rev-parse HEAD)" \
  -t chrobelias/chrobelias-evaluation:1.2.2 .
```

The image does not contain `.git`; `REPO_COMMIT` and `BENCH_COMMIT` record the
commits in `results/environment.txt`.

`CHRO_VERSION` names the GitHub release whose static `chro` binary is put
into the image. To check the binary:

```bash
docker run --rm chrobelias/chrobelias-evaluation:1.2.2 \
  ./release/chro examples/lnr-unsat.smt2
```

The output must start with `unsat`.

To save the image for offline use:

```bash
docker save chrobelias/chrobelias-evaluation:1.2.2 |
  gzip >chrobelias-evaluation-1.2.2.tar.gz
```

[1]: https://hub.docker.com/r/chrobelias/chrobelias-evaluation
[2]: https://doi.org/10.5281/zenodo.TODO

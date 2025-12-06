[![Chrobelias][1]][2]
[![License](https://img.shields.io/badge/license-MIT-blue)](https://github.com/Chrobelias/Chrobelias/blob/master/LICENSE.md)

[1]:  https://github.com/Chrobelias/Chrobelias/actions/workflows/build-linux.yml/badge.svg
[2]:  https://github.com/Chrobelias/Chrobelias/actions

# Chrobelias - Chrobak normal form-based Exponential Linear Integer Arithmetic Solver

__ChrobELIAS__ is an smt-solver for the existential **E**xponential-**L**inear **I**nteger **A**rithmetic with regular constraints $\langle\mathbb{N}; 0, 1, +, x\mapsto 2^x, \mathscr{R}, =,\leq\rangle$.
The solver implements the decision procedure for [existential generalised Semёnov arithmetic](https://arxiv.org/abs/2306.14593)
from [Quantifier Elimination for Regular Integer Linear-Exponential Programming](https://www.ti.inf.uni-due.de/misc/lics2025/preprints/Starchak.pdf),
where Chrobak Normal Form of sub-NFAs is used to linearise exponential occurrences of the variables.

## Building
To build the project you need the following dependencies to be installed:
- OPam - OCaml package manager.
- OCaml >5.0.

The dependencies can be installed using the bash commands
```bash
# Installing OCaml package manager and OCaml 5.2.
bash -c "sh <(curl -fsSL https://opam.ocaml.org/install.sh)"
opam switch create 5.2.0+flambda --packages=ocaml-variants.5.2.0+options,ocaml-option-flambda --yes
```
ChrobELIAS is built as follows:

```bash
# Installing project dependencies.
opam install . --deps-only --with-test

# Building the project and its tests.
opam exec -- dune build @check @all
```

The executable binary is available in the `_build` dir.

## Usage

Supports `.smt2` files with 
- `QF_LIA`  extended with the binary `exp` function exponentiation. Use `(set-logic ALL)` for files with exponentiation.
- `QF_SLIA` subclass corresponding to the logic $T_{\mathit{REln}}$ from [Semënov Arithmetic, Affine VASS, and String Constraints](https://arxiv.org/abs/2306.14593).  

```bash
./_build/default/bin/chro.exe <path-to-smt2-file>
```

Simple `.smt2` files for ChrobELIAS can be found in [benchmarks](https://github.com/Chrobelias/Chrobelias/tree/main/benchmarks) and [examples](https://github.com/Chrobelias/Chrobelias/tree/main/examples).


### Examples
- `sat` problem from [TPDB_ITS_Termination](https://github.com/ffrohn/QF_EIA/tree/master/LoAT/TPDB_ITS_Termination)
```bash
./_build/default/bin/chro.exe benchmarks/QF_LIA/LoAT/TPDB_ITS_Termination/PastaC1.jar-obl-8.smt2_9.smt2
```
- `unsat` problem $x\in\mathtt{16}\cdot(\mathtt{000}\cup\mathtt{999})^{\ast}\land y\in\mathtt{9}\cdot(\mathtt{9})^{\ast}\land |x| =$ to_int $(y) + 1$
```bash
./_build/default/bin/chro.exe examples/lnr-unsat.smt2
```
- `sat` problem $x\in\mathtt{16}\cdot(\mathtt{000}\cup\mathtt{999})^{\ast}\land y\in\mathtt{9}\cdot(\mathtt{9})^{\ast}\land 9|x| =$ to_int $(y)$
```bash
./_build/default/bin/chro.exe examples/lnr-sat.smt2
```

## Publications
- M. R. Starchak. [Quantifier Elimination for Regular Integer Linear-Exponential Programming](https://ieeexplore.ieee.org/document/11186186), In _Proc. of LICS'25_, Singapore, 2025, pp. 44-56.

## Acknowledgements

We use custom SMT-lib v2.6 `exp` syntax and examples from [SwInE](https://github.com/ffrohn/swine) by [Florian Frohn](https://ffrohn.github.io/) licensed under [LGPL v2.1](https://github.com/ffrohn/swine/blob/master/LICENSE).

## Benchmarks

```bash
# Clone benchmarks
git submodule update --init

# Generate dune files with benchmarks (example: will generate benchmarks in `benchmarks/tests/QF_LIA/LoAT/TPDP_ITS_Complexity`
# See the root `Makefile` with other commands)
make genTPDB_ITS_Complexity

# Autopromote benchmarks (example)
make -C  benchmarks/tests/QF_LIA/LoAT/TPDB_ITS_Complexity

# Run a single benchmark. The output is located in `benchmarks/tests/QF_LIA/LoAT/TPDB_ITS_Complexity/a.03.koat_0.t`
dune b @benchmarks/tests/QF_LIA/LoAT/TPDB_ITS_Complexity/a.03.koat_0 --profile=benchmark 
```
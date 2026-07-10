# Parsym - SMT-solver based on parametric symbolic automata for parametric Büchi arithmetic

Supplementary Material for Submission #360

## Building the tool

### Executable binary for Linux x86-64

If you are on a Linux x86-64 architecture, you should be able to simply run the statically pre-built `parsym` executable in the current directory `tool`. See "Running the tool", below.

```bash
./parsym file.smt2
```

### Building

To build the project from source files you need first to install dependencies:

```bash

# Installing the OCaml package manager
bash -c "sh <(curl -fsSL https://opam.ocaml.org/install.sh)"
# Initializing the package manager. It might ask you to install other common dependencies (e.g. unzip)
opam init --bare
# Installing OCaml 5.3.
opam switch create 5.3.0+flambda --packages=ocaml-variants.5.3.0+options,ocaml-option-flambda --yes
```

`parsym` is built as follows:

```bash

# In the directory Parsym, initialize submodules, including the smtml library.
git submodule update --init --recursive

# Installing smtml dependencies.
opam install vendor/smtml --deps-only --with-test --with-dev-setup

# Installing parsym dependencies.
opam install . --deps-only --with-test

# Building the project and its tests.
opam exec -- dune build @check @all
```

The executable binary will then be available at `_build/default/bin/parsym.exe`.

## Running the tool

First look at the options available, running 

`./<tool> --help` 

where `<tool>` is either `parsym` or `_build/default/bin/parsym.exe`, depending on whether you had to build the tool or not. 
Several options will appear, depending on what type of problem you want to solve. 

For instance, to solve a Bounded Existence problem, in `par` mode, as described in Section 5 of the paper, run: 

`./<tool> -bmin a -bmin b -par -problem e instance.smt2` 

where `[a..b]` is the range of bases you wish to check, `-par` states the mode (avoid this option to call the tool in `sym` mode), 
and `-problem e` specifies that `instance.smt2` is an instance of an existence problem (for Bounded universality problems: `-problem u`). 


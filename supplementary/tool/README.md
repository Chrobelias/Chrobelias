# Parsym - SMT-solver based on parametric symbolic automata for parametric Büchi arithmetic

Supplementary Material for Submission #360

## Executable binary for Linux x86-64

You can simply run the statically pre-built `parsym` executable in the current directory `tool`

```bash
./parsym file.smt2
```

## Building

To build the project from source files you need first to install dependencies:

```bash

# Installing the OCaml package manager
bash -c "sh <(curl -fsSL https://opam.ocaml.org/install.sh)"
# Initializing the package manager. It might ask you to install other common dependencies (e.g. unzip)
opam init --bare
# Installing OCaml 5.3.
opam switch create 5.3.0+flambda --packages=ocaml-variants.5.3.0+options,ocaml-option-flambda --yes
```

'parsym' is built as follows:

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

The executable binary is available in the `_build` dir.
# ChrobELIAS benchmarking

This README contains information on how to run Chrobelias benchmarks.
Chrobelias experiments can be reproduced by accessing its Docker evaluation
image which is available on Dockerhub [^1].

*Note:* the image is approximately 7 GB. Make sure there is enough free space.

## Prerequisites

The only prerequisite is Docker that should be installed on your machine.
To install it follow the instructions on the official website:
https://docs.docker.com/engine/install/

## Smoke tests

To run smoke tests of Chrobelias and other solvers run the following command:

```bash
docker run --rm -it -v ./stats:/Chrobelias/stats chrobelias/chrobelias-evaluation:latest /Chrobelias/smoke-test.sh
```

This would run smoke tests, which are the first 3 benchmarks from each suite.

*Note:* executing the command for the first time may take a while, because the
        image would be fetched.

To check that each solver has executed smoke tests:

```bash
$ ls ./stats/ | wc -l
27
```

## Benchmarking

To run all benchmarks and collect all results of all solvers use the following
command:

```bash
docker run --rm -it -v ./stats:/Chrobelias/stats chrobelias/chrobelias-evaluation:latest /Chrobelias/bench.sh
```

The results will appear in the `./stats` directory.
The execution can be long due to the 60s timeout.
To run only some of the solvers/suites, provide comma-separated
regexes for the desired solvers/suites as follows:

```bash
# Run only SwInE and Chrobelias with all configurations [ ; -under-all; -bres 2 -bstates 20]:
docker run --rm -it \
  -e CHRO_SOLVERS="swine,chro.*"
  -v ./stats:/Chrobelias/stats \
  chrobelias/chrobelias-evaluation:latest /Chrobelias/bench.sh

# Run only Sierpinski EIA benchmarks:
docker run --rm -it \
  -e CHRO_BENCHMARKS="SIERPINSKI" \
  -v ./stats:/Chrobelias/stats \
  chrobelias/chrobelias-evaluation:latest /Chrobelias/bench.sh

# Run only SwInE on LoAT suites:
docker run --rm -it \
  -e CHRO_SOLVERS="swine" \
  -e CHRO_BENCHMARKS="LoAT" \
  -v ./stats:/Chrobelias/stats \
  chrobelias/chrobelias-evaluation:latest /Chrobelias/bench.sh
```

Here is the list of available `QF_EIA` solvers:
* `chro.exe -q`
* `chro.exe -q -bres 2 -bstates 20`
* `swine`

The list of `QF_EIA` benchmark suites:
* `LoAT`
* `SIERPINSKI`

The list of `QF_SLIA` solvers:
* `chro.exe -q`
* `chro.exe -q -bres 2 -bstates 20`
* `chro.exe -under-all`
* `ostrich2`
* `cvc5`
* `z3-noodler`
* `z3`

The list of `QF_SLIA` benchmark suites:
* `stringfuzz`
* `Hash2`
* `StrRElnc`

To run multiple Docker containers in parallel, limit their RAM
using the `--memory=8192m` parameter, and limit CPU usage with the `--cpus=1.0`
parameter.

## License & Acknowledgements

Please, refer to the corresponding section in [README.md](README.md).

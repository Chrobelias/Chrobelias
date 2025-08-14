.PHONY: gentests genPURSS genComplexity genTerminiation genCHCcomp22lia promote_benchmarks

all:
	dune build

test: dune test

gentests: genCHCcomp22lia genTPDB_ITS_Termination genTPDB_ITS_Complexity genPURRS

genCHCcomp22lia: DIR = QF_LIA/LoAT/CHC_Comp_22_LIA_Lin
genCHCcomp22lia:
	mkdir -p benchmarks/tests/$(DIR)
	dune exec benchmarks/gen.exe -- -ddc 5 benchmarks/$(DIR) -o benchmarks/tests/$(DIR)

genTPDB_ITS_Termination: DIR = QF_LIA/LoAT/TPDB_ITS_Termination
genTPDB_ITS_Termination:
	mkdir -p benchmarks/tests/$(DIR)
	dune exec benchmarks/gen.exe -- -ddc 5 -t 2 benchmarks/$(DIR) -o benchmarks/tests/$(DIR)

genTPDB_ITS_Complexity: DIR = QF_LIA/LoAT/TPDB_ITS_Complexity
genTPDB_ITS_Complexity:
	mkdir -p benchmarks/tests/$(DIR)
	dune exec benchmarks/gen.exe -- -ddc 5 -t 2 benchmarks/$(DIR) -o benchmarks/tests/$(DIR)

genPURRS: DIR = QF_LIA/PURRS
genPURRS:
	mkdir -p benchmarks/tests/$(DIR)
	dune exec benchmarks/gen.exe -- -ddc 4 benchmarks/$(DIR) -o benchmarks/tests/$(DIR)

promote_benchmarks:
	$(MAKE) -C benchmarks/tests/QF_LIA/LoAT/CHC_Comp_22_LIA_Lin
	$(MAKE) -C benchmarks/tests/QF_LIA/LoAT/TPDB_ITS_Complexity
	$(MAKE) -C benchmarks/tests/QF_LIA/LoAT/TPDB_ITS_Termination
	$(MAKE) -C benchmarks/tests/QF_LIA/PURRS

clean:
	dune clean


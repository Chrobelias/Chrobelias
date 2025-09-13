.PHONY: gentests genPURSS genComplexity genTerminiation genCHCcomp22lia promote_benchmarks

all:
	dune build

test: dune test

gentests: genCHCcomp22lia genTPDB_ITS_Termination genTPDB_ITS_Complexity genPURRS

genCHCcomp22lia: DIR = QF_LIA/LoAT/CHC_Comp_22_LIA_Lin
genCHCcomp22lia:
	mkdir -p benchmarks/tests/$(DIR)
	dune exec benchmarks/gen.exe -- -ddc 5 -t 2 benchmarks/$(DIR) -o benchmarks/tests/$(DIR)
	dune b @benchmarks/tests/$(DIR)/fmt --au

genTPDB_ITS_Termination: DIR = QF_LIA/LoAT/TPDB_ITS_Termination
genTPDB_ITS_Termination:
	mkdir -p benchmarks/tests/$(DIR)
	dune exec benchmarks/gen.exe -- -ddc 5 -t 2 benchmarks/$(DIR) -o benchmarks/tests/$(DIR)
	dune b @benchmarks/tests/$(DIR)/fmt --au

genTPDB_ITS_Complexity: DIR = QF_LIA/LoAT/TPDB_ITS_Complexity
genTPDB_ITS_Complexity:
	mkdir -p benchmarks/tests/$(DIR)
	dune exec benchmarks/gen.exe -- -ddc 5 -t 2 benchmarks/$(DIR) -o benchmarks/tests/$(DIR)
	dune b @benchmarks/tests/$(DIR)/fmt --au

genPURRS: DIR = QF_LIA/PURRS
genPURRS:
	mkdir -p benchmarks/tests/$(DIR)
	dune exec benchmarks/gen.exe -- -ddc 4 -t 2 benchmarks/$(DIR) -o benchmarks/tests/$(DIR)
	dune b @benchmarks/tests/$(DIR)/fmt --au

promote_benchmarks:
	$(MAKE) fast -C benchmarks/tests/QF_LIA/LoAT/CHC_Comp_22_LIA_Lin
	$(MAKE) fast -C benchmarks/tests/QF_LIA/LoAT/TPDB_ITS_Complexity
	$(MAKE) fast -C benchmarks/tests/QF_LIA/LoAT/TPDB_ITS_Termination
	$(MAKE) fast -C benchmarks/tests/QF_LIA/PURRS

clean:
	dune clean

.PHONY: coverage
TEST_COV_D ?= /tmp/Chrobelias_cov
COVERAGE_FLAGS += --expect src/ --expect bin/ --do-not-expect vendor/ --do-not-expect bin/ --do-not-expect vendor/smtml/src/smtml
coverage:
	if [ -d $(TEST_COV_D) ]; then $(RM) -r $(TEST_COV_D); fi
	mkdir -p $(TEST_COV_D)
	BISECT_FILE=$(TEST_COV_D)/Chrobelias dune b bin @lib/runtest @tests/runtest \
		--no-print-directory \
		--instrument-with bisect_ppx --force
	bisect-ppx-report html --coverage-path $(TEST_COV_D) $(COVERAGE_FLAGS)
	bisect-ppx-report summary --coverage-path $(TEST_COV_D) $(COVERAGE_FLAGS)
	@echo "Use 'xdg-open _coverage/index.html' to see coverage report"

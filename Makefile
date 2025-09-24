.PHONY: gentests genPURSS genComplexity genTerminiation genCHCcomp22lia promote_benchmarks
.PHONY: gen-tests-string

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

define ADD_STRING_BENCH
#gen$(1): DIR = QF_SLIA/$(2)
gen$(1):
	mkdir -p benchmarks/tests/QF_SLIA/$(2)
	dune exec benchmarks/gen.exe -- -ddc $(3) -t 2 benchmarks/QF_SLIA/$(2) -o benchmarks/tests/QF_SLIA/$(2)
	dune b @benchmarks/tests/QF_SLIA/$(2)/fmt --au || exit 0
gen-tests-string: gen$(1)
promote_benchmarks_string_$(1):
	$$(MAKE) -C benchmarks/tests/QF_SLIA/$(2)
promote_benchmarks_string: promote_benchmarks_string_$(1)
endef
$(eval $(call ADD_STRING_BENCH,Kepler,2018-Kepler,4))
$(eval $(call ADD_STRING_BENCH,Denghang,20230329-denghang,4))
$(eval $(call ADD_STRING_BENCH,Woorpje,20230329-woorpje-lu/track05,5))
$(eval $(call ADD_STRING_BENCH,Matching,20250410-matching,4))

$(eval $(call ADD_STRING_BENCH,Norn-ab,2015-Norn/ab,5))
$(eval $(call ADD_STRING_BENCH,Norn-ChunkSplit,2015-Norn/ChunkSplit,5))
$(eval $(call ADD_STRING_BENCH,Norn-HammingDistance,2015-Norn/HammingDistance,5))
$(eval $(call ADD_STRING_BENCH,Norn-Levenshtein,2015-Norn/Levenshtein,5))
$(eval $(call ADD_STRING_BENCH,Norn-StringReplace,2015-Norn/StringReplace,5))

$(eval $(call ADD_STRING_BENCH,leetcode_int-add_binary,2019-full_str_int/py-conbyte_cvc4/leetcode_int-add_binary,6))

$(eval $(call ADD_STRING_BENCH,redos-sat,20240411-redos_attack_detection/sat,5))
$(eval $(call ADD_STRING_BENCH,redos-unsat,20240411-redos_attack_detection/unsat,5))

$(eval $(call ADD_STRING_BENCH,stringfuzz-gen-manyregexes,20230327-stringfuzz-lu/generated/manyregexes,6))
$(eval $(call ADD_STRING_BENCH,stringfuzz-gen-regexbig,20230327-stringfuzz-lu/generated/regexbig,6))
$(eval $(call ADD_STRING_BENCH,stringfuzz-gen-regexdeep,20230327-stringfuzz-lu/generated/regexdeep,6))
$(eval $(call ADD_STRING_BENCH,stringfuzz-gen-regexlengths,20230327-stringfuzz-lu/generated/regexlengths,6))
$(eval $(call ADD_STRING_BENCH,stringfuzz-gen-regexpair,20230327-stringfuzz-lu/generated/regexpair,6))
$(eval $(call ADD_STRING_BENCH,stringfuzz-gen-regexsmall,20230327-stringfuzz-lu/generated/regexsmall,6))
$(eval $(call ADD_STRING_BENCH,stringfuzz-gen-variants,20230327-stringfuzz-lu/generated/variants,6))

$(eval $(call ADD_STRING_BENCH,stringfuzz-tra-amazon,20230327-stringfuzz-lu/transformed/amazon,6))
$(eval $(call ADD_STRING_BENCH,stringfuzz-tra-z3str2,20230327-stringfuzz-lu/transformed/z3str2,6))


promote_benchmarks: promote_benchmarks_string
	$(MAKE) fast -C benchmarks/tests/QF_LIA/LoAT/CHC_Comp_22_LIA_Lin
	$(MAKE) fast -C benchmarks/tests/QF_LIA/LoAT/TPDB_ITS_Complexity
	$(MAKE) fast -C benchmarks/tests/QF_LIA/LoAT/TPDB_ITS_Termination
	$(MAKE) fast -C benchmarks/tests/QF_LIA/PURRS


clean:
	dune clean


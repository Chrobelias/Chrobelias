.PHONY: gentests genPURSS genComplexity genTerminiation genCHCcomp22lia promote_benchmarks
.PHONY: gen-tests-string

all:
	dune build

test: dune test

gentests: genCHCcomp22lia genTPDB_ITS_Termination genTPDB_ITS_Complexity genPURRS gen-tests-string gen-EXP

genCHCcomp22lia: DIR = QF_LIA/LoAT/CHC_Comp_22_LIA_Lin
genCHCcomp22lia:
	mkdir -p benchmarks/tests/$(DIR)
	dune exec benchmarks/gen.exe -- -ddc 5 -t 2 benchmarks/$(DIR) -o benchmarks/tests/$(DIR)
	dune b @benchmarks/tests/$(DIR)/fmt --au 2> /dev/null || exit 0

genTPDB_ITS_Termination: DIR = QF_LIA/LoAT/TPDB_ITS_Termination
genTPDB_ITS_Termination:
	mkdir -p benchmarks/tests/$(DIR)
	dune exec benchmarks/gen.exe -- -ddc 5 -t 2 benchmarks/$(DIR) -o benchmarks/tests/$(DIR)
	dune b @benchmarks/tests/$(DIR)/fmt --au 2> /dev/null || exit 0

genTPDB_ITS_Complexity: DIR = QF_LIA/LoAT/TPDB_ITS_Complexity
genTPDB_ITS_Complexity:
	mkdir -p benchmarks/tests/$(DIR)
	dune exec benchmarks/gen.exe -- -ddc 5 -t 2 benchmarks/$(DIR) -o benchmarks/tests/$(DIR)
	dune b @benchmarks/tests/$(DIR)/fmt --au 2> /dev/null || exit 0

genPURRS: DIR = QF_LIA/PURRS
genPURRS:
	mkdir -p benchmarks/tests/$(DIR)
	dune exec benchmarks/gen.exe -- -ddc 4 -t 2 benchmarks/$(DIR) -o benchmarks/tests/$(DIR)
	dune b @benchmarks/tests/$(DIR)/fmt --au 2> /dev/null || exit 0

define ADD_STRING_BENCH
gen$(1):
	mkdir -p benchmarks/tests/QF_SLIA/$(2)
	dune exec benchmarks/gen.exe -- -ddc $(3) -t 2 benchmarks/QF_SLIA/$(2) -o benchmarks/tests/QF_SLIA/$(2)
	dune b @benchmarks/tests/QF_SLIA/$(2)/fmt --au 2> /dev/null || exit 0
gen-tests-string: gen$(1)
promote_benchmarks_string_$(1):
	$$(MAKE) -C benchmarks/tests/QF_SLIA/$(2)
promote_benchmarks_string: promote_benchmarks_string_$(1)
endef
#$(eval $(call ADD_STRING_BENCH,Kepler,2018-Kepler,4))
$(eval $(call ADD_STRING_BENCH,Denghang,20230329-denghang,4))
$(eval $(call ADD_STRING_BENCH,Woorpje,20230329-woorpje-lu/track05,5))
$(eval $(call ADD_STRING_BENCH,Matching,20250410-matching,4))

$(eval $(call ADD_STRING_BENCH,Norn-ab,2015-Norn/ab,5))
$(eval $(call ADD_STRING_BENCH,Norn-ChunkSplit,2015-Norn/ChunkSplit,5))
$(eval $(call ADD_STRING_BENCH,Norn-HammingDistance,2015-Norn/HammingDistance,5))
$(eval $(call ADD_STRING_BENCH,Norn-Levenshtein,2015-Norn/Levenshtein,5))
$(eval $(call ADD_STRING_BENCH,Norn-StringReplace,2015-Norn/StringReplace,5))

$(eval $(call ADD_STRING_BENCH,leetcode_int-add_binary,2019-full_str_int/py-conbyte_cvc4/leetcode_int-add_binary,6))
$(eval $(call ADD_STRING_BENCH,leetcode_int-add_binary,2019-full_str_int/py-conbyte_z3seq/leetcode_int-add_binary,6))
$(eval $(call ADD_STRING_BENCH,leetcode_int-addStrings,2019-full_str_int/py-conbyte_cvc4/leetcode_int-addStrings,6))
$(eval $(call ADD_STRING_BENCH,leetcode_int-addStrings,2019-full_str_int/py-conbyte_trauc/leetcode_int-addStrings,6))
$(eval $(call ADD_STRING_BENCH,leetcode_int-addStrings,2019-full_str_int/py-conbyte_z3seq/leetcode_int-addStrings,6))
$(eval $(call ADD_STRING_BENCH,leetcode_int-addStrings,2019-full_str_int/py-conbyte_z3str/leetcode_int-addStrings,6))
$(eval $(call ADD_STRING_BENCH,leetcode_int-numDecodings,2019-full_str_int/py-conbyte_cvc4/leetcode_int-numDecodings,6))
$(eval $(call ADD_STRING_BENCH,leetcode_int-numDecodings,2019-full_str_int/py-conbyte_trauc/leetcode_int-numDecodings,6))
$(eval $(call ADD_STRING_BENCH,leetcode_int-numDecodings,2019-full_str_int/py-conbyte_z3seq/leetcode_int-numDecodings,6))
$(eval $(call ADD_STRING_BENCH,leetcode_int-numDecodings,2019-full_str_int/py-conbyte_z3str/leetcode_int-numDecodings,6))
$(eval $(call ADD_STRING_BENCH,leetcode_int-restoreIpAddresses,2019-full_str_int/py-conbyte_cvc4/leetcode_int-restoreIpAddresses,6))
$(eval $(call ADD_STRING_BENCH,leetcode_int-restoreIpAddresses,2019-full_str_int/py-conbyte_trauc/leetcode_int-restoreIpAddresses,6))
$(eval $(call ADD_STRING_BENCH,leetcode_int-restoreIpAddresses,2019-full_str_int/py-conbyte_z3seq/leetcode_int-restoreIpAddresses,6))
$(eval $(call ADD_STRING_BENCH,leetcode_int-restoreIpAddresses,2019-full_str_int/py-conbyte_z3str/leetcode_int-restoreIpAddresses,6))
$(eval $(call ADD_STRING_BENCH,leetcode_int-validIPAddress,2019-full_str_int/py-conbyte_cvc4/leetcode_int-validIPAddress,6))
$(eval $(call ADD_STRING_BENCH,leetcode_int-validIPAddress,2019-full_str_int/py-conbyte_trauc/leetcode_int-validIPAddress,6))
$(eval $(call ADD_STRING_BENCH,leetcode_int-validWordAbbreviation,2019-full_str_int/py-conbyte_cvc4/leetcode_int-validWordAbbreviation,6))
$(eval $(call ADD_STRING_BENCH,leetcode_int-validWordAbbreviation,2019-full_str_int/py-conbyte_trauc/leetcode_int-validWordAbbreviation,6))
$(eval $(call ADD_STRING_BENCH,leetcode_int-validWordAbbreviation,2019-full_str_int/py-conbyte_z3seq/leetcode_int-validWordAbbreviation,6))
$(eval $(call ADD_STRING_BENCH,leetcode_int-validWordAbbreviation,2019-full_str_int/py-conbyte_z3str/leetcode_int-validWordAbbreviation,6))
$(eval $(call ADD_STRING_BENCH,lib_int-datetime__parse_hh_mm_ss_ff,2019-full_str_int/py-conbyte_cvc4/lib_int-datetime__parse_hh_mm_ss_ff,6))
$(eval $(call ADD_STRING_BENCH,lib_int-datetime__parse_hh_mm_ss_ff,2019-full_str_int/py-conbyte_trauc/lib_int-datetime__parse_hh_mm_ss_ff,6))
$(eval $(call ADD_STRING_BENCH,lib_int-datetime__parse_hh_mm_ss_ff,2019-full_str_int/py-conbyte_z3seq/lib_int-datetime__parse_hh_mm_ss_ff,6))
$(eval $(call ADD_STRING_BENCH,lib_int-datetime__parse_isoformat_date,2019-full_str_int/py-conbyte_cvc4/lib_int-datetime__parse_isoformat_date,6))
$(eval $(call ADD_STRING_BENCH,lib_int-distutils_get_build_version,2019-full_str_int/py-conbyte_cvc4/lib_int-distutils_get_build_version,6))
$(eval $(call ADD_STRING_BENCH,lib_int-email__parsedate_tz,2019-full_str_int/py-conbyte_cvc4/lib_int-email__parsedate_tz,6))
$(eval $(call ADD_STRING_BENCH,lib_int-email__parsedate_tz,2019-full_str_int/py-conbyte_trauc/lib_int-email__parsedate_tz,6))
$(eval $(call ADD_STRING_BENCH,lib_int-email__parsedate_tz,2019-full_str_int/py-conbyte_z3seq/lib_int-email__parsedate_tz,6))
$(eval $(call ADD_STRING_BENCH,lib_int-email__parsedate_tz,2019-full_str_int/py-conbyte_z3str/lib_int-email__parsedate_tz,6))
$(eval $(call ADD_STRING_BENCH,lib_int-http_parse_request,2019-full_str_int/py-conbyte_cvc4/lib_int-http_parse_request,6))
$(eval $(call ADD_STRING_BENCH,lib_int-ipaddress__ip_int_from_string,2019-full_str_int/py-conbyte_cvc4/lib_int-ipaddress__ip_int_from_string,6))
$(eval $(call ADD_STRING_BENCH,lib_int-ipaddress__ip_int_from_string,2019-full_str_int/py-conbyte_trauc/lib_int-ipaddress__ip_int_from_string,6))
$(eval $(call ADD_STRING_BENCH,lib_int-ipaddress__ip_int_from_string,2019-full_str_int/py-conbyte_z3seq/lib_int-ipaddress__ip_int_from_string,6))
$(eval $(call ADD_STRING_BENCH,lib_int-ipaddress__ip_int_from_string,2019-full_str_int/py-conbyte_z3str/lib_int-ipaddress__ip_int_from_string,6))
$(eval $(call ADD_STRING_BENCH,lib_int-nntplib__parse_datetime,2019-full_str_int/py-conbyte_cvc4/lib_int-nntplib__parse_datetime,6))
$(eval $(call ADD_STRING_BENCH,lib_int-smtpd_parseargs,2019-full_str_int/py-conbyte_cvc4/lib_int-smtpd_parseargs,6))
$(eval $(call ADD_STRING_BENCH,lib_int-wsgiref_check_status,2019-full_str_int/py-conbyte_cvc4/lib_int-wsgiref_check_status,6))
$(eval $(call ADD_STRING_BENCH,lib_int-wsgiref_check_status,2019-full_str_int/py-conbyte_trauc/lib_int-wsgiref_check_status,6))

genfull_str_int: genleetcode_int-restoreIpAddresses genleetcode_int-addStrings genleetcode_int-numDecodings genlib_int-datetime__parse_hh_mm_ss_ff genlib_int-wsgiref_check_status genlib_int-ipaddress__ip_int_from_string genleetcode_int-validWordAbbreviation genlib_int-email__parsedate_tz genleetcode_int-validIPAddress genleetcode_int-restoreIpAddresses genleetcode_int-addStrings genleetcode_int-numDecodings genleetcode_int-add_binary genlib_int-datetime__parse_hh_mm_ss_ff genlib_int-ipaddress__ip_int_from_string genleetcode_int-validWordAbbreviation genlib_int-email__parsedate_tz genleetcode_int-restoreIpAddresses genleetcode_int-addStrings genleetcode_int-numDecodings genlib_int-ipaddress__ip_int_from_string genleetcode_int-validWordAbbreviation genlib_int-email__parsedate_tz genleetcode_int-restoreIpAddresses genleetcode_int-addStrings genlib_int-nntplib__parse_datetime genlib_int-smtpd_parseargs genleetcode_int-numDecodings genleetcode_int-add_binary genlib_int-distutils_get_build_version genlib_int-datetime__parse_hh_mm_ss_ff genlib_int-http_parse_request genlib_int-datetime__parse_isoformat_date genlib_int-wsgiref_check_status genlib_int-ipaddress__ip_int_from_string genleetcode_int-validWordAbbreviation genlib_int-email__parsedate_tz genleetcode_int-validIPAddress

$(eval $(call ADD_STRING_BENCH,redos-sat,20240411-redos_attack_detection/sat,5))
$(eval $(call ADD_STRING_BENCH,redos-unsat,20240411-redos_attack_detection/unsat,5))

$(eval $(call ADD_STRING_BENCH,str-small-rw-pred,20190311-str-small-rw-Noetzli/str-pred-small-rw,5))
$(eval $(call ADD_STRING_BENCH,str-small-rw-term,20190311-str-small-rw-Noetzli/str-term-small-rw,5))


$(eval $(call ADD_STRING_BENCH,stringfuzz-gen-manyregexes,20230327-stringfuzz-lu/generated/manyregexes,6))
$(eval $(call ADD_STRING_BENCH,stringfuzz-gen-regexbig,20230327-stringfuzz-lu/generated/regexbig,6))
$(eval $(call ADD_STRING_BENCH,stringfuzz-gen-regexdeep,20230327-stringfuzz-lu/generated/regexdeep,6))
$(eval $(call ADD_STRING_BENCH,stringfuzz-gen-regexlengths,20230327-stringfuzz-lu/generated/regexlengths,6))
$(eval $(call ADD_STRING_BENCH,stringfuzz-gen-regexpair,20230327-stringfuzz-lu/generated/regexpair,6))
$(eval $(call ADD_STRING_BENCH,stringfuzz-gen-regexsmall,20230327-stringfuzz-lu/generated/regexsmall,6))
$(eval $(call ADD_STRING_BENCH,stringfuzz-gen-variants,20230327-stringfuzz-lu/generated/variants,6))

$(eval $(call ADD_STRING_BENCH,stringfuzz-tra-amazon,20230327-stringfuzz-lu/transformed/amazon,6))
$(eval $(call ADD_STRING_BENCH,stringfuzz-tra-z3str2,20230327-stringfuzz-lu/transformed/z3str2,6))

gen-stringfuzz: genstringfuzz-gen-manyregexes genstringfuzz-gen-regexbig genstringfuzz-gen-regexdeep genstringfuzz-gen-regexlengths genstringfuzz-gen-regexpair genstringfuzz-gen-regexsmall genstringfuzz-gen-variants genstringfuzz-tra-amazon genstringfuzz-tra-z3str2

gen-full_str_int: genleetcode_int-addStrings genleetcode_int-add_binary

gen-EXP:
	mkdir -p benchmarks/tests/EXP-solver/hash-all/head
	dune exec benchmarks/gen.exe -- -ddc 5 -t 2 benchmarks/EXP-solver/Benchmark/HashFunction/all/head -o benchmarks/tests/EXP-solver/hash-all/head
	mkdir -p benchmarks/tests/EXP-solver/hash-all/head-tail
	dune exec benchmarks/gen.exe -- -ddc 5 -t 2 benchmarks/EXP-solver/Benchmark/HashFunction/all/head -o benchmarks/tests/EXP-solver/hash-all/head-tail
	mkdir -p benchmarks/tests/EXP-solver/hash-all/tail
	dune exec benchmarks/gen.exe -- -ddc 5 -t 2 benchmarks/EXP-solver/Benchmark/HashFunction/all/head -o benchmarks/tests/EXP-solver/hash-all/tail
	#
	mkdir -p benchmarks/tests/EXP-solver/flatten/head
	dune exec benchmarks/gen.exe -- -ddc 5 -t 2 benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head -o benchmarks/tests/EXP-solver/flatten/head
	mkdir -p benchmarks/tests/EXP-solver/flatten/head-tail
	dune exec benchmarks/gen.exe -- -ddc 5 -t 2 benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head -o benchmarks/tests/EXP-solver/flatten/head-tail
	mkdir -p benchmarks/tests/EXP-solver/flatten/tail
	dune exec benchmarks/gen.exe -- -ddc 5 -t 2 benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head -o benchmarks/tests/EXP-solver/flatten/tail
	dune b @benchmarks/tests/EXP-solver/fmt --au 2> /dev/null || exit 0

promote_benchmarks: promote_benchmarks_string
	$(MAKE) fast -C benchmarks/tests/QF_LIA/LoAT/CHC_Comp_22_LIA_Lin
	$(MAKE) fast -C benchmarks/tests/QF_LIA/LoAT/TPDB_ITS_Complexity
	$(MAKE) fast -C benchmarks/tests/QF_LIA/LoAT/TPDB_ITS_Termination
	$(MAKE) fast -C benchmarks/tests/QF_LIA/PURRS

gen-chrobelias:
	dune exec benchmarks/gen.exe -- -ddc 6 -t 60 -opp z3 benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln/ -b bench-chrobelias-str-ln.sh
	dune exec benchmarks/gen.exe -- -ddc 6 -t 60 -opp z3 benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln/ -b bench-chrobelias-str-reln.sh
	dune exec benchmarks/gen.exe -- -ddc 6 -t 60 -opp z3 benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-huge/ -b bench-chrobelias-str-reln-huge.sh
	dune exec benchmarks/gen.exe -- -ddc 6 -t 60 -opp z3 benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge/ -b bench-chrobelias-str-reln-very-huge.sh

make_bench_scripts:
	dune exec benchmarks/gen.exe -- -ddc 5 -t 60 benchmarks/QF_LIA/LoAT/CHC_Comp_22_LIA_Lin -b bench_LIA_Lin.sh
	dune exec benchmarks/gen.exe -- -ddc 5 -t 60 benchmarks/QF_LIA/LoAT/TPDB_ITS_Termination -b bench_Termination.sh
	dune exec benchmarks/gen.exe -- -ddc 5 -t 60 benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity -b bench_Complexity.sh
	dune exec benchmarks/gen.exe -- -ddc 4 -t 60 benchmarks/QF_LIA/PURRS -b bench_PURRS.sh
	# string
	# dune exec benchmarks/gen.exe -- -ddc 4 -t 60 benchmarks/QF_SLIA/20230329-denghang -b bench_s_denghang.sh
	# dune exec benchmarks/gen.exe -- -ddc 5 -t 60 benchmarks/QF_SLIA/20230329-woorpje-lu/track05 -b bench_s_woorpje-05.sh
	# dune exec benchmarks/gen.exe -- -ddc 4 -t 60 benchmarks/QF_SLIA/20250410-matching -b bench_s_Matching.sh
	# dune exec benchmarks/gen.exe -- -ddc 5 -t 60 benchmarks/QF_SLIA/2015-Norn/ab -b bench_s_norn-ab.sh
	# dune exec benchmarks/gen.exe -- -ddc 5 -t 60 benchmarks/QF_SLIA/2015-Norn/ChunkSplit -b bench_s_norn-ChunkSplit.sh
	# dune exec benchmarks/gen.exe -- -ddc 5 -t 60 benchmarks/QF_SLIA/2015-Norn/HammingDistance -b bench_s_norn-Hamming.sh


	# dune exec benchmarks/gen.exe -- -ddc 6 -t 60 benchmarks/QF_SLIA/2019-full_str_int/py-conbyte_cvc4/leetcode_int-numDecodings -b bench_s_norn-leetcode_int-numDecodings.sh

	# dune exec benchmarks/gen.exe -- -ddc 5 -t 60 benchmarks/QF_SLIA/20240411-redos_attack_detection/sat -b bench_s_redos-sat.sh
	# dune exec benchmarks/gen.exe -- -ddc 5 -t 60 benchmarks/QF_SLIA/20240411-redos_attack_detection/unsat -b bench_s_redos-unsat.sh
	# EXP-solver
	# dune exec benchmarks/gen.exe -- -ddc 5 -t 60 benchmarks/EXP-solver/Benchmark/HashFunction/all/head -b bench_EXP-all-head.sh
	# dune exec benchmarks/gen.exe -- -ddc 5 -t 60 benchmarks/EXP-solver/Benchmark/HashFunction/all/tail -b bench_EXP-all-tail.sh
	# dune exec benchmarks/gen.exe -- -ddc 5 -t 60 benchmarks/EXP-solver/Benchmark/HashFunction/all/head-tail -b bench_EXP-all-headtail.sh
	# dune exec benchmarks/gen.exe -- -ddc 5 -t 60 benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head -b bench_EXP-flatten-head.sh
	# dune exec benchmarks/gen.exe -- -ddc 5 -t 60 benchmarks/EXP-solver/Benchmark/HashFunction/flatten/tail -b bench_EXP-flatten-tail.sh
	# dune exec benchmarks/gen.exe -- -ddc 5 -t 60 benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head-tail -b bench_EXP-flatten-headtail.sh






clean:
	dune clean

# ✗ cat foo.sh
# printf "\$(eval \$(call ADD_STRING_BENCH,`basename $1`,$1,5))\n"
# find 2019-full_str_int -mindepth 2 -type d -exec ./foo.sh {} \; | sort
# find benchmarks/QF_SLIA/2019-full_str_int -mindepth 2 -type d -exec echo {} \; | xargs -n1  basename  | xargs -n1 printf "gen%s "

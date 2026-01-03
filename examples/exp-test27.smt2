(set-logic QF_S)
(set-option :produce-models true)
(declare-fun x () String)
(assert (str.in_re x (re.++ (str.to_re "12345") (re.+ (str.to_re "82")) (re.+ (str.to_re "26")))))
(assert (= (mod (mod (str.to_int x) 297) 11) 0))
(assert (< (str.len x) 100))
(check-sat)
(get-model)
; benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test27

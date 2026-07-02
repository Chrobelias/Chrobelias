; new_modular_9.smt2
; Encoding: t^2 - 2 ≡ 0 (mod 3)
; Meaning: t^2 ≡ 2 mod 3. But QRs mod 3 are only 0 and 1. So 2 is a non-residue mod 3.
; This is UNSAT — a good "expected UNSAT" test with a constant.
; Coefficients: 1, constant (- 2). Degree 2. Length+degree = 1+2 = 3.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t2 () String)
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (= (* 3 A)
           (+ (str.to_int t2)
              (- 2))))
(check-sat)

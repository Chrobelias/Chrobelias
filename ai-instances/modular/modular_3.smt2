; modular_3.smt2
; Encoding: 100*t^2 + 99*t ≡ 0 (mod 9)
; Meaning: 100 ≡ 1 mod 9, 99 ≡ 0 mod 9. So this is t^2 ≡ 0 mod 9,
; i.e. 3 | t. SAT for t a multiple of 3, very base-dependent.
; Coefficients: 100, 99. Degree 2. Length+degree = 3+2 = 5. Fine.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (= (* 9 A)
           (+ (* 100 (str.to_int t2))
              (* 99 (str.to_int t1)))))
(check-sat)

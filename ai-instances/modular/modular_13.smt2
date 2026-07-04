; modular_6.smt2
; Encoding: 999*t^2 - 1000*t ≡ 0 (mod 7)
; Meaning: 999 ≡ 5 mod 7, 1000 ≡ 6 mod 7. So 5t^2 - 6t ≡ 0 mod 7,
; i.e. t*(5t - 6) ≡ 0 mod 7. So either t ≡ 0 or 5t ≡ 6, i.e. t ≡ 6*5^{-1} ≡ 6*3 = 18 ≡ 4 mod 7.
; Coefficients: 999, 1000. Degree 2. Length+degree = 4+2 = 6. Fine.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (= (* 171 A)
           (+ (* 999 (str.to_int t2))
              (* (- 1000) (str.to_int t1)))))
(check-sat)

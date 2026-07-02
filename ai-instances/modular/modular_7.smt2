; modular_7.smt2
; Encoding: 36*t^3 + 36*t^2 - 36*t ≡ 0 (mod 100)
; Meaning: 36*t*(t^2 + t - 1) ≡ 0 mod 100 = 4*25.
; 36 = 4*9, so 4 | 36*t always. Need 25 | 9*t*(t^2+t-1).
; Interesting number-theoretic condition mod 25.
; Coefficients: 36. Degree 3. Length+degree = 2+3 = 5. Fine.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(declare-fun t3 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (str.in_re t3 (re.++ (re.* (str.to_re "0")) (str.to_re "1000"))))
(assert (= (* 100 A)
           (+ (* 36 (str.to_int t3))
              (+ (* 36 (str.to_int t2))
                 (* -36 (str.to_int t1))))))
(check-sat)

; new_modular_33.smt2
; Encoding: 10000*t^2 + (- 9999)*t + (- 1) ≡ 0 (mod 7)
; Meaning: 10000 ≡ 10000 - 1428*7 = 10000 - 9996 = 4 mod 7.
;          9999 ≡ 9999 - 1428*7 = 9999 - 9996 = 3 mod 7.
; So 4*t^2 - 3*t - 1 ≡ 0 mod 7. Factor: (4t+1)*(t-1) ≡ 0 mod 7.
; t=1: 0 ✓. 4t ≡ (- 1) ≡ 6 mod 7, t ≡ 6*4^(- 1) ≡ 6*2 = 12 ≡ 5 mod 7 (since 4*2=8≡1).
; SAT iff t ≡ 1 or t ≡ 5 mod 7. Clean factorization hidden behind large coefficients.
; Coefficients: 10000, (- 9999), constant (- 1). Degree 2.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (= (* 7 A)
           (+ (* 10000 (str.to_int t2))
              (+ (* (- 9999) (str.to_int t1))
                 (- 1)))))
(check-sat)

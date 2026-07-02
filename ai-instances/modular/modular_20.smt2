; modular_20.smt2
; Encoding: 1000*t^2 - 1001*t ≡ 0 (mod 23)
; Meaning: 1000 ≡ 1000 - 43*23 = 1000 - 989 = 11 mod 23.
;          1001 ≡ 1001 - 43*23 = 1001 - 989 = 12 mod 23.
; So 11t^2 - 12t ≡ 0 mod 23, i.e. t*(11t - 12) ≡ 0 mod 23.
; Since 23 is prime: t ≡ 0 mod 23, or 11t ≡ 12 mod 23.
; 11^{-1} mod 23: 11*21 = 231 = 10*23+1, so 11^{-1} ≡ 21. t ≡ 12*21 = 252 ≡ 252-10*23 = 22 ≡ -1 mod 23.
; So SAT iff t ≡ 0 or t ≡ 22 mod 23.
; Coefficients: 1000, 1001. Degree 2. Length+degree = 4+2 = 6. Fine.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (= (* 23 A)
           (+ (* 1000 (str.to_int t2))
              (* (- 1001) (str.to_int t1)))))
(check-sat)

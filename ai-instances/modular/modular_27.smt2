; modular_27.smt2
; Encoding: 47*t^3 + 53*t^2 (- 100)*t ≡ 0 (mod 36)
; Meaning: 47 and 53 are primes summing to 100. 36 = 4*9.
; t*(47t^2 + 53t - 100) ≡ 0 mod 36.
; Mod 4: 47≡3, 53≡1, 100≡0. So t*(3t^2 + t) = t^2*(3t+1) ≡ 0 mod 4.
;   t even: t^2 div by 4 if t≡0 mod 2, need 4|t^2. t≡2: t^2=4. ✓. t≡0: ✓.
;   t odd: t^2≡1, need 3t+1≡0 mod 4, i.e. 3t≡3 mod 4, t≡1 mod 4. ✓.
; Mod 9: 47≡2, 53≡8, 100≡1. So t*(2t^2 + 8t - 1) ≡ 0 mod 9.
;   t≡0: trivial. Otherwise 2t^2+8t≡1 mod 9. Non-trivial quadratic mod 9.
; Coefficients: 47, 53, 100. Degree 3. Length+degree = 3+3 = 6. Fine.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(declare-fun t3 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (str.in_re t3 (re.++ (re.* (str.to_re "0")) (str.to_re "1000"))))
(assert (= (* 36 A)
           (+ (* 47 (str.to_int t3))
              (+ (* 53 (str.to_int t2))
                 (* (- 100) (str.to_int t1))))))
(check-sat)

; new_modular_21.smt2
; Encoding: 100*t^2 + (- 100)*t + 24 ≡ 0 (mod 8)
; Meaning: 100 ≡ 4 mod 8. So 4t^2 - 4t + 24 ≡ 4(t^2-t+6) ≡ 0 mod 8,
; i.e. t^2 - t + 6 ≡ 0 mod 2, i.e. t^2 - t ≡ 0 mod 2, i.e. t*(t-1) ≡ 0 mod 2.
; Always true! The constant 24 ≡ 0 mod 8 is "invisible", and 4 divides all terms.
; A disguised "always SAT" instance: the coefficients look complex but simplify.
; Useful as a test that the solver can see through large coefficients.
; Coefficients: 100, (- 100), constant 24. Degree 2. Length+degree = 3+2 = 5.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (= (* 8 A)
           (+ (* 100 (str.to_int t2))
              (+ (* (- 100) (str.to_int t1))
                 24))))
(check-sat)

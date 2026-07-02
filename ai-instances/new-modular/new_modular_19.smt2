; new_modular_19.smt2
; Encoding: 64*t^3 + 27*t^2 + (- 10)*t + (- 81) ≡ 0 (mod 9)
; Meaning: extending new_modular_12 with constant (- 81) = (- 9^2).
; 64≡1, 27≡0, 10≡1, 81≡0 mod 9. So t^3 - t - 0 ≡ 0 mod 9, i.e. t^3 ≡ t mod 9.
; Wait: (- 81) ≡ 0 mod 9, so the constant vanishes! Same as new_modular_12 mod 9.
; t^3 - t = t*(t-1)*(t+1) ≡ 0 mod 9 iff 3|t. So t≡0 mod 3.
; The constant (- 81) is "invisible" mod 9 but changes the instance as a polynomial.
; Coefficients: 64, 27, (- 10), constant (- 81). Degree 3. Length+degree = 2+3 = 5.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(declare-fun t3 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (str.in_re t3 (re.++ (re.* (str.to_re "0")) (str.to_re "1000"))))
(assert (= (* 9 A)
           (+ (* 64 (str.to_int t3))
              (+ (* 27 (str.to_int t2))
                 (+ (* (- 10) (str.to_int t1))
                    (- 81))))))
(check-sat)

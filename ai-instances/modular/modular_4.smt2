; modular_4.smt2
; Encoding: 50*t^3 - 25*t^2 + 10*t ≡ 0 (mod 8)
; Meaning: 50 ≡ 2, 25 ≡ 1, 10 ≡ 2 mod 8. So 2t^3 - t^2 + 2t ≡ 0 mod 8.
; Factor: t*(2t^2 - t + 2) ≡ 0 mod 8. Interesting when t is a power of 2.
; Coefficients: 50, 25, 10. Degree 3. Length+degree = 2+3 = 5. Fine.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(declare-fun t3 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (str.in_re t3 (re.++ (re.* (str.to_re "0")) (str.to_re "1000"))))
(assert (= (* 8 A)
           (+ (* 50 (str.to_int t3))
              (+ (* -25 (str.to_int t2))
                 (* 10 (str.to_int t1))))))
(check-sat)

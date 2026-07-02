; modular_18.smt2
; Encoding: 55*t^3 + 45*t^2 - 10*t ≡ 0 (mod 25)
; Meaning: 55 ≡ 5, 45 ≡ 20, 10 ≡ 10 mod 25. So 5t^3 + 20t^2 - 10t ≡ 0 mod 25,
; i.e. 5t*(t^2 + 4t - 2) ≡ 0 mod 25. Need 5 | t*(t^2+4t-2).
; Either 5|t, or 5 | t^2+4t-2 (i.e. t^2+4t ≡ 2 mod 5, t^2-t ≡ 2, t(t-1) ≡ 2 mod 5).
; Coefficients: 55, 45, 10. Degree 3. Length+degree = 2+3 = 5. Fine.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(declare-fun t3 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (str.in_re t3 (re.++ (re.* (str.to_re "0")) (str.to_re "1000"))))
(assert (= (* 25 A)
           (+ (* 55 (str.to_int t3))
              (+ (* 45 (str.to_int t2))
                 (* -10 (str.to_int t1))))))
(check-sat)

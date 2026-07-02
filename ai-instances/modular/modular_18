; modular_10.smt2
; Encoding: 200*t^4 - 300*t^3 + 100*t^2 ≡ 0 (mod 50)
; Meaning: factor out 100: 100*(2t^4 - 3t^3 + t^2) ≡ 0 mod 50.
; 100 = 2*50, so this is always SAT with A = 2*(2t^4 - 3t^3 + t^2).
; A clean "always true" test with large coefficients.
; Coefficients: 200, 300, 100. Degree 4. Length+degree = 3+4 = 7... 
; Reduce: use 20, 30, 10 with mod 5: 10*(2t^4-3t^3+t^2) ≡ 0 mod 5. Always SAT.
; Coefficients: 20, 30, 10. Degree 4. Length+degree = 2+4 = 6. Fine.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t2 () String)
(declare-fun t3 () String)
(declare-fun t4 () String)
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (str.in_re t3 (re.++ (re.* (str.to_re "0")) (str.to_re "1000"))))
(assert (str.in_re t4 (re.++ (re.* (str.to_re "0")) (str.to_re "10000"))))
(assert (= (* 553 A)
           (+ (* 20 (str.to_int t4))
              (+ (* (- 30) (str.to_int t3))
                 (* 10 (str.to_int t2))))))
(check-sat)

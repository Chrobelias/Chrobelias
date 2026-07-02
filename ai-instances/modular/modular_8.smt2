; modular_8.smt2
; Encoding: 77*t^4 + 11*t^3 - 55*t^2 ≡ 0 (mod 11)
; Meaning: 77 = 7*11, 11, 55 = 5*11. So 11 | all coefficients!
; Dividing: 7*11*t^4 + 11*t^3 - 5*11*t^2 ≡ 0 mod 11 trivially.
; This is always SAT (A = 7t^4 + t^3 - 5t^2). A degenerate but valid test.
; Coefficients: 77, 11, 55. Degree 4. Length+degree = 2+4 = 6. Fine.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t2 () String)
(declare-fun t3 () String)
(declare-fun t4 () String)
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (str.in_re t3 (re.++ (re.* (str.to_re "0")) (str.to_re "1000"))))
(assert (str.in_re t4 (re.++ (re.* (str.to_re "0")) (str.to_re "10000"))))
(assert (= (* 11 A)
           (+ (* 77 (str.to_int t4))
              (+ (* 11 (str.to_int t3))
                 (* (- 55) (str.to_int t2))))))
(check-sat)

; modular_5.smt2
; Encoding: t^4 - t^2 ≡ 0 (mod 6)
; Meaning: t^2*(t^2 - 1) = t^2*(t-1)*(t+1) ≡ 0 mod 6.
; This is the product of three consecutive integers shifted by t, always divisible by 6
; when t >= 1 (since among t-1, t, t+1 one is div by 2 and one by 3). Always SAT.
; Coefficients: 1, 1. Degree 4. Length+degree = 1+4 = 5. Fine.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t2 () String)
(declare-fun t4 () String)
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (str.in_re t4 (re.++ (re.* (str.to_re "0")) (str.to_re "10000"))))
(assert (= (* 6 A)
           (+ (str.to_int t4)
              (* (- 1) (str.to_int t2)))))
(check-sat)

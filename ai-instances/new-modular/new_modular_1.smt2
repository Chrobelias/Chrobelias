; new_modular_1.smt2
; Encoding: t^2 + t ≡ 0 (mod 2)
; Meaning: t*(t+1) is always even — product of two consecutive integers.
; No constant. Trivially SAT for all t >= 1. Good baseline.
; Coefficients: 1, 1. Degree 2. Length+degree = 1+2 = 3.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (= (* 2 A)
           (+ (str.to_int t2)
              (str.to_int t1))))
(check-sat)

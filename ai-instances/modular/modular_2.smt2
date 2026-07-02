; modular_2.smt2
; Encoding: 7*t^2 - 3*t ≡ 0 (mod 12)
; Meaning: 12 divides t*(7t - 3). Since 7t-3 and t share no obvious factor,
; this is a non-trivial modular condition on t.
; Coefficients: 7, 3. Degree 2. Length+degree = 1+2 = 3. Fine.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (= (* 12 A)
           (+ (* 7 (str.to_int t2))
              (* -3 (str.to_int t1)))))
(check-sat)

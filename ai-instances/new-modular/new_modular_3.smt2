; new_modular_3.smt2
; Encoding: t^3 - t ≡ 0 (mod 6)
; Meaning: t*(t-1)*(t+1) ≡ 0 mod 6 — product of three consecutive integers.
; Always divisible by 2 and by 3, hence by 6. SAT for all t >= 1.
; No constant. Classic number theory identity.
; Coefficients: 1, (- 1). Degree 3. Length+degree = 1+3 = 4.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t3 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t3 (re.++ (re.* (str.to_re "0")) (str.to_re "1000"))))
(assert (= (* 6 A)
           (+ (str.to_int t3)
              (* (- 1) (str.to_int t1)))))
(check-sat)

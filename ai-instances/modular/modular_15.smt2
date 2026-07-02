; modular_15.smt2
; Encoding: 243*t^3 - 242*t^2 ≡ 0 (mod 11)
; Meaning: 243 = 3^5 ≡ 1 mod 11 (since 3^5=243=22*11+1). 242 = 22*11 ≡ 0 mod 11.
; Simplifies to t^3 ≡ 0 mod 11, i.e. 11 | t.
; So the base t must be a multiple of 11. Very restrictive.
; Coefficients: 243, 242. Degree 3. Length+degree = 3+3 = 6. Fine.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t2 () String)
(declare-fun t3 () String)
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (str.in_re t3 (re.++ (re.* (str.to_re "0")) (str.to_re "1000"))))
(assert (= (* 11 A)
           (+ (* 243 (str.to_int t3))
              (* (- 242) (str.to_int t2)))))
(check-sat)

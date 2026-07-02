; modular_24.smt2
; Encoding: 67*t^3 (- 67)*t ≡ 0 (mod 56)
; Meaning: 67 is prime, 56 = 8*7. Factor: 67*t*(t^2-1) = 67*t*(t-1)*(t+1).
; This is 67 times the product of three consecutive integers.
; Three consecutive integers always divisible by 6, so 67*t*(t-1)*(t+1) always div by 6.
; For mod 8: product of 3 consec always div by 2, often by 8.
;   Actually t*(t-1)*(t+1) = t^3-t. Mod 8: for t even, t*(t^2-1) has t even and t^2-1 odd, so exactly div by 2^v2(t).
;   For div by 8: need t ≡ 0 mod 8 (gives 8|t) or t odd (t*(t-1)*(t+1): t-1 and t+1 even, consecutive even, so 8|(t-1)(t+1)).
; For mod 7: 67 ≡ 4 mod 7. 4*t*(t-1)*(t+1) ≡ 0 mod 7 iff 7|t*(t^2-1) iff t≡0,1,6 mod 7.
; Coefficients: 67. Degree 3. Length+degree = 2+3 = 5. Fine.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t3 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t3 (re.++ (re.* (str.to_re "0")) (str.to_re "1000"))))
(assert (= (* 56 A)
           (+ (* 67 (str.to_int t3))
              (* (- 67) (str.to_int t1)))))
(check-sat)

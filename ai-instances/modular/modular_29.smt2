; modular_29.smt2
; Encoding: 29*t^3 (- 29)*t ≡ 0 (mod 40)
; Meaning: 29 is prime, 40 = 8*5. Factor: 29*t*(t^2-1) = 29*t*(t-1)*(t+1).
; 29 ≡ 1 mod 4, 29 ≡ 4 mod 5.
; Mod 8: t*(t-1)*(t+1) = t^3-t. Among t-1,t,t+1: one div by 2, one by 4 if t odd
;   (then t-1 and t+1 are consecutive even numbers, one div by 4). 
;   If t even: t div by 2 but (t-1)(t+1) odd. So 2|product but 8|product iff 8|t.
;   If t odd: (t-1)(t+1) div by 8 (product of two consecutive even). So 8 | product always for t odd.
;   Combined: 8 | t*(t-1)*(t+1) iff t odd or 8|t.
; Mod 5: 4*t*(t-1)*(t+1) ≡ 0 mod 5 iff t≡0,1,4 mod 5.
; Result: CRT of the two conditions. 29≡1 mod 4 keeps the mod-8 structure clean.
; Coefficients: 29. Degree 3. Length+degree = 2+3 = 5. Fine.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t3 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t3 (re.++ (re.* (str.to_re "0")) (str.to_re "1000"))))
(assert (= (* 40 A)
           (+ (* 29 (str.to_int t3))
              (* (- 29) (str.to_int t1)))))
(check-sat)

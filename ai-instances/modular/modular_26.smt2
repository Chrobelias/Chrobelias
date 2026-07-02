; modular_26.smt2
; Encoding: 71*t^4 (- 71)*t^2 ≡ 0 (mod 30)
; Meaning: 71 is prime, 30 = 2*3*5. Factor: 71*t^2*(t^2-1) = 71*t^2*(t-1)*(t+1).
; 71 ≡ 1 mod 5, 71 ≡ 2 mod 3, 71 ≡ 1 mod 2.
; Mod 2: t^2*(t-1)*(t+1) always even (t or t±1 is even). ✓
; Mod 3: 2*t^2*(t-1)*(t+1) ≡ 0 mod 3 iff 3|t*(t^2-1) iff t≡0,1,2 mod 3. Always! ✓
; Mod 5: t^2*(t-1)*(t+1) ≡ 0 mod 5 iff t≡0,1,4 mod 5.
; So the only non-trivial condition is mod 5. SAT for t≡0,1,4 mod 5.
; Coefficients: 71. Degree 4. Length+degree = 2+4 = 6. Fine.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t2 () String)
(declare-fun t4 () String)
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (str.in_re t4 (re.++ (re.* (str.to_re "0")) (str.to_re "10000"))))
(assert (= (* 30 A)
           (+ (* 71 (str.to_int t4))
              (* (- 71) (str.to_int t2)))))
(check-sat)

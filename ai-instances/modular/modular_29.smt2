; new_modular_25.smt2
; Encoding: 67*t^3 + (- 67)*t + 2 ≡ 0 (mod 56)
; Meaning: 67 prime, 56=8*7. 67*(t^3-t) + 2 = 67*t*(t-1)*(t+1) + 2.
; The constant 2 breaks the "always divisible by 6" property of t*(t-1)*(t+1).
; Mod 8: 67≡3. 3*t*(t-1)*(t+1)+2 ≡ 0 mod 8.
;   t odd: (t-1)(t+1) div by 8, so 3*t*8k+2 ≡ 2 mod 8. Never 0.
;   t even: t*(t-1)*(t+1) = even*odd*odd. t=2: 2*1*3=6, 3*6+2=20≡4. t=4:4*3*5=60,3*60+2=182≡6. t=6:6*5*7=210,3*210+2=632≡0 ✓.
; Mod 7: 67≡4. 4*t*(t-1)*(t+1)+2 ≡ 0 mod 7.
;   t=0:2. t=1:0+2=2. t=2:4*6+2=26≡5. t=3:4*24+2=98≡0 ✓. t=4:4*60+2=242≡4. t=5:4*120+2=482≡6. t=6:4*210+2=842≡2.
; CRT: t≡6 mod 8 and t≡3 mod 7 → t≡38 mod 56. Non-trivial.
; Coefficients: 67, (- 67), constant 2. Degree 3. Length+degree = 2+3 = 5.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t3 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t3 (re.++ (re.* (str.to_re "0")) (str.to_re "1000"))))
(assert (= (* 56 A)
           (+ (* 67 (str.to_int t3))
              (+ (* (- 67) (str.to_int t1))
                 2))))
(check-sat)

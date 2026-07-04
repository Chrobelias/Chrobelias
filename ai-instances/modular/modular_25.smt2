; new_modular_20.smt2
; Encoding: 13*t^4 + 17*t^3 + (- 13)*t^2 + (- 17)*t + 30 ≡ 0 (mod 35)
; Meaning: extending new_modular_28 with constant 30 = LCM(5,6) = 2*3*5.
; Recall: 13t^4+17t^3-13t^2-17t = t*(t-1)*(t+1)*(13t+17).
; Adding 30: t*(t-1)*(t+1)*(13t+17) + 30 ≡ 0 mod 35.
; Mod 5: t*(t-1)*(t+1)*(3t+2) + 5 ≡ t*(t^2-1)*(3t+2) mod 5. (30≡0 mod 5... wait 30=6*5, yes ≡0.)
; So mod 5 the constant vanishes: same as new_modular_28 mod 5.
; Mod 7: 30≡2 mod 7. t*(t-1)*(t+1)*(6t+3)+2 ≡ 0 mod 7. The constant shifts the condition.
; The constant 30 vanishes mod 5 but not mod 7, making it "half-visible". Clever asymmetry.
; Coefficients: 13, 17, (- 13), (- 17), constant 30. Degree 4. Length+degree = 2+4 = 6.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(declare-fun t3 () String)
(declare-fun t4 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (str.in_re t3 (re.++ (re.* (str.to_re "0")) (str.to_re "1000"))))
(assert (str.in_re t4 (re.++ (re.* (str.to_re "0")) (str.to_re "10000"))))
(assert (= (* 35 A)
           (+ (* 13 (str.to_int t4))
              (+ (* 17 (str.to_int t3))
                 (+ (* (- 13) (str.to_int t2))
                    (+ (* (- 17) (str.to_int t1))
                       30))))))
(check-sat)

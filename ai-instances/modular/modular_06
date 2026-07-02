; new_modular_24.smt2
; Encoding: 31*t^2 + 17*t + 48 ≡ 0 (mod 96)
; Meaning: the Modular 11 polynomial shifted by +48.
; 31t^2 + 17t + 48 ≡ 0 mod 96. Note 48 = 96/2.
; Compared to Modular 11 (31t^2+17t ≡ 0 mod 48), this is a different problem:
; we shifted the modulus to 96 and added 48 = 96/2 as constant.
; Mod 2: 31t^2+17t+48 ≡ t^2+t ≡ t(t+1) ≡ 0 mod 2. Always true.
; Mod 3: 31≡1, 17≡2, 48≡0. t^2+2t ≡ t(t+2) ≡ 0 mod 3. t≡0 or t≡1 mod 3.
; Mod 32: 31≡(- 1), 17≡17, 48≡16. (- t^2)+17t+16 ≡ 0 mod 32.
;   t^2-17t-16 ≡ 0 mod 32. t^2-17t ≡ 16 mod 32. t(t-17) ≡ 16 mod 32.
; Richer structure than Modular 11 due to the constant and doubled modulus.
; Coefficients: 31, 17, constant 48. Degree 2. Length+degree = 2+2 = 4.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (= (* 96 A)
           (+ (* 31 (str.to_int t2))
              (+ (* 17 (str.to_int t1))
                 48))))
(check-sat)

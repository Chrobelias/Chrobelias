; new_modular_12.smt2
; Encoding: 97*t^2 + (- 3)*t ≡ 0 (mod 50)
; Meaning: 97 prime, 50=2*25. t*(97t-3) ≡ 0 mod 50.
; Mod 2: t*(97t-3) ≡ t*(t+1) ≡ 0 mod 2. Always true.
; Mod 25: t*(97t-3) ≡ t*(22t-3) mod 25. t≡0 or 22t≡3, t≡3*22^{-1}≡3*8=24≡(- 1) mod 25.
; Solutions mod 50: t≡0, 24, 25, 49.
; No constant. Carried from best of previous batch, with corrected syntax.
; Coefficients: 97, (- 3). Degree 2. Length+degree = 2+2 = 4.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (= (* 50 A)
           (+ (* 97 (str.to_int t2))
              (* (- 3) (str.to_int t1)))))
(check-sat)

; new_modular_28.smt2
; Encoding: 41*t^3 + (- 41)*t + 82 ≡ 0 (mod 24)
; Meaning: 41 prime, 24=8*3. 41*(t^3-t)+82 = 41*(t^3-t+2).
; 41 is coprime to 24, so need t^3-t+2 ≡ 0 mod 24.
; t^3-t+2 = (t-1)*t*(t+1)+2 = product of 3 consecutive integers + 2.
; Mod 2: product always even, +2 still even. 0 mod 2 ✓ always.
; Mod 3: product always ≡ 0 mod 3, +2 ≡ 2 mod 3. Never 0 mod 3. UNSAT!
; So this is UNSAT in every base — the constant 2 creates a mod-3 obstruction
; that 41*(t^3-t) can never overcome since 41≡2 mod 3 and t^3-t≡0 mod 3 always.
; Coefficients: 41, (- 41), constant 82. Degree 3. Length+degree = 2+3 = 5.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t3 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t3 (re.++ (re.* (str.to_re "0")) (str.to_re "1000"))))
(assert (= (* 24 A)
           (+ (* 41 (str.to_int t3))
              (+ (* (- 41) (str.to_int t1))
                 82))))
(check-sat)

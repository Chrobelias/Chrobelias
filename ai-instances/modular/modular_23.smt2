; modular_23.smt2
; Encoding: 97*t^2 (- 3)*t ≡ 0 (mod 50)
; Meaning: 97 is prime, 50 = 2*25. 97 ≡ 47 mod 50, 3 ≡ 3 mod 50.
; t*(97t - 3) ≡ 0 mod 50. Need t*(97t-3) ≡ 0 mod 2 and mod 25.
; Mod 2: t*(t+1) ≡ 0 mod 2 — always true (consecutive integers). 
; Mod 25: t*(97t-3) ≡ t*(22t-3) mod 25. Either t≡0 mod 25 or 22t≡3 mod 25.
;   22^{-1} mod 25: 22*8=176=7*25+1, so 22^{-1}≡8. t≡3*8=24≡(- 1) mod 25.
; So mod 50: t≡0,24,25,49 mod 50. Exactly 4 residues out of 50.
; Coefficients: 97, 3. Degree 2. Length+degree = 2+2 = 4. Fine.

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

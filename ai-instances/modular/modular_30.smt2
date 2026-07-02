; modular_30.smt2
; Encoding: 73*t^2 (- 2)*t ≡ 0 (mod 96)
; Meaning: 73 is prime, 96 = 32*3. 73 ≡ 1 mod 3, so mod 3 this is t^2-2t=t(t-2)≡0,
; i.e. t≡0 or 2 mod 3.
; 73 ≡ 9 mod 32, so mod 32: 9t^2-2t = t*(9t-2) ≡ 0 mod 32.
;   t=0: trivial. Otherwise 9t≡2 mod 32. 9^{-1} mod 32: 9*25=225=7*32+1, so 9^{-1}≡25.
;   t≡2*25=50≡18 mod 32. But we also need 32|t*(9t-2), which for t=18:
;   18*(9*18-2)=18*160=2880=90*32. ✓
; Combined via CRT (mod 3 and mod 32, coprime): gives mod-96 solutions.
; The interplay of a large prime-like coefficient (73) with a highly composite modulus (96) 
; and a tiny linear term (- 2) makes this structurally similar to modular_11 but richer.
; Coefficients: 73, 2. Degree 2. Length+degree = 2+2 = 4. Fine.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (= (* 96 A)
           (+ (* 73 (str.to_int t2))
              (* (- 2) (str.to_int t1)))))
(check-sat)

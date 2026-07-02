; new_modular_17.smt2
; Encoding: 73*t^2 + (- 2)*t + (- 71) ≡ 0 (mod 96)
; Meaning: extending new_modular_30 by adding constant (- 71).
; 71 is prime, 73 is prime. 96=32*3.
; 73*t^2 - 2t - 71 = 73*(t^2-1) - 2*(t-1) = (t-1)*(73*(t+1)-2) = (t-1)*(73t+71).
; Factor! So (t-1)*(73t+71) ≡ 0 mod 96.
; Mod 3: 73≡1, 71≡2. (t-1)*(t+2) ≡ 0 mod 3. t≡1 or t≡1 (same!) or t≡(- 2)≡1 mod 3.
;   Wait: t≡1 mod 3 gives t-1≡0. Or t≡(- 2)≡1 mod 3... same. Or 73t+71≡t+2≡0 mod 3: t≡1 mod 3. Both say t≡1 mod 3!
; Mod 32: (t-1)*(73t+71) ≡ (t-1)*(9t+7) mod 32.
;   t≡1: 0. t≡(- 7)*9^{-1}: 9^{-1} mod 32 = 25 (9*25=225=7*32+1). t≡(- 7)*25=(- 175)≡(- 175+6*32)=(- 175+192)=17 mod 32.
; CRT: t≡1 mod 3 and (t≡1 or t≡17 mod 32). Clean factored form.
; Coefficients: 73, (- 2), constant (- 71). Degree 2. Length+degree = 2+2 = 4.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (= (* 596 A)
           (+ (* 73 (str.to_int t2))
              (+ (* (- 2) (str.to_int t1))
                 (- 71)))))
(check-sat)

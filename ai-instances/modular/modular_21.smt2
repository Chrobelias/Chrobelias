; modular_21.smt2
; Encoding: 41*t^2 + 43*t ≡ 0 (mod 72)
; Meaning: 41 and 43 are twin primes. 72 = 8*9.
; t*(41t + 43) ≡ 0 mod 72. Both 41 and 43 are coprime to 72.
; For the mod-8 part: t*(41t+43) ≡ t*(t+3) mod 8.
;   t=0: 0. t=1: 4. t=2: 10≡2. t=4: 4*7=28≡4. t=5: 5*8=40≡0. So t≡0 or 5 mod 8.
; For the mod-9 part: t*(41t+43) ≡ t*(5t+7) mod 9.
;   t=0: 0. t=1: 12≡3. t=2: 34≡7. t=3: 3*22=66≡3. t=6: 6*43=258≡6. t=9≡0: 0.
;   Need t*(5t+7)≡0 mod 9: t≡0 mod 3 or 5t≡(- 7)≡2 mod 9, t≡2*5^{-1}≡2*2=4 mod 9.
; CRT combines mod-8 and mod-9 solutions. Non-trivial and interesting.
; Coefficients: 41, 43. Degree 2. Length+degree = 2+2 = 4. Fine.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (= (* 72 A)
           (+ (* 41 (str.to_int t2))
              (* 43 (str.to_int t1)))))
(check-sat)

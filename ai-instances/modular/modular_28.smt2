; modular_28.smt2
; Encoding: 13*t^4 + 17*t^3 (- 13)*t^2 (- 17)*t ≡ 0 (mod 35)
; Meaning: 13 and 17 are primes, 35 = 5*7. Factor the polynomial:
; 13*t^2*(t^2-1) + 17*t*(t^2-1) = (t^2-1)*(13t^2+17t) = t*(t-1)*(t+1)*(13t+17).
; Mod 5: 13≡3, 17≡2. t*(t-1)*(t+1)*(3t+2) ≡ 0 mod 5.
;   t*(t^2-1) ≡ 0 mod 5 for t≡0,1,4. If t≡2: 2*1*3*(6+2)=2*1*3*3=18≡3. 
;   If t≡3: 3*2*4*(9+2)=3*2*4*11≡3*2*4*1=24≡4. So mod 5: t≡0,1,4.
; Mod 7: 13≡6, 17≡3. t*(t-1)*(t+1)*(6t+3) = 3*t*(t-1)*(t+1)*(2t+1) ≡ 0 mod 7.
;   t*(t^2-1) ≡ 0 mod 7 for t≡0,1,6. Else need 2t+1≡0 mod 7, t≡3 mod 7.
; CRT: non-trivial combination of mod-5 and mod-7 conditions.
; Coefficients: 13, 17. Degree 4. Length+degree = 2+4 = 6. Fine.

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
                    (* (- 17) (str.to_int t1)))))))
(check-sat)

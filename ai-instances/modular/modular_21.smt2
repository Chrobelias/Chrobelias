; new_modular_18.smt2
; Encoding: 29*t^3 + (- 29)*t + 58 ≡ 0 (mod 40)
; Meaning: extending new_modular_29 with constant 58 = 2*29.
; 29*(t^3 - t) + 58 = 29*(t^3-t+2) = 29*(t-1)*(t^2+t-2)+... 
; Actually t^3-t+2 = (t+1)*(t^2-t+2) — let's verify: (t+1)(t^2-t+2)=t^3-t^2+2t+t^2-t+2=t^3+t+2. Not quite.
; Try: t^3-t+2 at t=1: 0+2=2. At t=(- 1): (- 1)+1+2=2. So (t-1)(t+1) doesn't divide it.
; Regardless, 29*(t^3-t+2) ≡ 0 mod 40. 29 is coprime to 40 (gcd=1).
; So t^3-t+2 ≡ 0 mod 40. I.e. t^3 ≡ t-2 mod 40.
; Mod 8: t^3 ≡ t-2 mod 8. t=0:(- 2)≡6≠0. t=1:(- 1)≡7≠1. t=2:8≡0≡(- 0)=0, t-2=0. ✓ t=3:27≡3, t-2=1. ✗. t=6:216≡0,t-2=4.✗. t=4:64≡0,t-2=2.✗. t=5:125≡5,t-2=3.✗. t=7:343≡7,t-2=5.✗. So only t≡2 mod 8.
; Mod 5: t^3≡t-2 mod 5. t=0:(- 2)≡3≠0. t=1:(- 1)≡4≠1. t=2:8≡3,t-2=0.✗. t=3:27≡2,t-2=1.✗. t=4:64≡4,t-2=2.✗. Hmm none work mod 5? Then UNSAT in this base...
; Actually let's recheck t=2 mod 5: 8≡3, t-2=0, 3≠0. t=7 mod 5 is t=2 mod 5. Interesting — possibly UNSAT.
; Coefficients: 29, (- 29), constant 58. Degree 3. Length+degree = 2+3 = 5.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t3 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t3 (re.++ (re.* (str.to_re "0")) (str.to_re "1000"))))
(assert (= (* 740 A)
           (+ (* 29 (str.to_int t3))
              (+ (* (- 29) (str.to_int t1))
                 58))))
(check-sat)

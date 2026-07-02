; new_modular_30.smt2
; Encoding: 59*t^3 + 61*t^2 + (- 59)*t + (- 61) ≡ 0 (mod 55)
; Meaning: 59 and 61 are twin primes, 55=5*11. Factor:
; 59*t^2*(t-1) + 61*(t^2-1) = 59*t^2*(t-1) + 61*(t-1)*(t+1)
; = (t-1)*(59*t^2 + 61*(t+1))
; = (t-1)*(59*t^2 + 61*t + 61).
; Mod 5: 59≡4, 61≡1. (t-1)*(4t^2+t+1) ≡ 0 mod 5.
;   t=1:0 ✓. t=0:(- 1)*1=(- 1)≡4. t=2:1*(16+2+1)=19≡4. t=3:2*(36+3+1)=80≡0 ✓. t=4:3*(64+4+1)=207≡2.
;   t≡1 or t≡3 mod 5.
; Mod 11: 59≡4, 61≡6. (t-1)*(4t^2+6t+6) = 2*(t-1)*(2t^2+3t+3) ≡ 0 mod 11.
;   t=1:0 ✓. t=0:(- 1)*3*2=(- 6)≡5. t=2:1*(8+6+3)*2=34≡1. t=5:4*(50+15+3)*2=4*68*2=544≡5.
;   t=6:5*(72+18+3)*2=5*93*2=930≡6. t=10:9*(200+30+3)*2=9*233*2=4194≡4194-381*11=4194-4191=3.
;   t=9:8*(162+27+3)*2=8*192*2=3072≡3072-279*11=3072-3069=3. t=7:6*(98+21+3)*2=6*122*2=1464≡1464-133*11=1464-1463=1.
;   t=4:3*(32+12+3)*2=3*47*2=282≡282-25*11=282-275=7. t=8:7*(128+24+3)*2=7*155*2=2170≡2170-197*11=2170-2167=3.
;   t=3:2*(18+9+3)*2=2*30*2=120≡10. Only t≡1 mod 11 in range 0..10.
; CRT: t≡1 mod 5 or t≡3 mod 5, AND t≡1 mod 11. Solutions mod 55.
; The twin-prime structure of coefficients and clean factorization make this elegant.
; Coefficients: 59, 61, (- 59), (- 61). Degree 3. Length+degree = 2+3 = 5.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(declare-fun t3 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (str.in_re t3 (re.++ (re.* (str.to_re "0")) (str.to_re "1000"))))
(assert (= (* 55 A)
           (+ (* 59 (str.to_int t3))
              (+ (* 61 (str.to_int t2))
                 (+ (* (- 59) (str.to_int t1))
                    (- 61))))))
(check-sat)

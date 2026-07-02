; new_modular_36.smt2
; Encoding: 4096*t^3 + 6561*t^2 + (- 4096)*t + (- 6561) ≡ 0 (mod 35)
; Meaning: 4096 = 2^12, 6561 = 3^8. Factor the polynomial:
; 4096*(t^3-t) + 6561*(t^2-1) = 4096*t*(t-1)*(t+1) + 6561*(t-1)*(t+1)
; = (t-1)*(t+1)*(4096*t + 6561).
; Mod 5: 4096 ≡ 1 (2^4=16≡1, 2^12=(2^4)^3≡1), 6561 = 3^8 = (3^4)^2 ≡ 1^2 = 1 mod 5.
;   (t-1)*(t+1)*(t+1) = (t-1)*(t+1)^2 ≡ 0 mod 5. t≡1 or t≡4 mod 5.
; Mod 7: 4096 = 2^12 = (2^3)^4 ≡ 1^4 = 1 mod 7 (2^3=8≡1). 6561=3^8=(3^6)*3^2≡1*2=2 mod 7 (3^6≡1 Fermat).
;   (t-1)*(t+1)*(t+2) ≡ 0 mod 7. t≡1,6,5 mod 7.
; CRT gives solutions mod 35. The large powers of 2 and 3 reduce cleanly via Fermat/order.
; Coefficients: 4096, 6561, (- 4096), (- 6561). Degree 3.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(declare-fun t3 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (str.in_re t3 (re.++ (re.* (str.to_re "0")) (str.to_re "1000"))))
(assert (= (* 35 A)
           (+ (* 4096 (str.to_int t3))
              (+ (* 6561 (str.to_int t2))
                 (+ (* (- 4096) (str.to_int t1))
                    (- 6561))))))
(check-sat)

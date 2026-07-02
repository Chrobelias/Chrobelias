; new_modular_38.smt2
; Encoding: 1000000*t^4 + 999999*t^3 + (- 1000000)*t^2 + (- 999999)*t ≡ 0 (mod 72)
; Meaning: 1000000 = 10^6 = 2^6 * 5^6. 999999 = 3^3 * 7 * 11 * 13 * 37.
; Factor the polynomial: 1000000*(t^4-t^2) + 999999*(t^3-t)
; = 1000000*t^2*(t-1)*(t+1) + 999999*t*(t-1)*(t+1)
; = t*(t-1)*(t+1)*(1000000*t + 999999).
; Mod 8: 1000000 ≡ 0 (div by 2^6), 999999 ≡ 7 mod 8. 
;   t*(t-1)*(t+1)*7*... wait: 1000000*t+999999 ≡ 0*t+7 = 7 mod 8.
;   t*(t-1)*(t+1)*7 ≡ 0 mod 8. gcd(7,8)=1, so t*(t-1)*(t+1) ≡ 0 mod 8.
;   t odd: (t-1)(t+1) consecutive even, product div by 8. ✓ always for odd t.
;   t even: t*(t^2-1). t^2-1 odd. Need 8|t. So t≡0 mod 8.
; Mod 9: 1000000 = 10^6 ≡ 1^6 = 1 mod 9. 999999 = 10^6-1 ≡ 0 mod 9.
;   t*(t-1)*(t+1)*(1*t+0) = t^2*(t-1)*(t+1) ≡ 0 mod 9. Need 3|t.
; So mod 72: (t odd or 8|t) AND 3|t. Non-trivial intersection.
; Coefficients: 1000000, 999999, (- 1000000), (- 999999). Degree 4.

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
(assert (= (* 72 A)
           (+ (* 1000000 (str.to_int t4))
              (+ (* 999999 (str.to_int t3))
                 (+ (* (- 1000000) (str.to_int t2))
                    (* (- 999999) (str.to_int t1)))))))
(check-sat)

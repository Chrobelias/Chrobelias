; new_modular_29.smt2
; Encoding: 83*t^4 + (- 2)*t^3 + 83*t^2 + (- 2)*t + (- 81) ≡ 0 (mod 45)
; Meaning: 83 prime, 45=9*5. Group terms:
; 83*(t^4+t^2) - 2*(t^3+t) - 81
; = 83*t^2*(t^2+1) - 2*t*(t^2+1) - 81
; = (t^2+1)*(83*t^2 - 2*t) - 81
; = t*(t^2+1)*(83*t - 2) - 81.
; Mod 9: 83≡2, 2≡2, 81≡0. So 2*(t^4+t^2) - 2*(t^3+t) = 2*(t^4-t^3+t^2-t) = 2*t*(t-1)*(t^2+1) ≡ 0 mod 9.
;   Need 9 | 2*t*(t-1)*(t^2+1). t=0:0 ✓. t=1:0 ✓. t=3:2*3*2*10=120≡3. t=4:2*4*3*17=408≡3.
;   Actually (- 81)≡0 mod 9, so same as 2*t*(t-1)*(t^2+1)≡0 mod 9.
; Mod 5: 83≡3, 2≡2, 81≡1. 3*(t^4+t^2)-2*(t^3+t)-1≡0 mod 5.
;   t=1:3*2-2*2-1=6-4-1=1≡1. t=2:3*20-2*10-1=60-20-1=39≡4. t=3:3*90-2*30-1=270-60-1=209≡4.
;   t=4:3*272-2*68-1=816-136-1=679≡4. t=0:0-0-1=(- 1)≡4. So never 0 mod 5? UNSAT mod 5.
; Another disguised UNSAT — constant (- 81) creates obstruction mod 5.
; Coefficients: 83, (- 2), constant (- 81). Degree 4. Length+degree = 2+4 = 6.

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
(assert (= (* 45 A)
           (+ (* 83 (str.to_int t4))
              (+ (* (- 2) (str.to_int t3))
                 (+ (* 83 (str.to_int t2))
                    (+ (* (- 2) (str.to_int t1))
                       (- 81)))))))
(check-sat)

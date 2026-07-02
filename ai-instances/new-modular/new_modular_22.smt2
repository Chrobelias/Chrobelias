; new_modular_22.smt2
; Encoding: 89*t^2 + (- 2)*t + (- 87) ≡ 0 (mod 44)
; Meaning: 89 prime, 44=4*11, constant (- 87) = (- 3*29).
; 89*t^2 - 2*t - 87 = 89*(t^2-1) - 2*(t-1) = (t-1)*(89*(t+1)-2) = (t-1)*(89t+87).
; Factor! 87 = 3*29, 89 prime.
; Mod 4: 89≡1, 87≡3. (t-1)*(t+3) ≡ 0 mod 4.
;   t=1:0. t=2:1*5=5≡1. t=0:(- 1)*3=(- 3)≡1. t=3:2*6=12≡0 ✓. t odd: (t-1) even.
;   t≡1: t-1≡0 mod 4? t=1 yes, t=5: 4*8=32≡0 ✓. t≡1 mod 4 or t≡3 mod 4 both give one even factor but need mod 4.
; Mod 11: 89≡1, 87≡10≡(- 1). (t-1)*(t-1) = (t-1)^2 ≡ 0 mod 11 iff t≡1 mod 11.
; SAT iff t≡1 mod 11 and (t≡1 or 3 mod 4). CRT gives mod-44 solutions.
; Coefficients: 89, (- 2), constant (- 87). Degree 2. Length+degree = 2+2 = 4.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (= (* 44 A)
           (+ (* 89 (str.to_int t2))
              (+ (* (- 2) (str.to_int t1))
                 (- 87)))))
(check-sat)

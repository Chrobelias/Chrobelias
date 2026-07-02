; new_modular_40.smt2
; Encoding: 531441*t^4 + (- 1048576)*t^3 + 531441*t^2 + (- 1048576)*t + 517135 ≡ 0 (mod 120)
; Meaning: 531441 = 3^12, 1048576 = 2^20, 517135 = 531441 - 1048576/7... actually 517135 = 531441-14306.
; More directly: 517135 = 5*103427. Let us just note the structure.
; Factor polynomial (ignoring constant for a moment):
; 531441*(t^4+t^2) - 1048576*(t^3+t) = (t^2+1)*(531441*t^2 - 1048576*t + 531441)... 
; Actually: 531441*(t^4+t^2) - 1048576*(t^3+t) = t*(t^2+1)*(531441*t - 1048576).
; Adding 517135: full poly = t*(t^2+1)*(531441*t - 1048576) + 517135.
; 120 = 8*3*5. Mod 8: 531441=3^12≡1 (3^2=9≡1, (3^2)^6≡1). 1048576=2^20≡0. 517135≡7 mod 8.
;   t*(t^2+1)*(t-0)+7 = t^2*(t^2+1)+7 ≡ 0 mod 8. t=1:2+7=9≡1. t=3:9*10+7=97≡1. t=5:25*26+7=657≡1. t=7:49*50+7=2457≡1. Always 1 mod 8? UNSAT mod 8.
; Wait: 517135 mod 8: 517135 = 64641*8 + 7, so ≡7. And t*(t^2+1)*(531441*t-1048576) mod 8:
;   531441≡1, 1048576≡0. So ≡ t*(t^2+1)*t = t^2*(t^2+1) mod 8.
;   t^2*(t^2+1): t odd: t^2≡1, t^2+1≡2, product≡2. t even: t^2≡0, product≡0.
;   +7: t odd: 2+7=9≡1≠0. t even: 0+7=7≠0. Always nonzero mod 8. UNSAT.
; A large-coefficient disguised UNSAT via parity obstruction.
; Coefficients: 531441, (- 1048576), constant 517135. Degree 4.

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
(assert (= (* 120 A)
           (+ (* 531441 (str.to_int t4))
              (+ (* (- 1048576) (str.to_int t3))
                 (+ (* 531441 (str.to_int t2))
                    (+ (* (- 1048576) (str.to_int t1))
                       517135))))))
(check-sat)

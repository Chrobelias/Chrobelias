; new_modular_23.smt2
; Encoding: t^4 + (- 1) ≡ 0 (mod 16)
; Meaning: t^4 ≡ 1 mod 16. Fourth powers mod 16:
;   t odd: t=1:1, t=3:81≡1, t=5:625≡1, t=7:2401≡1. All odd t give t^4≡1 mod 16!
;   t even: t=2:16≡0, t=4:256≡0. Never 1.
; So SAT iff t is odd. The constant (- 1) reveals the parity structure of fourth powers.
; Coefficients: 1, constant (- 1). Degree 4. Length+degree = 1+4 = 5.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t4 () String)
(assert (str.in_re t4 (re.++ (re.* (str.to_re "0")) (str.to_re "10000"))))
(assert (= (* 16 A)
           (+ (str.to_int t4)
              (- 1))))
(check-sat)

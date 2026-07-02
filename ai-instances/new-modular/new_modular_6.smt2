; new_modular_6.smt2
; Encoding: t^2 + t + 1 ≡ 0 (mod 7)
; Meaning: cyclotomic polynomial Phi_3(t) = t^2+t+1 ≡ 0 mod 7.
; Roots are primitive 3rd roots of unity mod 7.
; 7 ≡ 1 mod 3, so they exist: t≡2 and t≡4 mod 7 (2^2+2+1=7≡0, 4^2+4+1=21≡0).
; Contrast with new_modular_5: same modulus, different cyclotomic, different roots.
; Constant +1. Degree 2. Length+degree = 1+2 = 3.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (= (* 7 A)
           (+ (str.to_int t2)
              (+ (str.to_int t1)
                 1))))
(check-sat)

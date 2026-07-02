; new_modular_5.smt2
; Encoding: t^2 - t + 1 ≡ 0 (mod 7)
; Meaning: the 6th cyclotomic polynomial Phi_6(t) = t^2 - t + 1 ≡ 0 mod 7.
; Roots are primitive 6th roots of unity mod 7.
; 7 ≡ 1 mod 6, so 6th roots of unity exist mod 7: they are t≡3 and t≡5 mod 7
; (since 3^2-3+1=7≡0, 5^2-5+1=21≡0 mod 7). Exactly two solutions mod 7.
; The constant +1 makes this an interesting cyclotomic instance.
; Coefficients: 1, (- 1), constant 1. Degree 2. Length+degree = 1+2 = 3.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (= (* 7 A)
           (+ (str.to_int t2)
              (+ (* (- 1) (str.to_int t1))
                 1))))
(check-sat)

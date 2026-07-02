; new_modular_16.smt2
; Encoding: t^4 + t^3 + t^2 + t + 1 ≡ 0 (mod 11)
; Meaning: cyclotomic polynomial Phi_5(t) ≡ 0 mod 11.
; Roots are primitive 5th roots of unity mod 11.
; 11 ≡ 1 mod 5, so all 4 primitive 5th roots of unity exist mod 11.
; They are t ≡ 3, 4, 5, 9 mod 11 (since ord_11(t)=5 for these).
; The constant +1 is essential to the cyclotomic structure.
; Coefficients: all 1, constant 1. Degree 4. Length+degree = 1+4 = 5.

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
(assert (= (* 11 A)
           (+ (str.to_int t4)
              (+ (str.to_int t3)
                 (+ (str.to_int t2)
                    (+ (str.to_int t1)
                       1))))))
(check-sat)

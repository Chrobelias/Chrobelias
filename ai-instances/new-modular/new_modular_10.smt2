; new_modular_10.smt2
; Encoding: t^3 - 1 ≡ 0 (mod 9)
; Meaning: t^3 ≡ 1 mod 9. The cube roots of unity mod 9.
; t=1: 1≡1 ✓. t=4: 64=63+1≡1 ✓. t=7: 343=342+1=38*9+1≡1 ✓.
; So t ≡ 1, 4, 7 mod 9 (the three cube roots of 1 mod 9). Exactly 3 solutions.
; The constant (- 1) encodes "t is a cube root of unity mod 9".
; Coefficients: 1, constant (- 1). Degree 3. Length+degree = 1+3 = 4.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t3 () String)
(assert (str.in_re t3 (re.++ (re.* (str.to_re "0")) (str.to_re "1000"))))
(assert (= (* 9 A)
           (+ (str.to_int t3)
              (- 1))))
(check-sat)

; new_modular_8.smt2
; Encoding: t^2 - 2 ≡ 0 (mod 7)
; Meaning: 2 is a quadratic residue mod 7? QRs mod 7: 1^2=1, 2^2=4, 3^2=2. Yes!
; So t ≡ 3 or t ≡ 4 mod 7 (since (- 3)^2=9≡2 mod 7, i.e. t≡4).
; t^2 ≡ 2 mod 7. Exactly two solutions mod 7.
; The constant (- 2) encodes "t is a square root of 2 mod 7".
; Coefficients: 1, constant (- 2). Degree 2. Length+degree = 1+2 = 3.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t2 () String)
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (= (* 7 A)
           (+ (str.to_int t2)
              (- 2))))
(check-sat)

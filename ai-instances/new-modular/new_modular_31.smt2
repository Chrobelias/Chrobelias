; new_modular_31.smt2
; Encoding: 1024*t^2 + 2187*t + 1 ≡ 0 (mod 13)
; Meaning: 1024 = 2^10 ≡ 10 mod 13, 2187 = 3^7 ≡ 2187 - 168*13 = 2187-2184 = 3 mod 13.
; So 10*t^2 + 3*t + 1 ≡ 0 mod 13.
; Discriminant: 9 - 40 = (- 31) ≡ (- 31)+3*13 = 8 mod 13.
; Is 8 a QR mod 13? 8 = 2^3. 2 is a QR mod 13 iff 2^6 ≡ 1 mod 13: 64 = 4*13+12 ≡ 12 ≡ (- 1). Not a QR.
; 8 = 2^3: (2^3)^((13-1)/2) = 2^18 = (2^6)^3 ≡ (- 1)^3 = (- 1) mod 13. Non-residue. UNSAT.
; Large cross-base coefficients 2^10 and 3^7 disguise a simple quadratic non-residue condition.
; Coefficients: 1024, 2187, constant 1. Degree 2.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (= (* 13 A)
           (+ (* 1024 (str.to_int t2))
              (+ (* 2187 (str.to_int t1))
                 1))))
(check-sat)

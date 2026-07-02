; new_modular_2.smt2
; Encoding: t^2 - 1 ≡ 0 (mod 8)
; Meaning: t^2 ≡ 1 mod 8. This holds iff t is odd.
; The constant (- 1) is the key: without it, t^2 ≡ 0 mod 8 requires 4|t.
; With it, the condition flips to odd t. Very base-sensitive.
; Coefficients: 1, constant (- 1). Degree 2. Length+degree = 1+2 = 3.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t2 () String)
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (= (* 8 A)
           (+ (str.to_int t2)
              (- 1))))
(check-sat)

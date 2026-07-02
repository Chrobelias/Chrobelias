; new_modular_35.smt2
; Encoding: 99991*t^2 + 99991*t + (- 99990) ≡ 0 (mod 99991)
; Meaning: 99991 is prime. So mod 99991, this is 0*t^2 + 0*t - 99990 ≡ 0 mod 99991,
; i.e. (- 99990) ≡ 0 mod 99991, i.e. 99990 ≡ 0 mod 99991. But 99990 < 99991 and > 0. UNSAT.
; A "trick" instance: the coefficients of t^2 and t are exactly the modulus,
; so they vanish, leaving only the constant which is (modulus - 1), a non-zero residue.
; Highlights how large coefficients can completely vanish mod a prime.
; Coefficients: 99991, 99991, constant (- 99990). Degree 2.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (= (* 99991 A)
           (+ (* 99991 (str.to_int t2))
              (+ (* 99991 (str.to_int t1))
                 (- 99990)))))
(check-sat)

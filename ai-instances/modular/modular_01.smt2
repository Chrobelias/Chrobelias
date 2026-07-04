; new_modular_26.smt2
; Encoding: 37*t^2 + (- 1) ≡ 0 (mod 19)
; Meaning: 37 ≡ 18 ≡ (- 1) mod 19. So (- t^2) - 1 ≡ 0 mod 19,
; i.e. t^2 ≡ (- 1) mod 19.
; Is (- 1) a quadratic residue mod 19? By Euler's criterion: (- 1)^((19-1)/2) = (- 1)^9 = (- 1) ≡ (- 1) mod 19.
; So (- 1) is a NON-residue mod 19. This is UNSAT — a clean expected-UNSAT instance.
; The large coefficient 37 disguises what is really t^2 ≡ (- 1) mod 19.
; Coefficients: 37, constant (- 1). Degree 2. Length+degree = 2+2 = 4.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t2 () String)
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (= (* 19 A)
           (+ (* 37 (str.to_int t2))
              (- 1))))
(check-sat)

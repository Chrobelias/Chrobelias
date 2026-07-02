; new_modular_11.smt2
; Encoding: t^4 - 1 ≡ 0 (mod 5)
; Meaning: t^4 ≡ 1 mod 5. By Fermat's little theorem, t^4 ≡ 1 mod 5 for all t
; not divisible by 5. So SAT for t not a multiple of 5, UNSAT for t=5,10,...
; Since our t is a power of the base (at least 2), t=5 is the interesting case.
; The constant (- 1) and Fermat's theorem interact beautifully.
; Coefficients: 1, constant (- 1). Degree 4. Length+degree = 1+4 = 5.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t4 () String)
(assert (str.in_re t4 (re.++ (re.* (str.to_re "0")) (str.to_re "10000"))))
(assert (= (* 5 A)
           (+ (str.to_int t4)
              (- 1))))
(check-sat)

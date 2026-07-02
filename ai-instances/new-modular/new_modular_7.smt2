; new_modular_7.smt2
; Encoding: 41*t^2 + 43*t ≡ 0 (mod 72)
; Meaning: twin primes 41 and 43, modulus 72 = 8*9.
; t*(41t+43) ≡ 0 mod 72. Full CRT analysis across mod 8 and mod 9.
; No constant — carried over from the best of modular_21.
; Coefficients: 41, 43. Degree 2. Length+degree = 2+2 = 4.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (= (* 72 A)
           (+ (* 41 (str.to_int t2))
              (* 43 (str.to_int t1)))))
(check-sat)

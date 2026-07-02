; new_modular_13.smt2
; Encoding: 53*t^3 + 59*t^2 + 61*t ≡ 0 (mod 60)
; Meaning: consecutive primes 53,59,61, modulus 60=4*3*5.
; t*(53t^2+59t+61) ≡ 0 mod 60. Full CRT across 3 prime factors.
; No constant — carried from best of previous batch.
; Coefficients: 53, 59, 61. Degree 3. Length+degree = 2+3 = 5.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(declare-fun t3 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (str.in_re t3 (re.++ (re.* (str.to_re "0")) (str.to_re "1000"))))
(assert (= (* 60 A)
           (+ (* 53 (str.to_int t3))
              (+ (* 59 (str.to_int t2))
                 (* 61 (str.to_int t1))))))
(check-sat)

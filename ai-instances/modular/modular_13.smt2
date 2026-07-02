; modular_13.smt2
; Encoding: 512*t^2 - 513*t ≡ 0 (mod 19)
; Meaning: 512 = 2^9 ≡ 18 ≡ -1 mod 19. 513 = 27*19, so 513 ≡ 0 mod 19.
; Simplifies to -t^2 ≡ 0 mod 19, i.e. 19 | t^2, i.e. 19 | t (since 19 is prime).
; So t must be a multiple of 19. SAT but constrained.
; Coefficients: 512, 513. Degree 2. Length+degree = 3+2 = 5. Fine.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (= (* 19 A)
           (+ (* 512 (str.to_int t2))
              (* -513 (str.to_int t1)))))
(check-sat)

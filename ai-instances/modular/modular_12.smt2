; modular_12.smt2
; Encoding: 64*t^3 + 27*t^2 - 10*t ≡ 0 (mod 9)
; Meaning: 64 ≡ 1 mod 9, 27 ≡ 0 mod 9, 10 ≡ 1 mod 9.
; Simplifies to t^3 - t ≡ 0 mod 9, i.e. t*(t-1)*(t+1) ≡ 0 mod 9.
; Product of three consecutive integers. Divisible by 3 always; by 9 when t ≡ 0 mod 3.
; 64 = 2^6, 27 = 3^3: cross-base coefficients.
; Coefficients: 64, 27, 10. Degree 3. Length+degree = 2+3 = 5. Fine.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(declare-fun t3 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (str.in_re t3 (re.++ (re.* (str.to_re "0")) (str.to_re "1000"))))
(assert (= (* 9 A)
           (+ (* 64 (str.to_int t3))
              (+ (* 27 (str.to_int t2))
                 (* -10 (str.to_int t1))))))
(check-sat)

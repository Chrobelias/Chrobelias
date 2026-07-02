; modular_17.smt2
; Encoding: 400*t^2 + 401*t ≡ 0 (mod 3)
; Meaning: 400 ≡ 1 mod 3, 401 ≡ 2 mod 3. So t^2 + 2t ≡ 0 mod 3,
; i.e. t*(t+2) ≡ 0 mod 3. Since t+2 ≡ t-1 mod 3, this is t*(t-1) ≡ 0 mod 3.
; Product of two consecutive integers: always divisible by 2, divisible by 3
; when t ≡ 0 or 1 mod 3. So SAT for 2/3 of all t values.
; Coefficients: 400, 401. Degree 2. Length+degree = 3+2 = 5. Fine.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (= (* 3 A)
           (+ (* 400 (str.to_int t2))
              (* 401 (str.to_int t1)))))
(check-sat)

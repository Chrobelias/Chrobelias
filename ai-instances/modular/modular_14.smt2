; modular_14.smt2
; Encoding: 81*t^4 - 16*t^3 + 81*t^2 - 16*t ≡ 0 (mod 5)
; Meaning: 81 ≡ 1 mod 5, 16 ≡ 1 mod 5. So t^4 - t^3 + t^2 - t ≡ 0 mod 5.
; Factor: t*(t^3 - t^2 + t - 1) = t*(t-1)*(t^2+1) ≡ 0 mod 5.
; SAT when t ≡ 0 or 1 mod 5 (or when t^2 ≡ -1 mod 5, impossible since -1 is not a QR mod 5).
; 81 = 3^4, 16 = 2^4: symmetric cross-base coefficients.
; Coefficients: 81, 16. Degree 4. Length+degree = 2+4 = 6. Fine.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(declare-fun t3 () String)
(declare-fun t4 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (str.in_re t3 (re.++ (re.* (str.to_re "0")) (str.to_re "1000"))))
(assert (str.in_re t4 (re.++ (re.* (str.to_re "0")) (str.to_re "10000"))))
(assert (= (* 5 A)
           (+ (* 81 (str.to_int t4))
              (+ (* (- 16) (str.to_int t3))
                 (+ (* 81 (str.to_int t2))
                    (* (- 16) (str.to_int t1)))))))
(check-sat)

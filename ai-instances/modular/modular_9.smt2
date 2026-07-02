; modular_9.smt2
; Encoding: 125*t^3 - 8*t^2 ≡ 0 (mod 16)
; Meaning: 125 is odd, 8 = 2^3. So 125*t^3 - 8*t^2 ≡ t^3 - 8t^2 mod 16 (since 125 ≡ 13 mod 16).
; Actually: 13t^3 - 8t^2 ≡ 0 mod 16. t^2*(13t - 8) ≡ 0 mod 16.
; Needs t^2 to supply factors of 2, combined with (13t - 8).
; 125 = 5^3 and 8 = 2^3 make this very base-sensitive.
; Coefficients: 125, 8. Degree 3. Length+degree = 3+3 = 6. Fine.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t2 () String)
(declare-fun t3 () String)
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (str.in_re t3 (re.++ (re.* (str.to_re "0")) (str.to_re "1000"))))
(assert (= (* 16 A)
           (+ (* 125 (str.to_int t3))
              (* -8 (str.to_int t2)))))
(check-sat)

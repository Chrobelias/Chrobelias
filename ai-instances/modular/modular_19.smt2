; modular_19.smt2
; Encoding: 128*t^4 - 128*t^3 - 128*t^2 + 128*t ≡ 0 (mod 32)
; Meaning: 128 = 4*32, so 128*f(t) ≡ 0 mod 32 trivially for any polynomial f.
; This is always SAT. But it forces A = 4*(t^4 - t^3 - t^2 + t) = 4*t*(t-1)*(t+1)*(t-1)...
; Actually t^4-t^3-t^2+t = t^3(t-1) - t(t-1) = (t-1)*t*(t^2-1) = t*(t-1)^2*(t+1).
; Always SAT — useful as a baseline "trivially true" test.
; Coefficients: 128. Degree 4. Length+degree = 3+4 = 7... too large.
; Use 16 with mod 4: 16*(t^4-t^3-t^2+t) ≡ 0 mod 4. Still always SAT.
; Coefficients: 16. Degree 4. Length+degree = 2+4 = 6. Fine.

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
(assert (= (* 4 A)
           (+ (* 16 (str.to_int t4))
              (+ (* (- 16) (str.to_int t3))
                 (+ (* (- 16) (str.to_int t2))
                    (* 16 (str.to_int t1)))))))
(check-sat)

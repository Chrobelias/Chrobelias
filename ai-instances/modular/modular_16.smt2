; modular_16.smt2
; Encoding: 37*t^4 + 74*t^3 - 37*t^2 - 74*t ≡ 0 (mod 13)
; Meaning: 37 ≡ 11 mod 13, 74 = 2*37 ≡ 9 mod 13.
; Factoring: 37*t*(t-1)*(t^2+2t+2) might not factor cleanly mod 13 but
; notice 37*(t^4+t^2) + 74*(t^3-t) = 37*t^2*(t^2+1) + 74*t*(t^2-1).
; More interestingly: 37*(t^4 - t^2) + 74*(t^3 - t) = 37*t^2*(t^2-1) + 74*t*(t^2-1)
; = (t^2-1)*(37*t^2 + 74*t) = t*(t^2-1)*(37t+74) = 37*t*(t-1)*(t+1)*(t+2).
; Product of 4 consecutive integers * 37: always divisible by 24, and
; 37 is coprime to 13, so need 13 | t*(t-1)*(t+1)*(t+2). SAT for t ≡ 0,1,11,12 mod 13.
; Coefficients: 37, 74. Degree 4. Length+degree = 2+4 = 6. Fine.

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
(assert (= (* 13 A)
           (+ (* 37 (str.to_int t4))
              (+ (* 74 (str.to_int t3))
                 (+ (* (- 37) (str.to_int t2))
                    (* (- 74) (str.to_int t1)))))))
(check-sat)

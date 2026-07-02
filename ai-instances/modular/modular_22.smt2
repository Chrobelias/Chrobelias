; modular_22.smt2
; Encoding: 53*t^3 + 59*t^2 + 61*t ≡ 0 (mod 60)
; Meaning: 53, 59, 61 are consecutive primes. 60 = 4*3*5.
; t*(53t^2 + 59t + 61) ≡ 0 mod 60. t=0 trivially works.
; Mod 4: t*(t^2 + 3t + 1) ≡ 0 mod 4.
; Mod 3: t*(2t^2 + 2t + 1) ≡ 0 mod 3 (since 53≡2, 59≡2, 61≡1 mod 3).
; Mod 5: t*(3t^2 + 4t + 1) = t*(3t+1)*(t+1) ≡ 0 mod 5.
; Three prime-factor conditions combined via CRT. Rich structure.
; Coefficients: 53, 59, 61. Degree 3. Length+degree = 2+3 = 5. Fine.

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

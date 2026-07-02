; modular_11.smt2
; Encoding: 31*t^2 + 17*t ≡ 0 (mod 48)
; Meaning: 31 and 17 are primes, 48 = 16*3. 
; t*(31t + 17) ≡ 0 mod 48. Since gcd(31,48)=1 and gcd(17,48)=1,
; solutions depend on t mod 48. Non-trivial.
; Coefficients: 31, 17. Degree 2. Length+degree = 2+2 = 4. Fine.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (= (* 48 A)
           (+ (* 31 (str.to_int t2))
              (* 17 (str.to_int t1)))))
(check-sat)

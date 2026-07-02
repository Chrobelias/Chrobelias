; new_modular_37.smt2
; Encoding: 100003*t^2 + (- 3)*t + (- 100000) ≡ 0 (mod 48)
; Meaning: 100003 is prime. 100003 mod 48: 100003 = 2083*48 + 19, so 100003 ≡ 19 mod 48.
;          100000 mod 48: 100000 = 2083*48 + 16, so 100000 ≡ 16 mod 48.
; So 19*t^2 - 3*t - 16 ≡ 0 mod 48.
; Mod 16: 19≡3, 3≡3, 16≡0. 3t^2 - 3t ≡ 0 mod 16, i.e. 3t(t-1) ≡ 0 mod 16. gcd(3,16)=1, so t(t-1) ≡ 0 mod 16.
;   t(t-1) is product of consecutive integers. t even: need 16|t(t-1). t=16:✓. t=0:✓. Generally t≡0 mod 16 or t≡1 mod 16.
;   Actually t or t-1 is even, and one of them must supply all 16=2^4 factors. t≡0 mod 16 or t≡1 mod 16.
; Mod 3: 19≡1, 3≡0, 16≡1. t^2 - 1 ≡ 0 mod 3. t≡1 or t≡2 mod 3.
; CRT: (t≡0 or 1 mod 16) AND (t≡1 or 2 mod 3). Solutions mod 48.
; Large prime coefficient 100003 disguises a clean mod-48 quadratic.
; Coefficients: 100003, (- 3), constant (- 100000). Degree 2.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (= (* 48 A)
           (+ (* 100003 (str.to_int t2))
              (+ (* (- 3) (str.to_int t1))
                 (- 100000)))))
(check-sat)

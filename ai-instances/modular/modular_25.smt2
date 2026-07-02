; modular_25.smt2
; Encoding: 89*t^2 (- 2)*t ≡ 0 (mod 44)
; Meaning: 89 is prime, 44 = 4*11. 89 ≡ 1 mod 44, so this is t^2 - 2t ≡ 0 mod 44,
; i.e. t*(t-2) ≡ 0 mod 44.
; Mod 4: t*(t-2) ≡ 0 mod 4. If t even: t=2k, 2k*(2k-2)=4k(k-1)≡0 mod 4. Always.
;   If t odd: t*(t-2) = odd*odd ≡ 1 mod 2. Never div by 4.
; Mod 11: t*(t-2) ≡ 0 mod 11 iff t≡0 or t≡2 mod 11.
; Combined: t even AND (t≡0 or 2 mod 11). By CRT mod 44.
; The reduction 89≡1 mod 44 makes this particularly clean.
; Coefficients: 89, 2. Degree 2. Length+degree = 2+2 = 4. Fine.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (= (* 44 A)
           (+ (* 89 (str.to_int t2))
              (* (- 2) (str.to_int t1)))))
(check-sat)

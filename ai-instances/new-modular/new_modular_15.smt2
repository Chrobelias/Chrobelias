; new_modular_15.smt2
; Encoding: t^3 + t^2 + t + 1 ≡ 0 (mod 16)
; Meaning: (t+1)*(t^2+1) ≡ 0 mod 16. Factor!
; t^2+1 is always odd (for any integer t), so all factors of 2 must come from (t+1).
; Need 16 | (t+1), i.e. t ≡ 15 ≡ (- 1) mod 16.
; The constant +1 enables this clean factorization. 
; SAT iff t ≡ (- 1) mod 16.
; Coefficients: 1, 1, 1, constant 1. Degree 3. Length+degree = 1+3 = 4.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(declare-fun t3 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (str.in_re t3 (re.++ (re.* (str.to_re "0")) (str.to_re "1000"))))
(assert (= (* 16 A)
           (+ (str.to_int t3)
              (+ (str.to_int t2)
                 (+ (str.to_int t1)
                    1)))))
(check-sat)

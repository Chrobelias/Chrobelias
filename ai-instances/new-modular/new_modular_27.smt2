; new_modular_27.smt2
; Encoding: 71*t^4 + (- 71)*t^2 + 35 ≡ 0 (mod 30)
; Meaning: 71 prime, 30=2*3*5. 71*(t^4-t^2)+35 ≡ 0 mod 30.
; 71≡1 mod 5, 71≡2 mod 3, 71≡1 mod 2. 35=5*7.
; Mod 2: (t^4-t^2)+1 ≡ t^2(t^2-1)+1 = t^2(t-1)(t+1)+1. 
;   t odd: t^2≡1,(t-1)(t+1) even, so 1*even+1≡1 mod 2. ✗
;   t even: t^2≡0, 0+1≡1 mod 2. ✗. Hmm, always 1 mod 2? UNSAT mod 2, hence UNSAT overall.
; Wait: 35≡1 mod 2, 71≡1. So t^4-t^2+1 ≡ 0 mod 2.
;   t^4-t^2=(t^2)(t^2-1) always even, so t^4-t^2+1 always odd. UNSAT.
; Good: a disguised UNSAT instance where the constant 35 creates a parity obstruction.
; Coefficients: 71, (- 71), constant 35. Degree 4. Length+degree = 2+4 = 6.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t2 () String)
(declare-fun t4 () String)
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (str.in_re t4 (re.++ (re.* (str.to_re "0")) (str.to_re "10000"))))
(assert (= (* 30 A)
           (+ (* 71 (str.to_int t4))
              (+ (* (- 71) (str.to_int t2))
                 35))))
(check-sat)

; new_modular_34.smt2
; Encoding: 32768*t^4 + (- 32768)*t^2 + (- 1) ≡ 0 (mod 11)
; Meaning: 32768 = 2^15. By Fermat, 2^10 ≡ 1 mod 11, so 2^15 = 2^10 * 2^5 ≡ 2^5 = 32 ≡ 10 ≡ (- 1) mod 11.
; So (- 1)*(t^4 - t^2) - 1 ≡ 0 mod 11, i.e. t^4 - t^2 + 1 ≡ 0 mod 11 (multiplying by (- 1)).
; Wait: (- 1)*(t^4-t^2) - 1 ≡ 0 iff (- 1)*(t^4-t^2) ≡ 1 iff t^4-t^2 ≡ (- 1) ≡ 10 mod 11.
; t^2*(t^2-1) ≡ 10 mod 11.
; t=1: 0 ≠ 10. t=2: 4*3=12≡1. t=3: 9*8=72≡6. t=4: 16*15≡5*4=20≡9. t=5: 25*24≡3*2=6.
; t=6: 36*35≡3*2=6. t=7: 49*48≡5*4=20≡9. t=8: 64*63≡9*8=72≡6. t=9: 81*80≡4*3=12≡1. t=10: 100*99≡1*0=0.
; None equal 10. UNSAT — the large power-of-2 coefficient creates an impossible condition.
; Coefficients: 32768, (- 32768), constant (- 1). Degree 4.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t2 () String)
(declare-fun t4 () String)
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (str.in_re t4 (re.++ (re.* (str.to_re "0")) (str.to_re "10000"))))
(assert (= (* 111 A)
           (+ (* 32768 (str.to_int t4))
              (+ (* (- 32768) (str.to_int t2))
                 (- 1)))))
(check-sat)

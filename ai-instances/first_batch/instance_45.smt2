; Instance 45
; Meaning: A "valuation parity" test via disjunction.
; We have x and assert that either:
;   (a) v(x) = v(4x)  — impossible in base 2, possible in base 3
;   (b) v(x) = v(9x)  — impossible in base 3, possible in base 2
; XOR: exactly one of (a) or (b) holds, not both.
; In base 2: (a) fails (v_2(4x)=4*v_2(x) ≠ v_2(x)), (b) holds (9 is odd). So (b) only. SAT.
; In base 3: (a) holds (4 coprime to 3), (b) fails (v_3(9x)=9*v_3(x)). So (a) only. SAT.
; In base 6 (composite): both might hold simultaneously. Then the XOR fails. UNSAT?

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun v1 () Int)
(declare-fun v4 () Int)
(declare-fun v9 () Int)
(assert
  (and
    (> x 0)
    (int.v x v1)
    (int.v (+ x (+ x (+ x x))) v4)
    (int.v (+ x (+ x (+ x (+ x (+ x (+ x (+ x (+ x x)))))))) v9)
    (or
      (and (= v1 v4) (not (= v1 v9)))
      (and (= v1 v9) (not (= v1 v4)))
    )
  )
)
(check-sat)

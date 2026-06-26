; Instance 03
; Meaning: Is there x > 0 such that v(x, x)?
; i.e. x is itself a power of the base (the largest power of the base dividing x is x itself).
; In base 2: SAT — e.g. x=1 (v_2(1)=1), or x=2 (v_2(2)=2).
; In base 3: SAT — e.g. x=1, x=3, x=9.
; In any base: SAT (powers of the base satisfy this).

(set-logic QF_SLIA)
(declare-fun x () Int)
(assert
  (and
    (> x 0)
    (int.v x x)
  )
)
(check-sat)

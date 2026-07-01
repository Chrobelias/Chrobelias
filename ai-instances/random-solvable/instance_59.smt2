; Instance 59
; Meaning: x and its valuation vx satisfy: x is between two large consecutive
; powers of 2, and vx itself is between two large consecutive powers of 3.
; 1048576 = 2^20, 2097152 = 2^21, 531441 = 3^12, 1594323 = 3^13.
; This is a very tight arithmetic box — likely UNSAT in most bases but
; potentially SAT if the base aligns with both constraints simultaneously.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun vx () Int)
(assert
  (and
    (> x 0)
    (int.v x vx)
    (<= 1048576 x)
    (<= x 2097152)
    (<= 531441 vx)
    (<= vx 1594323)
  )
)
(check-sat)

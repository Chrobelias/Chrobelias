; mixed_30.smt2
; C in 0*10 (encodes t). D in 0*100 (encodes t^2).
; int.v A E: E = v_t(A). Modular constraint: 250*B = A - E, 0 <= E <= 166.
; Combines base encoding, t^2, valuation, discrete-log modular style.
; Five variables total.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun C () String)
(declare-fun E () Int)
(assert (str.in_re A (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (int.v A E))
(assert (= (* 51 (str.to_int C)) (- A E)))
(assert (<= 10 E))
(assert (<= E 16))
(assert (not (= A E)))
(check-sat)

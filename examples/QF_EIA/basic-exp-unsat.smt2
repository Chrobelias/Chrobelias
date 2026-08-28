; unsat
(set-logic QF_EIA)
(set-option :produce-models true)
(declare-fun x () Int)

(assert (> x (** 2 x)))

(check-sat)

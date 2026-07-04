; mixed_25.smt2
; C in (0*10)+ — one or more copies of 0*10, i.e. strings that are concatenations of "t-blocks".
; No int.v. Four integer variables.
; This is a less standard regex but valid over {0,1}: matches e.g. "10", "010", "1010", "10010", etc.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun B () Int)
(declare-fun D () Int)
(declare-fun C () String)
(assert (str.in_re C (re.+ (re.++ (re.* (str.to_re "0")) (str.to_re "10")))))
(assert (int.v (str.to_int C) (+ 1 (* (- 4) A) (* 3 B))))
(assert (>= (+ (* (- 4) A) (* 3 B)) 999))
(check-sat)

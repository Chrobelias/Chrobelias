(set-logic QF_S)

(declare-fun var_5 () String)
(declare-fun var_6 () String)

(assert (str.in_re var_5 (re.* (re.range "c" "u"))))
(assert (str.in_re (str.++ var_5 var_6) (re.* (str.to_re "aaa"))))
(check-sat)
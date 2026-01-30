
  $ Chro -no-over -bound -1 --dpresimpl --dir --stop-after simpl ../examples/issue150.smt2 2>&1 | sed 's/[[:space:]]*$//'
  (and
    (= (* 1171 w) (+ x (* 444 u)))
    (<= 0 strlenx)
    (<= 0 (* 444 u))
    (<= strlenx 99)
    (<= u 2)
    (str.in_re.raw x)
    (chrob.len x (exp 10 strlenx)))
$ Chro -no-over-approx -bound -1 issue117.smt2 | sed 's/[[:space:]]*$//'


  $ timeout 5 Chro -no-over -bound -1 -bstates 10 -bres 1 ../examples/issue150.smt2 2>&1 | sed 's/[[:space:]]*$//'
  timeout

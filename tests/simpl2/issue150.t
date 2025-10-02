
  $ CHRO_DEBUG=1 Chro -no-over-approx -bound -1 -dpresimpl -dir -stop-after simpl ../examples/issue150.smt2 2>&1 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (= %0 (str.len x))
             (<= (+ %0 1) 100)
             (= v (* u 444))
             (= (* 1171 w) (+ (str.to.int x) v))
             (<= (+ v 1) 1171)
             (<= 0 v)
             (str.in_re x (re.++ (re.++ (re.++ (re.++ (str.to.re "9") (re.++ (str.to.re "8") (re.++ (str.to.re "7") (str.to.re "6")))) (re.* (re.union (re.union (re.union (re.union (re.union (re.union (re.union (re.union (re.union (str.to.re "0") (str.to.re "1")) (str.to.re "2")) (str.to.re "3")) (str.to.re "4")) (str.to.re "5")) (str.to.re "6")) (str.to.re "7")) (str.to.re "8")) (str.to.re "9")))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (str.to.re "1")))))) (re.* (str.to.re "")))))
  iter(2)= (and
             (= %0 (str.len x))
             (= v (* 444 u))
             (= (* 1171 w) (+ v (str.to.int x)))
             (<= %0 99)
             (<= v 1170)
             (<= 0 v)
             (str.in_re x (re.++ (re.++ (re.++ (re.++ (str.to.re "9") (re.++ (str.to.re "8") (re.++ (str.to.re "7") (str.to.re "6")))) (re.* (re.union (re.union (re.union (re.union (re.union (re.union (re.union (re.union (re.union (str.to.re "0") (str.to.re "1")) (str.to.re "2")) (str.to.re "3")) (str.to.re "4")) (str.to.re "5")) (str.to.re "6")) (str.to.re "7")) (str.to.re "8")) (str.to.re "9")))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (str.to.re "1")))))) (re.* (str.to.re "")))))
  (and
    (= %0 (str.len x))
    (= v (* 444 u))
    (= (* 1171 w) (+ v (str.to.int x)))
    (<= %0 99)
    (<= v 1170)
    (<= 0 v)
    (str.in_re x (re.++ (re.++ (re.++ (re.++ (str.to.re "9") (re.++ (str.to.re "8") (re.++ (str.to.re "7") (str.to.re "6")))) (re.* (re.union (re.union (re.union (re.union (re.union (re.union (re.union (re.union (re.union (str.to.re "0") (str.to.re "1")) (str.to.re "2")) (str.to.re "3")) (str.to.re "4")) (str.to.re "5")) (str.to.re "6")) (str.to.re "7")) (str.to.re "8")) (str.to.re "9")))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (str.to.re "1")))))) (re.* (str.to.re "")))))
  Simplify step: (%0 = (str.len x) & v = (* 444 * u) & (* 1171 * w) = (+ v + (str.to.int x)) & %0 <= 99 & v <= 1170 & 0 <= v & (str.in_re x (re.++ (re.++ (re.++ (re.++ (str.to.re "9") (re.++ (str.to.re "8") (re.++ (str.to.re "7") (str.to.re "6")))) (re.* (re.union (re.union (re.union (re.union (re.union (re.union (re.union (re.union (re.union (str.to.re "0") (str.to.re "1")) (str.to.re "2")) (str.to.re "3")) (str.to.re "4")) (str.to.re "5")) (str.to.re "6")) (str.to.re "7")) (str.to.re "8")) (str.to.re "9")))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (str.to.re "1")))))) (re.* (str.to.re "")))))
  Simplified expression: (%0 = (str.len x) & v = (* 444 * u) & (* 1171 * w) = (+ v + (str.to.int x)) & %0 <= 99 & v <= 1170 & 0 <= v & (str.in_re x (re.++ (re.++ (re.++ (re.++ (str.to.re "9") (re.++ (str.to.re "8") (re.++ (str.to.re "7") (str.to.re "6")))) (re.* (re.union (re.union (re.union (re.union (re.union (re.union (re.union (re.union (re.union (str.to.re "0") (str.to.re "1")) (str.to.re "2")) (str.to.re "3")) (str.to.re "4")) (str.to.re "5")) (str.to.re "6")) (str.to.re "7")) (str.to.re "8")) (str.to.re "9")))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (str.to.re "1")))))) (re.* (str.to.re "")))))
  iter(1)= (and
             (and
               (= (+ (* (- 1) %1) (* 1 %0)) 0)
               (= %2 (chrob.len x))
               (= (+ (* 1 (exp 10 %1)) (* (- 1) %2)) 1))
             (and
               (= (+ (* 1 v) (* (- 444) u)) 0))
             (and
               (= (+ (* 1171 w) (* (- 1) v) (* (- 1) %3)) 0)
               (= %3 (chrob.stoi x)))
             (and
               (<= (+ (* 1 %0)) 99))
             (and
               (<= (+ (* 1 v)) 1170))
             (and
               (<= (+ (* (- 1) v)) 0))
             (str.in_re x (re.++ (re.++ (re.++ (re.++ (str.to.re "9") (re.++ (str.to.re "8") (re.++ (str.to.re "7") (str.to.re "6")))) (re.* (re.union (re.union (re.union (re.union (re.union (re.union (re.union (re.union (re.union (str.to.re "0") (str.to.re "1")) (str.to.re "2")) (str.to.re "3")) (str.to.re "4")) (str.to.re "5")) (str.to.re "6")) (str.to.re "7")) (str.to.re "8")) (str.to.re "9")))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (str.to.re "1")))))) (re.* (str.to.re "")))))
  iter(2)= (and
             (= %2 (chrob.len x))
             (= %3 (chrob.stoi x))
             (= (+ %0 (* (- 1) %1)) 0)
             (= (+ v (* (- 444) u)) 0)
             (= (+ (* (- 1) %2) (exp 10 %1)) 1)
             (= (+ (* (- 1) %3) (* (- 1) v) (* 1171 w)) 0)
             (<= %0 99)
             (<= v 1170)
             (<= (* (- 1) v) 0)
             (str.in_re x (re.++ (re.++ (re.++ (re.++ (str.to.re "9") (re.++ (str.to.re "8") (re.++ (str.to.re "7") (str.to.re "6")))) (re.* (re.union (re.union (re.union (re.union (re.union (re.union (re.union (re.union (re.union (str.to.re "0") (str.to.re "1")) (str.to.re "2")) (str.to.re "3")) (str.to.re "4")) (str.to.re "5")) (str.to.re "6")) (str.to.re "7")) (str.to.re "8")) (str.to.re "9")))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (str.to.re "1")))))) (re.* (str.to.re "")))))
  Something ready to substitute:  %0 -> %1; v -> (* 444 u);
  iter(3)= (and
             (= %2 (chrob.len x))
             (= %3 (chrob.stoi x))
             (= (+ %0 (* (- 1) %1)) 0)
             (= (+ v (* (- 444) u)) 0)
             (= (+ (* (- 1) %2) (exp 10 %1)) 1)
             (= (+ (* (- 1) %3) (* (- 1) v) (* 1171 w)) 0)
             (<= %0 99)
             (<= v 1170)
             (<= (* (- 1) v) 0)
             (str.in_re x (re.++ (re.++ (re.++ (re.++ (str.to.re "9") (re.++ (str.to.re "8") (re.++ (str.to.re "7") (str.to.re "6")))) (re.* (re.union (re.union (re.union (re.union (re.union (re.union (re.union (re.union (re.union (str.to.re "0") (str.to.re "1")) (str.to.re "2")) (str.to.re "3")) (str.to.re "4")) (str.to.re "5")) (str.to.re "6")) (str.to.re "7")) (str.to.re "8")) (str.to.re "9")))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (str.to.re "1")))))) (re.* (str.to.re "")))))
  iter(4)= (and
             (= %2 (chrob.len x))
             (= %3 (chrob.stoi x))
             (= (+ (* (- 444) u) (* (- 1) %3) (* 1171 w)) 0)
             (= (+ (* (- 1) %2) (exp 10 %1)) 1)
             (<= %1 99)
             (<= (* (- 444) u) 0)
             (<= (* 444 u) 1170)
             (str.in_re x (re.++ (re.++ (re.++ (re.++ (str.to.re "9") (re.++ (str.to.re "8") (re.++ (str.to.re "7") (str.to.re "6")))) (re.* (re.union (re.union (re.union (re.union (re.union (re.union (re.union (re.union (re.union (str.to.re "0") (str.to.re "1")) (str.to.re "2")) (str.to.re "3")) (str.to.re "4")) (str.to.re "5")) (str.to.re "6")) (str.to.re "7")) (str.to.re "8")) (str.to.re "9")))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (str.to.re "1")))))) (re.* (str.to.re "")))))
  Something ready to substitute:  %0 -> %1; %3 -> (+ (* (- 444) u) (* 1171 w)); v ->
                                 (* 444 u);
  iter(5)= (and
             (= %2 (chrob.len x))
             (= %3 (chrob.stoi x))
             (= (+ (* (- 444) u) (* (- 1) %3) (* 1171 w)) 0)
             (= (+ (* (- 1) %2) (exp 10 %1)) 1)
             (<= %1 99)
             (<= (* (- 444) u) 0)
             (<= (* 444 u) 1170)
             (str.in_re x (re.++ (re.++ (re.++ (re.++ (str.to.re "9") (re.++ (str.to.re "8") (re.++ (str.to.re "7") (str.to.re "6")))) (re.* (re.union (re.union (re.union (re.union (re.union (re.union (re.union (re.union (re.union (str.to.re "0") (str.to.re "1")) (str.to.re "2")) (str.to.re "3")) (str.to.re "4")) (str.to.re "5")) (str.to.re "6")) (str.to.re "7")) (str.to.re "8")) (str.to.re "9")))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (str.to.re "1")))))) (re.* (str.to.re "")))))
  iter(6)= (and
             (= %2 (chrob.len x))
             (= (+ (* (- 444) u) (* 1171 w)) (chrob.stoi x))
             (= (+ (* (- 444) u) (* 1171 w) (* (* (- 444) u) (- 1))
                (* (* 1171 w) (- 1))) 0)
             (= (+ (* (- 1) %2) (exp 10 %1)) 1)
             (<= %1 99)
             (<= (* (- 444) u) 0)
             (<= (* 444 u) 1170)
             (str.in_re x (re.++ (re.++ (re.++ (re.++ (str.to.re "9") (re.++ (str.to.re "8") (re.++ (str.to.re "7") (str.to.re "6")))) (re.* (re.union (re.union (re.union (re.union (re.union (re.union (re.union (re.union (re.union (str.to.re "0") (str.to.re "1")) (str.to.re "2")) (str.to.re "3")) (str.to.re "4")) (str.to.re "5")) (str.to.re "6")) (str.to.re "7")) (str.to.re "8")) (str.to.re "9")))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (str.to.re "1")))))) (re.* (str.to.re "")))))
  iter(7)= (and
             (= %2 (chrob.len x))
             (= (+ (* (- 444) u) (* 1171 w)) (chrob.stoi x))
             (= (+ (* (- 1) %2) (exp 10 %1)) 1)
             (<= %1 99)
             (<= (* (- 444) u) 0)
             (<= (* 444 u) 1170)
             (str.in_re x (re.++ (re.++ (re.++ (re.++ (str.to.re "9") (re.++ (str.to.re "8") (re.++ (str.to.re "7") (str.to.re "6")))) (re.* (re.union (re.union (re.union (re.union (re.union (re.union (re.union (re.union (re.union (str.to.re "0") (str.to.re "1")) (str.to.re "2")) (str.to.re "3")) (str.to.re "4")) (str.to.re "5")) (str.to.re "6")) (str.to.re "7")) (str.to.re "8")) (str.to.re "9")))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (str.to.re "1")))))) (re.* (str.to.re "")))))
  Simplify step: (%2 = (chrob.len x) & (+ (* -444 * u) + (* 1171 * w)) = (chrob.stoi x) & (+ (* -1 * %2) + (10 ** %1)) = 1 & %1 <= 99 & (* -444 * u) <= 0 & (* 444 * u) <= 1170 & (str.in_re x (re.++ (re.++ (re.++ (re.++ (str.to.re "9") (re.++ (str.to.re "8") (re.++ (str.to.re "7") (str.to.re "6")))) (re.* (re.union (re.union (re.union (re.union (re.union (re.union (re.union (re.union (re.union (str.to.re "0") (str.to.re "1")) (str.to.re "2")) (str.to.re "3")) (str.to.re "4")) (str.to.re "5")) (str.to.re "6")) (str.to.re "7")) (str.to.re "8")) (str.to.re "9")))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (str.to.re "1")))))) (re.* (str.to.re "")))))
  Simplified expression: (%2 = (chrob.len x) & (+ (* -444 * u) + (* 1171 * w)) = (chrob.stoi x) & (+ (* -1 * %2) + (10 ** %1)) = 1 & %1 <= 99 & (* -444 * u) <= 0 & (* 444 * u) <= 1170 & (str.in_re x (re.++ (re.++ (re.++ (re.++ (str.to.re "9") (re.++ (str.to.re "8") (re.++ (str.to.re "7") (str.to.re "6")))) (re.* (re.union (re.union (re.union (re.union (re.union (re.union (re.union (re.union (re.union (str.to.re "0") (str.to.re "1")) (str.to.re "2")) (str.to.re "3")) (str.to.re "4")) (str.to.re "5")) (str.to.re "6")) (str.to.re "7")) (str.to.re "8")) (str.to.re "9")))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (str.to.re "1")))))) (re.* (str.to.re "")))))
  Fatal error: exception Invalid_argument("result is Error _")
  Raised at Stdlib.invalid_arg in file "stdlib.ml" (inlined), line 30, characters 20-45
  Called from Stdlib__Result.get_ok in file "result.ml", line 21, characters 45-76
  Called from Lib__Solver.check_sat in file "lib/solver.ml", line 1368, characters 15-48
  Called from Dune__exe__Chro.check_sat in file "bin/chro.ml", line 151, characters 17-40
  Called from Dune__exe__Chro.exec in file "bin/chro.ml", line 251, characters 16-43
  Called from Stdlib__List.fold_left in file "list.ml", line 123, characters 24-34
  Called from Dune__exe__Chro in file "bin/chro.ml", lines 299-302, characters 4-7
$ Chro -no-over-approx -bound -1 issue117.smt2 | sed 's/[[:space:]]*$//'



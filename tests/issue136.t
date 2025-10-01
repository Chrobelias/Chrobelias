  $ cat > 2.smt2 <<-EOF
  > (set-logic QF_S)
  > (declare-const x String)
  > (declare-const y String)
  > (declare-const u Int)
  > (declare-const z Int)
  > ;(assert (<= (str.len x) 1000000000000000000))
  > ;(assert (<= (str.len y) 1000000000000000000))
  > ;(assert (<= (str.len y) 4))
  > (assert (str.in.re x (re.++ (str.to.re "1") (re.* (re.union (str.to.re "00") (str.to.re "99"))))))
  > (assert (str.in.re y (re.+ (str.to.re "9"))))
  > (assert (= (+ 2 (str.len x)) (str.to.int y)))
  > (assert (= (str.len y) (* 2 z)))
  > (assert (<= z 2))
  > (assert (< (str.len x) u))
  > (check-sat)
  > (get-model)
  > EOF

  $ export CHRO_LONGEST_PATH=100
  $ timeout 2 Chro -no-over-approx -bound 0 2.smt2 | sed 's/[[:space:]]*$//'
  sat (nfa)
  ; model is TOO big on 1st attempt
  Shrinked AST: (and
                  (<= (str.len y) 1000000000000000000)
                  (<= (str.len x) 1000000000000000000)
                  (and
                    (<= (+ (str.len x) 1) u)
                    (<= z 2)
                    (= (str.len y) (* 2 z))
                    (= (+ 2 (str.len x)) (str.to.int y))
                    (str.in_re y (re.++ (re.++ (str.to.re "9") (re.* (str.to.re "9"))) (re.* (str.to.re ""))))
                    (str.in_re x (re.++ (re.++ (re.* (re.union (re.++ (str.to.re "0") (str.to.re "0")) (re.++ (str.to.re "9") (str.to.re "9")))) (str.to.re "1")) (re.* (str.to.re ""))))))
  ((define-fun u () (_ Int) 1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000)
   (define-fun x () (_ String) "1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
   (define-fun y () (_ String) "99")
   (define-fun z () (_ Int) 1))


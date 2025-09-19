
  $ timeout 2 Chro -no-over-approx -bound -1 -dsimpl -flat 0 -amin 0 -amax 0 -lsb issue92.smt2  | sed 's/[[:space:]]*$//'
  (assert (exists (z)
          (and
            (<= (* (- 1) pow2(u1))  -1000)
            (<= (* (- 1) z)  -10)
            (= (+ eee2 (* (- 1) u1) (* (- 1) z) )  0)
            (exists (y)
            (and
              (<= y  1050000)
              (= (+ (* (- 1) y) pow2(eee2) )  0)
              )
            )
  )
  (assert (<= (+ (* (- 1) eee2) pow2(u1) )  0) )
  (assert (<= (+ eee2 (* (- 1) pow2(eee2)) )  0) )
  (assert (<= (+ u1 (* (- 1) pow2(u1)) )  0) )
  
  (assert (<= (+ (* (- 1) eee2) u1 )  0) )
  (assert (<= (+ eee2 (* (- 1) pow2(u1)) )  0) )
  (assert (<= (+ (* (- 1) pow2(eee2)) pow2(u1) )  0) )
  
  sat (under II)
  $ timeout 2 Chro -no-mini-in-semenov -no-over-approx -bound -1 -dsimpl -under2 -amin 0 -amax 0 -lsb issue92.smt2  | sed 's/[[:space:]]*$//'
  Chro: unknown option '-no-mini-in-semenov'.
  Chrobak normal form-based Exponential Linear Integer Arithmetic Solver.
  Usage: chro [options] <file.smt2>
  
  List options using -help or --help.
  
    -stop-after  Stop after step
    -error-check  
    -no-model  
    -no-error-check  
    -pre-simpl  
    -no-pre-simpl  
    --no-simpl-alpha  Don't try simplifications based on alpha-equivalence
    --no-simpl-mono  
    -dsimpl  Dump simplifications
    -dir  Dump IR
    -dpresimpl  Dump AST simplifications
    -bound  Set underapprox. bound (negative disables)
    -over-approx  Simple overapproximation (issue #75)
    -no-over-approx  Disable simple overapproximation (issue #75)
    -lsb  Use least-significant-bit first representation (only supports nats)
    -flat  <N> Underapproximation 2 of (* x (exp 2 y)). N >=0. 
    -amin  <n> Parameter of underapprox.2. Matters when N>=2
    -amax  <n> Parameter of underapprox.2. Matters when N>=2
    -help  Display this list of options
    --help  Display this list of options

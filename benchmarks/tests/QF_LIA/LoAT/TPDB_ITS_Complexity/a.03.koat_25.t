a.03.koat_25
  $ export OCAMLRUNPARAM='b=0'
$ export CHRO_DEBUG=1
  $ timeout 5 Chro -bound 0 ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/a.03.koat_25.smt2 -under2 -amin 0 -amax 11 || echo TIMEOUT
  Chro: unknown option '-under2'.
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
    -under3  Enable underapprox 3 for string concatenation
    -help  Display this list of options
    --help  Display this list of options
  TIMEOUT

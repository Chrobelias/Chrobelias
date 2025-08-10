  $ ../../bin/swine
  
  ***** SwInE Z3 -- SMT with Integer Exponentiation *****
  
  usage: swine [args] input.smt2
  
  valid arguments:
    --no-prime            : disable prime lemmas
    --no-induction        : disable induction lemmas
    --no-monotonicity     : disable monotonicity lemmas
    --no-interpolation    : disable interpolation lemmas
    --no-bounding         : disable bounding lemmas
    --no-symmetry         : disable symmetry lemmas
    --no-rewriting        : disable rewriting
    --no-constant-folding : disable constant-folding
    --validate-sat        : validate SAT results by evaluating the input w.r.t. solution
    --validate-unsat c    : validate UNSAT results by forcing exponents to values in {0,...,c}, c in IN
    --no-phasing          : disable phasing
    --get-lemmas          : print all lemmas that were used in the final proof if UNSAT is proven, or all lemmas if SAT is shown
    --stats               : print statistics in the end
    --help                : print this text and exit
    --version             : print the SwInE version and exit
    --no-version          : omit the SwInE version at the end of the output
    --log                 : enable logging
  

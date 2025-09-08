Basic QF_S tests

  $ Chro ./qf-s.smt2
  sat (nfa)
  x = abc; 
  sat (nfa)
  sat (nfa)
  unsat
  sat (nfa)
  unsat
  unsat
  sat (nfa)
  sat (nfa)
  unsat
  sat (nfa)
  unsat
  sat (nfa)
   %80 = 999999999999; %79 = 0012; x = 100100100100; 
   %91 = 99999999999999999999999; %90 = 0023; a = 00000000000000000000023; x = BaLyuLyuLyuLyuLyuLyuLyu; 

+  1 sat
+  2 sat
+  3 sat
+  4 unsat
+  5 unsat
+  6 unsat
+  7 unsat
+  8 unsat
+  9 sat
+  10 unsat
+  11 sat
+  12 unsat

5, 8

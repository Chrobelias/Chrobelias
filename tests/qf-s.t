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
  %73 = 0000000000012; %74 = 999999999999; x = 100100100100; 
  %84 = 000000000000000000000023; %85 = 99999999999999999999999; a = 00000000000000000000023; x = LyuBaBaBaBaBaBaBaBaBaBa; 
  %95 = 002; %96 = 99; %97 = 002; %98 = 99; a = Ba; b = 20; 
  sat (nfa)
  %123 = 0000000009; %124 = 00000000010; %125 = 9999999999; x = 1000000000; y = 9; 

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

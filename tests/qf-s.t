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
  %67 = 0000000000012; %68 = 999999999999; x = 100100100100; 
  %78 = 000000000000000000000023; %79 = 99999999999999999999999; a = 00000000000000000000023; x = LyuBaBaBaBaBaBaBaBaBaBa; 
  %89 = 002; %90 = 99; %91 = 002; %92 = 99; a = Ba; b = 20; 
  unsat
  %109 = 002; %110 = 99; %111 = 01; %112 = 002; %113 = 99; a = Ba; b = 01; q = 02; 
  %130 = 0000000000000000000000001; %131 = 000000000000000000000009; %132 = 0000000000000000000000024; %133 = 999999999999999999999999; a = BabBabBabLyubaLyubaLyuba; b = 2; q = 000000000000000000000024; 

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

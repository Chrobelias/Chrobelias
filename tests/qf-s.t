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
  %67 = 0012; %68 = 999999999999; x = 100100100100; 
  %78 = 0023; %79 = 99999999999999999999999; a = 00000000000000000000023; x = LyuBaBaBaBaBaBaBaBaBaBa; 
  %89 = 0002; %90 = 99; %91 = 0002; %92 = 99; a = Ba; b = 20; 
  unsat
  %109 = 0002; %110 = 99; %111 = 01; %112 = 0002; %113 = 99; a = Ba; b = 01; q = 02; 
  %130 = 000001; %131 = 000000000000000000000009; %132 = 000024; %133 = 999999999999999999999999; a = BabBabBabLyubaLyubaLyuba; b = 2; q = 000000000000000000000024; 

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

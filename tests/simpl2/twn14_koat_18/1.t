$ cat input1.smt2
  $ Chro -pre-simpl -dsimpl -stop-after pre-simpl input1.smt2 | sed 's/[[:space:]]*$//'
  
  Expecting 1 choices ...
  
  lib/Underapprox.ml gives early Sat.
  env = {| a!2->0 i3->1 i6->-2 i7->2 it140->2 |}
  sat (under I)

$ /usr/bin/time -f "TIME: %U"
  $ timeout 5 Chro -pre-simpl input1.smt2 | echo "timeout"
  timeout

$ /usr/bin/time -f "TIME: %U"
  $ Chro -no-pre-simpl input1.smt2 | sed 's/[[:space:]]*$//'
  sat (under I)


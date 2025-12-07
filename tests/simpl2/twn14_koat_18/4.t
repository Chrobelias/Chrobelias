$ cat input4.smt2
  $ Chro -pre-simpl -dsimpl -stop-after pre-simpl input4.smt2 | sed 's/[[:space:]]*$//'
  Interesting:
  
  Expecting 1 choices ...
  
  lib/Underapprox.ml gives early Sat.
  env = {| i3->2 i6->-4 i7->-1 it140->3 |}
  sat (under I)

  $ timeout 5 Chro -pre-simpl input4.smt2 || echo "timeout"
  sat (under I)

  $ export CHRO_DEBUG=1

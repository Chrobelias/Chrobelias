$ cat input3.smt2
  $ Chro -pre-simpl -dsimpl -stop-after pre-simpl input3.smt2 | sed 's/[[:space:]]*$//'
  
  Expecting 1 choices ...
  
  lib/Underapprox.ml gives early Sat.
  env = {| i3->2 i6->-4 i7->-1 it140->3 |}
  sat (under I)

$ /usr/bin/time -f "TIME: %U"
  $ timeout 5 Chro -pre-simpl input3.smt2 || echo "timeout"
  sat (under I)

$ export CHRO_DEBUG=1
$ /usr/bin/time -f "TIME: %U"
  $ Chro -no-pre-simpl input3.smt2 -dir -dsimpl 2>&1 | sed 's/[[:space:]]*$//'
  sat (under I)



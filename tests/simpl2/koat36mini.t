  $ cp koat36mini.smt2 input.smt2

$ cat input.smt2
$ export CHRO_DEBUG=1
  $ timeout 2 Chro -dsimpl -pre-simpl input.smt2 -bound 0 -flat 0 -bmax 11 | sed 's/[[:space:]]*$//'
  sat ; underapprox1

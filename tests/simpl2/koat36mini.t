  $ cp koat36mini.smt2 input.smt2

$ cat input.smt2
$ export CHRO_DEBUG=1
  $ timeout 2 Chro -bound 0 -flat 0 -amin 0 -amax 11 --dsimpl --pre-simpl input.smt2 | sed 's/[[:space:]]*$//'
  sat (under I)

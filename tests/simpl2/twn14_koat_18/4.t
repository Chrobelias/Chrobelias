$ cat input4.smt2
  $ CHRO_DEBUG=1 Chro --dsimpl --stop-after pre-simpl input4.smt2 | sed 's/[[:space:]]*$//'

  $ timeout 5 Chro input4.smt2 || echo "timeout"
  sat (under int)

  $ export CHRO_DEBUG=1

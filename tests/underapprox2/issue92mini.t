$ export CHRO_DEBUG=1
  $ timeout 120 Chro -no-over -bound 0 -flat 0 -amin 1 -amax 11 --dsimpl issue92mini.smt2  | sed 's/[[:space:]]*$//'
  sat (nia)



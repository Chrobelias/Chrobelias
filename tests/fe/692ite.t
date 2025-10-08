
  $ Chro 692.smt2 -stop-after presimpl

$ cat > 1.smt2 <<-EOF
> (set-logic ALL))
> (declare-fun a () String)
> (declare-fun b () String)
> (assert
>   (= (ite (str.prefixof "-" b) 1 2)
>       0))
> (check-sat)
> EOF
$ CHRO_DEBUG=1 Chro -pre-simpl -dsimpl -stop-after pre-simpl 1.smt2 | sed 's/[[:space:]]*$//'

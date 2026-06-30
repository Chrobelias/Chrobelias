(lang dune 3.16)

(using directory-targets 0.1)

(name ParSym)

(generate_opam_files true)

(authors "Mikhail Starchak, Alessio Mansutti")

(maintainers "Mikhail Starchak, Alessio Mansutti")

(license MIT)

(package
 (name ParSym)
 (synopsis "Parametric Symbolic Büchi Arithmetic Solver in defferent bases")
 (depends
  ocaml
  dune
  angstrom
  zarith
  bitv
  iter
  ppx_regexp
  ppx_deriving
  ppx_variants_conv
  sexplib
  lwt
  dune-glob
  extunix
  cohttp-lwt-unix
  smtml
  ounit2
  z3
  ppx_expect
  ppx_inline_test
  mdx
  (ocamlformat
   (and
    :dev
    (= 0.29.0))))
 (tags
  (solver theorem)))

(lang dune 3.16)

(name Chrobelias)

(generate_opam_files true)

(source
 (github Chrobelias/Chrobelias))

(authors "Georgiy Belyanin, Timofey Frolov, Dmitry Kosarev")

(maintainers "Georgiy Belyanin, Timofey Frolov, Dmitry Kosarev")

(license MIT)

(package
 (name Chrobelias)
 (synopsis "Chrobak normal form in exp-linear integer arithmetic solver")
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
  smtml
  ounit2
  z3
  ppx_expect
  ppx_inline_test
  mdx
  (ocamlformat :dev))
 (tags
  (solver theorem)))

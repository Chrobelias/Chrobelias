(lang dune 3.16)

(using directory-targets 0.1)

(name Chrobelias)

(generate_opam_files true)

(source
 (github Chrobelias/Chrobelias))

(authors
 "Georgiy Belyanin, Timofey Frolov, Dmitry Kosarev, Mikhail Starchak")

(maintainers
 "Georgiy Belyanin, Timofey Frolov, Dmitry Kosarev, Mikhail Starchak")

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
  (mdx :with-tests)
  (ocamlformat (and :dev (= 0.27.0))))
 (tags
  (solver theorem)))

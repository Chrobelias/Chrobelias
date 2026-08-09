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
 (synopsis
  "Chrobak normal form for exp-linear integer arithmetic and strings")
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
  ppx_inline_test
  (smtml
   (>= 0.28.0))
  ounit2
  ppx_expect
  mdx
  (ocamlformat
   (and
    :dev
    (= 0.29.0))))
 ; The static release build strips z3's OCaml bindings; without them the
 ; native unsat-core support compiles to a stub (see lib/dune).
 (depopts
  (z3
   (>= 4.16.0)))
 (tags
  (solver theorem)))

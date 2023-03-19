(lang dune 3.7)

(name xxh)

(generate_opam_files true)

(license BSD-2-Clause)
(maintainers "Rudi Grinberg <me@rgrinberg.com>")
(authors "Rudi Grinberg <me@rgrinberg.com>")
(source (github rgrinberg/xxh))

(implicit_transitive_deps false)

(package
 (synopsis "xxHash bindings")
 (description "Bindings to the xxHash hash functions")
 (name xxh)
 (depends
  base-unix
  (ppx_expect :with-test)))

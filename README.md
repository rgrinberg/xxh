# Xxh

Bindings to the [xxHash](https://www.xxhash.com) non-cryptographic family of
hash functions

These bindings are designed with the main purpose of using it in
[dune](https://github.com/ocaml/dune). This means it must satisfy dune's
boostrapping constraints:

1. No external build process
2. No complex build steps

If these constraints aren't relevant to you, use the more mature and better
tested [ocaml-xxhash](https://github.com/314eter/ocaml-xxhash)

## License

The sources from xxHash are licensed under BSD 2-Clause License.

For convenience, the bindings are provided under the same license.

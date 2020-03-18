[![docs](https://img.shields.io/badge/doc-online-blue.svg)](https://abeaumont.github.io/ocaml-salsa20)
[![Build Status](https://travis-ci.org/abeaumont/ocaml-salsa20.svg?branch=master)](https://travis-ci.org/abeaumont/ocaml-salsa20)

# Salsa20 family of encryption functions, in pure OCaml

A pure OCaml implementation of [Salsa20](http://cr.yp.to/salsa20.html) encryption function family.

## Installation

```
opam install salsa20
```

## Usage

```ocaml
utop[0]> #require "mirage-crypto";;
utop[1]> #require "mirage-crypto-rng.unix";;
utop[2]> Mirage_crypto_rng_unix.initialize ();;
- : unit = ()
utop[3]> let key = Mirage_crypto_rng.generate 32;;
val key : Cstruct.t = {Cstruct.buffer = <abstr>; off = 0; len = 32}
utop[4]> let nonce = Cstruct.create 8;;
val nonce : Cstruct.t = {Cstruct.buffer = <abstr>; off = 0; len = 8}
utop[5]> #require "salsa20";;
utop[6]> let state = Salsa20.create key nonce;;
val state : Salsa20.t = <abstr>
utop[7]> Salsa20.encrypt (Cstruct.of_string "My secret text") state |> Cstruct.to_string;;
- : string = " 2\\193\\020`\\142\\182\\234\\188H[R\\241V"
```

* Key can either 32 (recommended) or 16 bytes
* Salsa20 state may use a different hashing function,
  the recommended [`Salsa20_core.salsa20_20_core`](https://abeaumont.github.io/ocaml-salsa20-core/Salsa20_core.html#VALsalsa20_20_core) is used by default.

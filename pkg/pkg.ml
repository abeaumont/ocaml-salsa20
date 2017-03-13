#!/usr/bin/env ocaml
#directory "pkg"
#use "topfind"
#require "topkg"
open Topkg

let () =
  Pkg.describe "salsa20" @@ fun _c ->
  Ok [
    Pkg.mllib "salsa20.mllib";
    Pkg.test "salsa20_tests"
  ]

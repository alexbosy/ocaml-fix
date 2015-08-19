#!/usr/bin/env ocaml
#directory "pkg"
#use "topkg.ml"

let () =
  Pkg.describe "fix" ~builder:`OCamlbuild [
    Pkg.lib "pkg/META";
    Pkg.lib ~exts:Exts.library "lib/fix";
    Pkg.lib ~exts:Exts.library "lib/okcoin";
    Pkg.lib ~exts:Exts.module_library "lib/fix_async";
    Pkg.bin ~auto:true "lib_test/fixcat"
  ]
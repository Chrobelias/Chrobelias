{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
    name = "Parsym";
    packages = with pkgs; [ 
      gmp
      opam
      bc
    ];
}

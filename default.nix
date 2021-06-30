{ lib
, ...
}:

let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {};
  gitignore = import sources.gitignore {};
  inherit (gitignore) gitignoreSource gitignoreFilter; 
  naersk = pkgs.callPackage sources.naersk {};

  src = gitignoreSource ./.;

in naersk.buildPackage {
  inherit src;

  buildInputs = with pkgs; [
    dbus
  ];
  nativeBuildInputs = with pkgs; [
    llvmPackages.clang
    openssl
    pkg-config
  ];
  name = "thing";

  SQLX_OFFLINE = true;
}

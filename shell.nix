{ nixpkgs }:

let
  pkgs = import ./nix/release.nix { inherit nixpkgs; };

in pkgs.haskellPackages.shellFor {
  packages = p: [pkgs.haskellPackages.hiss];

  buildInputs = with pkgs.haskellPackages; [
    cabal-install

    ghcid

    hlint
    weeder

    hoogle

    hasktags
    haskdogs

    pretty-simple
    pretty-show
  ];

  shellHook = ''
    export CABAL_DIR=${builtins.toString ./.cabal}
  '';
}

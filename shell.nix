let
  nixpkgs = import ./nix/release.nix;
  native = with nixpkgs; [
    glslang
    pkgconfig
    SDL2
    SDL2_image
    vulkan-headers
    vulkan-loader
    zlib
  ];
  libPath = nixpkgs.lib.makeLibraryPath native;
in nixpkgs.haskellPackages.shellFor {
  packages = p: [nixpkgs.haskellPackages.hiss];

  nativeBuildInputs = native;

  buildInputs = with nixpkgs.haskellPackages; [
    cabal-install

    ghcid

    hlint
    weeder

    hoogle

    hasktags
    haskdogs

    pretty-simple
    pretty-show
  ] ++ native;

  shellHook = ''
    export CABAL_DIR=${builtins.toString ./.cabal}
    export LD_LIBRARY_PATH = ${builtins.trace ("LD_LIBRARY_PATH = " + libPath) libPath}
  '';
}

{
  description = "A flake for buliding the Hiss game";

  inputs = {
    nixpkgs = {
      type = "indirect";
      id = "nixpkgs";
    };
  };

  outputs = { nixpkgs, ... }:
    let pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
      defaultPackage.x86_64-linux = pkgs.mkShell {
        buildInputs = with pkgs;
          [
            glslang
            pkg-config
            SDL2
            SDL2_image
            vulkan-headers
            vulkan-loader
            zlib
          ] ++ (with pkgs.haskellPackages; [
            cabal-install

            ghcid

            hlint
            weeder

            hoogle

            hasktags
            haskdogs

            pretty-simple
            pretty-show
          ]);
      };
    };
}

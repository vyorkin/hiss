{
  description = "A flake for buliding the Hiss game";

  inputs = {
    nixpkgs = {
      type = "indirect";
      id = "nixpkgs";
    };
  };

  outputs = { nixpkgs, ... }: {
    defaultPackage.x86_64-linux =
      import ./shell.nix { nixpkgs = nixpkgs.legacyPackages.x86_64-linux; };
  };
}

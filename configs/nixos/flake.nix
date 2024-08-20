{
  description = "Flake system";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    unstable_nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = {nixpkgs, ...} @ inputs: 
  let
    lib = nixpkgs.lib;
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
    upkgs = import inputs.unstable_nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
  in
  {
    nixosConfigurations.Thinker-Laptop = lib.nixosSystem {
      specialArgs = { inherit pkgs upkgs; };
      modules = [ ./configuration.nix ];
    };
  };
}

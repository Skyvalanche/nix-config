{
  inputs = {
    nixpkgs-stable = {
      url = "github:nixos/nixpkgs/nixos-24.11";
    };

    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:Orysse/nixvim";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    forAllSystems = nixpkgs.lib.genAttrs [
      "x86_64-linux"
    ];
  in {
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

    overlays = import ./overlays {inherit inputs;};

    nixosModules = import ./modules/nixos;

    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = import ./hosts {inherit (self) inputs outputs;};

    homeConfigurations = import ./homes {inherit (self) inputs outputs;};

    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
  };
}

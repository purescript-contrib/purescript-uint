{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs";
    };
    purescript2nix = {
      url = "github:considerate/purescript2nix/considerate/registry";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };
  outputs = inputs:
    inputs.flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [ inputs.purescript2nix.overlay ];
        };
        uint = pkgs.purescript2nix {
          src = ./.;
        };
      in
      {
        packages = {
          default = uint;
        };
        defaultPackage = uint;
      });
}

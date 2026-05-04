{
  description = "Packages for local development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "aarch64-darwin";
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };

    # CLI tools available from nixpkgs.
    cliPackages = with pkgs; [
      awscli2
      caddy
      php83Packages.composer
      doctl
      elixir
      fish
      flyctl
      git
      glab
      hugo
      hurl
      just
      kubectl
      lazygit
      lefthook
      neovim
      nodejs_22
      postgresql_16
      ripgrep
      skopeo
      tmux
      tree-sitter
      universal-ctags
    ];
  in {
    # `nix profile install .#default` — CLI bundle only.
    packages.${system}.default = pkgs.buildEnv {
      name = "local-dev-env";
      paths = cliPackages;
    };
  };
}

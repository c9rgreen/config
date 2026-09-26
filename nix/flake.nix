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
      asciinema
      asdf-vm
      awscli2
      bat
      broot
      caddy
      chafa
      php83Packages.composer
      crane
      doctl
      elixir
      eza
      fastfetch
      fd
      fish
      flyctl
      fzf
      gh
      ghostscript
      git
      glab
      hurl
      imagemagick
      jujutsu
      just
      kubectl
      kustomize
      lefthook
      lf
      neovim
      nodejs
      pandoc
      pnpm
      postgresql_18
      ripgrep
      shellcheck
      skopeo
      starship
      taskwarrior3
      tectonic
      timewarrior
      tmux
      tree-sitter
      typst
      universal-ctags
      zk
      zoxide
    ];
  in {
    # `nix profile install .#default` — CLI bundle only.
    packages.${system}.default = pkgs.buildEnv {
      name = "local-dev-env";
      paths = cliPackages;
    };
  };
}

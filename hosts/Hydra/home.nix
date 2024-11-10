{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      eza bat tealdeer ripgrep

      # Dev Tools
      ## Other
      vscode
      watchman
      python3
      gcc
      ffmpeg

      ## JS
      # nodejs
      # nodePackages.pnpm
      # nodePackages.yarn
    ];
    stateVersion = "24.05";
    
    shellAliases = {
      gst = "git status";
      gsw = "git switch";
      gcam = "git commit -a -m";
      gp = "git push";
      gpl = "git pull";
      gd = "git diff";
      ll = "eza -l";
      la = "eza -la";
      l = "eza";
      ls = "eza";
      lt = "eza --tree --level=3";
      lta = "eza --tree --all";
      cat = "bat --style plain";
    };
  };

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;
      history.size = 10000;

      initExtra = ''
        # Custom envs
        eval "$(${pkgs.starship}/bin/starship init zsh)"
        eval "$(/opt/homebrew/bin/brew shellenv)"

        # Custom paths
        export PATH="/Users/kr4xkan/.cargo/bin:$PATH"
        # export PKG_CONFIG_PATH="/opt/homebrew/opt/<package>/lib/pkgconfig"

        # Any Nix Shell
        ${pkgs.any-nix-shell}/bin/any-nix-shell zsh --info-right | source /dev/stdin
        
        # NVM
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

        # Rust/Cargo env
        export LIBRARY_PATH=$LIBRARY_PATH:$(brew --prefix)/lib:$(brew --prefix)/opt/libiconv/lib
      '';

      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "sudo"
          "battery"
          "direnv"
        ];
      };
    };
    direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}

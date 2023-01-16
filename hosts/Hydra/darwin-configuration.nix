{ config, pkgs, ... }:

{
  environment = {
    shells = [ pkgs.zsh ];

    variables = {
      EDITOR = "vim";
      VISUAL = "vim";
    };

    systemPackages = with pkgs;
      [
        vim
        neofetch
        iterm2
        rustup
        man-pages man-pages-posix
      ];
  };

  documentation.man.enable = true;

  users.users.kr4xkan = {
    home = "/Users/kr4xkan";
    shell = pkgs.zsh;
  };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      source-code-pro
      (nerdfonts.override {
        fonts = [
          "FiraCode"
        ];
      })
    ];
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  programs.zsh = {
    enable = true;
  };

  # Homebrew
  homebrew = {
    enable = true;
    brews = [ ];
    onActivation.cleanup = "uninstall";
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system = {
    stateVersion = 4;
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };
}

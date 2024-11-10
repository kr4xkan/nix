{ config, pkgs, ... }:

{
  imports = [
    ./packages/tidal.nix
  ];

  environment = {
    shells = [ pkgs.zsh ];

    variables = {
      EDITOR = "vim";
      VISUAL = "vim";
    };

    systemPackages = with pkgs;
      [ neofetch ];
  };

  programs.zsh.enable = true;

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

  # Homebrew
  homebrew = {
    enable = true;
    brews = [
        "clang-format"
        "cmake"
        "libiconv"
    ];
    casks = [
        "insomnia"
        "tunnelblick"
        "cyberduck"
		"iterm2"
    ];
    masApps = {
        Termius = 1176074088;
    };
    onActivation.cleanup = "uninstall";
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system = {
    stateVersion = 4;
  };

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };
}

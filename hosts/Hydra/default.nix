{ config, pkgs, lib, ... }:
let
  inherit (pkgs.lib) mkIf optionals;
  inherit (pkgs.stdenv) isLinux isDarwin;
in
{
  users.users.kr4xkan = {
    name = "kr4xkan";
    home = "/Users/kr4xkan";
  };
  services.nix-daemon.enable = true;

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.users.kr4xkan = { config, pkgs, lib, ... }: {
    programs.home-manager.enable = true;
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      initExtra = ''
        eval "$(${pkgs.starship}/bin/starship init zsh)"
      '';
    };
    home = {
      stateVersion = "22.11";
      packages = with pkgs; [
        nodejs

        lolcat

        exa bat starship
        neovim

        iterm2
      ];
    };
    home.activation = mkIf pkgs.stdenv.isDarwin {
      copyApplications = let
        apps = pkgs.buildEnv {
          name = "home-manager-applications";
          paths = config.home.packages;
          pathsToLink = "/Applications";
        };
      in lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          baseDir="$HOME/Applications/Home Manager Apps"
          if [ -d "$baseDir" ]; then
            rm -rf "$baseDir"
          fi
          mkdir -p "$baseDir"
          for appFile in ${apps}/Applications/*; do
            target="$baseDir/$(basename "$appFile")"
            $DRY_RUN_CMD cp ''${VERBOSE_ARG:+-v} -fHRL "$appFile" "$baseDir"
            $DRY_RUN_CMD chmod ''${VERBOSE_ARG:+-v} -R +w "$target"
          done
      '';
    }; 
  };
}

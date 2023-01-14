{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      exa bat tealdeer

      # For neovim
      lolcat
    ];
    stateVersion = "22.11";
    
    shellAliases = {
      gst = "git status";
      gsw = "git switch";
      gcam = "git commit -a -m";
      gp = "git push";
      gpl = "git pull";
      gd = "git diff";
      ll = "exa -l";
      la = "exa -la";
      l = "exa";
      ls = "exa";
      lt = "exa --tree --level=3";
      lta = "exa --tree --all";
      cat = "bat --style plain";
    };
  };

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      enableAutosuggestions = true;
      history.size = 10000;

      initExtra = ''
        eval "$(${pkgs.starship}/bin/starship init zsh)"
      '';

      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "sudo"
          "battery"
        ];
      };
    };
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}

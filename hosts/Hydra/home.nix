{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      exa bat
    ];
    stateVersion = "22.11";
  };

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      history.size = 10000;

      initExtra = ''
        eval "$(${pkgs.starship}/bin/starship init zsh)"
      '';
    };
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}

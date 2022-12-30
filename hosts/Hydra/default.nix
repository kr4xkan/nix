{ pkgs, ... }:
{

  # Make sure the nix daemon always runs
  services.nix-daemon.enable = true;

  programs.zsh.enable = true;
  
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.kr4xkan = { pkgs, ... }: {
    programs.home-manager.enable = true;
    home = {
      stateVersion = "22.11";
      packages = with pkgs; [
        nodejs
      ];
    };
  };
}

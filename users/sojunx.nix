{ config, pkgs, ... }:

{
  imports = [ ../home ];

  home.username = "sojunx";
  home.homeDirectory = "/home/sojunx";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [ nitch ];

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  programs.fish.enable = true;
  programs.home-manager.enable = true;
}

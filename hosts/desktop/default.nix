{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Enable Flakes feature
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.kernelModules = [ "amdgpu" ];

  # Networking
  networking.hostName = "nixos"; 
  networking.networkmanager.enable = true;

  # Locale & timezone
  time.timeZone = "Asia/Ho_Chi_Minh";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "vi_VN";
    LC_IDENTIFICATION = "vi_VN";
    LC_MEASUREMENT = "vi_VN";
    LC_MONETARY = "vi_VN";
    LC_NAME = "vi_VN";
    LC_NUMERIC = "vi_VN";
    LC_PAPER = "vi_VN";
    LC_TELEPHONE = "vi_VN";
    LC_TIME = "vi_VN";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account
  users.users.sojunx = {
    isNormalUser = true;
    description = "sojunx";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
 
  # Fonts
  fonts.packages = with pkgs; [ 
    inter
    nerd-fonts.jetbrains-mono 
  ];

  fonts.fontconfig.defaultFonts = {
    sansSerif = [ "Inter" ];
    monospace = [ "JetBrainsMono Nerd Font" ];
  };

  # System packages
  environment.systemPackages = with pkgs; [
    vim 
    wget
    git
    tree
    curl

    kitty
    swww
    wl-clipboard
    tofi
    quickshell

    # SDDM Theme
    (pkgs.stdenv.mkDerivation {
      name = "pixie-sddm";
      src = pkgs.fetchFromGitHub {
        owner = "xCaptaiN09";
        repo = "pixie-sddm";
        rev = "main";
        sha256 = "sha256-lmE/49ySuAZDh5xLochWqfSw9qWrIV+fYaK5T2Ckck8=";
      };
      installPhase = ''
        mkdir -p $out/share/sddm/themes/pixie
        cp -r * $out/share/sddm/themes/pixie/
      '';
    })

    # Packages for sddm theme
    kdePackages.qtdeclarative
    kdePackages.qtsvg
  ];

  programs.firefox.enable = true;
  programs.hyprland.enable = true;
  programs.fish.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "pixie";
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  system.stateVersion = "26.05"; 
}

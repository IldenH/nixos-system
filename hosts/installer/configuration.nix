{
  modulesPath,
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  services.openssh.enable = true;
  services.upower.enable = true;

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  networking.networkmanager.enable = true;
  networking.wireless.enable = lib.mkForce false;
  users.users.nixos.extraGroups = ["networkmanager"];

  programs.git.enable = true;
  programs.neovim.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-tty;
  };

  environment.systemPackages = with pkgs; [
    fzf
    jq
  ];

  console = {
    keyMap = "no";
    colors = with inputs.nix-colors.colorSchemes.gruvbox-dark-medium.palette; [
      "${base00}" # black
      "${base08}" # red
      "${base0B}" # green
      "${base0A}" # yellow
      "${base0D}" # blue
      "${base0E}" # magenta
      "${base0C}" # cyan
      "${base05}" # gray
      "${base03}" # darkgray
      "${base08}" # lightred
      "${base0B}" # lightgreen
      "${base0A}" # lightyellow
      "${base0D}" # lightblue
      "${base0E}" # lightmagenta
      "${base0C}" # lightcyan
      "${base06}" # white
    ];
  };

  environment.etc."installer/gpg-key.asc".source = ../../secrets/gpg-key.asc;
  environment.etc."installer/install.sh".source = ./install.sh;
  system.activationScripts.setupInstallerEnvironment = ''
    ln -sf /etc/installer/install.sh /home/nixos/install.sh
    chmod +x /home/nixos/install.sh
  '';

  nixpkgs.hostPlatform = "x86_64-linux";
}

{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../system
  ];

  # boot.kernelPackages = pkgs.linuxPackages_latest;
  services = {
    openssh.enable = true;
    syncthing.enable = true;
    printing.enable = true;
  };

  networking.firewall.allowedTCPPorts = [8765]; # ankiconnect
  virtualisation.docker.enable = true;

  networking.hostId = "5c73541f";

  settings = {
    keyMap = "no";

    networking = {
      enable = true;
      wifi.enable = false;
      bluetooth.enable = false;
    };

    graphics.enable = true;

    japanese.enable = true;
    sound.enable = true;
    utils.enable = true;

    zfs.enable = true;
    zfs.encryption = false;
    zfs.snapshots = true;
    impermanence.enable = true;
  };

  system.stateVersion = "23.11";
}

{ pkgs, lib, config, ... }:

{

  imports = [
    ./nix-daemon.nix
    ./security.nix
    ./sshd.nix
    ./telegraf
    ./users.nix
    ./zfs.nix
  ];

  environment.systemPackages = [
    # for quick activity overview
    pkgs.htop
    # for users with TERM=xterm-termite
    pkgs.termite.terminfo
  ];

  # Nicer interactive shell
  programs.fish.enable = true;
  # And for the zsh peeps
  programs.zsh.enable = true;

  # Entropy gathering daemon
  services.haveged.enable = true;

  security.acme.email = "trash@nix-community.org";
  security.acme.acceptTerms = true;

  # Without configuration this unit will fail...
  # Just disable it since we are using telegraf to monitor raid health.
  systemd.services.mdmonitor.enable = false;

  # enable "sar" system activity collection
  services.sysstat.enable = true;

  # Make debugging failed units easier
  systemd.extraConfig = ''
    DefaultStandardOutput=journal
    DefaultStandardError=journal
  '';

  # The nix-community is global :)
  time.timeZone = "UTC";
}

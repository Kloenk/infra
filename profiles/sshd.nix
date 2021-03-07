{ config, lib, pkgs, ... }:
{
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    useDns = false;
    # unbind gnupg sockets if they exists
    extraConfig = ''
      StreamLocalBindUnlink yes
    '';
  };
}

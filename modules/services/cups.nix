{pkgs, ...}: {
  services = {
    printing = {
      enable = true;
      drivers = [pkgs.cups-dymo];
      browsing = true;
      defaultShared = true;
    };
    avahi = {
      enable = true;
      publish.enable = true;
      publish.userServices = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [631];
    allowedUDPPorts = [631];
  };
}

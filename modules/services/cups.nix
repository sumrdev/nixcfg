{
  services = {
    printing = {
      enable = true;
      browsing = true;
      defaultShared = true;
    };
    avahi = {
      enable = true;
      publish.enable = true;
      publish.userServices = true;
    };
  };
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [631];
    allowedUDPPorts = [631];
  };
}

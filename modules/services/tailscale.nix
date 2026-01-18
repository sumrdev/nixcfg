{
  services.tailscale = {
    enable = true;
    extraUpFlags = [
      "--accept-routes"
      "--reset"
    ];
    useRoutingFeatures = "client";
  };
}

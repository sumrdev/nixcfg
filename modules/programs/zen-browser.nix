{
  lib,
  pkgs,
  inputs,
  ...
}: {
  programs.zen-browser = {
    enable = true;
    policies = {
      # This is a good practice to disable telemetry
      DisableTelemetry = true;
      ExtensionSettings = {
        # uBlock Origin
        "uBlock0@raymondhill.net" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        };
        # Bitwarden
        "{446900e4-71c2-419f-a6ac-ad0f6609e2c6}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
        };
      };
      "extensions.autoDisableScopes" = 0;
    };
  };
}

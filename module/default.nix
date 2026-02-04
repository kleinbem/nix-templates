{
  config,
  lib,
  # _pkgs,
  ...
}:

let
  cfg = config.services.my-service;
in
{
  options.services.my-service = {
    enable = lib.mkEnableOption "my-service";
  };

  config = lib.mkIf cfg.enable {
    # implementation here
  };
}

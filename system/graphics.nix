{
  config,
  lib,
  ...
}: {
  options.settings.nvidia.enable = lib.mkEnableOption "nvidia";
  options.settings.graphics.enable = lib.mkEnableOption "graphics";

  config = lib.mkMerge [
    (lib.mkIf config.settings.graphics.enable {
      hardware.graphics.enable = true;
      hardware.graphics.enable32Bit = true;

      services.xserver.videoDrivers = ["amdgpu"];
    })
    (lib.mkIf config.settings.nvidia.enable {
      settings.graphics.enable = true;

      boot.kernelParams = ["nvidia-drm.fbdev=1"];
      services.xserver.videoDrivers = ["nvidia"];
      hardware.nvidia = {
        modesetting.enable = true;
        open = false;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.latest;
      };
    })
  ];
}

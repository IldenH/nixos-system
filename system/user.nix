{
  pkgs,
  global,
  config,
  ...
}: {
  users.users.${global.user.name} = {
    isNormalUser = true;
    description = global.user.description;
    # initialPassword = "";
    extraGroups = ["wheel"];
    packages = with pkgs; [];
    shell = config.settings.shell;
  };
}

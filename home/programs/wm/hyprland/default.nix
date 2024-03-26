{ config, inputs, pkgs, lib, ... }:

{
	options.settings = {
		hyprland.enable = lib.mkOption {
			type = lib.types.bool;
			default = false;
		};
		wallpaper = lib.mkOption {
			type = lib.types.path;
		};
	};

	imports = [
		./apps.nix
		./binds.nix
		./rules.nix
		./settings.nix
		./screenshots.nix
		./workspaces.nix
	];
	config = lib.mkIf (config.settings.hyprland.enable) {
		home.packages = with pkgs; [
			dunst
			libnotify
			rofi-wayland
			seatd
			swaybg
		];
		wayland.windowManager.hyprland = {
			enable = true;
			package = inputs.hyprland.packages."${pkgs.system}".hyprland;
			xwayland.enable = true;
		};
	};
}

{ config, pkgs, ... }:

{
  imports = [];

  environment.systemPackages = with pkgs; [
    alsaUtils
    alsa-firmware
    vlc
  ];

   hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };
}

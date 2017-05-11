{ config, pkgs, ... }:

{
  imports = [];

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    ldns
  ];

  networking = {
     hostName = "zeta";
     #nameservers = [ "8.8.8.8" "8.8.4.4" ];
     networkmanager.enable = true;
  };

}

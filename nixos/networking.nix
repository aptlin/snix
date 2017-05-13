{ config, pkgs, ... }:

{
  imports = [];

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    ldns
  ];

  networking = {
     hostName = "zeta";
     #nameservers = [ "127.0.0.1" ];
     networkmanager.enable = true;
  };

}

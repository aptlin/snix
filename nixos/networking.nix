{ config, pkgs, ... }:

{
  imports = [];

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    ldns
  ];

  networking = {
     hostName = "zeta";
     #nameservers = [ "8.8.8.8" "8.8.4.4" "208.67.222.222"  "208.67.220.220"  ];
     networkmanager.enable = true;
  };

}

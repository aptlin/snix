{ config, pkgs, ... }:

{
  imports = [];

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    ldns
  ];

  networking = {
     hostName = "zeta";

     nameservers = [
          "217.10.36.5"
          "217.10.44.35"
          "217.10.32.4"          
          "208.67.222.222"
          "208.67.220.220"
          ];
     networkmanager.enable = true;
  };

}

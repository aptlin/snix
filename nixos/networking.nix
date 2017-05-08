{ config, pkgs, ... }:

{
  imports = [];

  networking = {
     hostName = "zeta";
     nameservers = [ "8.8.8.8" "8.8.4.4" ];
     wireless.enable = true; 
     networkmanager.enable = false;
     wicd.enable = false;
     connman.enable = true;
  };

}

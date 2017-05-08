{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    mu
    notmuch
    msmtp
    offlineimap
    sqlite # offlineimap    
  ];

  services.offlineimap = {
    enable  = true;
    install = true;
  };
}
